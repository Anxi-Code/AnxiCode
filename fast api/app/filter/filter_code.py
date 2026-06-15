#filter_code.py
import re
import ast
from typing import List, Dict, Set, Tuple
from dataclasses import dataclass
from enum import Enum

class Severity(Enum):
    CRITICAL = "CRITICAL"
    HIGH = "HIGH"
    MEDIUM = "MEDIUM"
    LOW = "LOW"

@dataclass
class SecurityViolation:
    line: int
    code: str
    reason: str
    severity: Severity

class CodeSecurityFilter:
    def __init__(self):
        # Critical: System-level commands and dangerous operations
        self.dangerous_imports = {
            'os', 'subprocess', 'sys', 'shutil', 'pty', 'popen',
            'commands', 'cgi', 'cgitb', 'resource', 'signal',
            'multiprocessing', 'threading', 'socket', 'urllib',
            'requests', 'http', 'ftplib', 'telnetlib', 'smtplib',
            'ctypes', 'code', 'codeop', 'compile', 'exec', 'eval',
            'importlib', 'imp', 'marshal', 'pickle', 'shelve',
            'glob', 'tempfile', 'io', 'pathlib',
        }
        
        # Critical: Direct system calls and dangerous functions
        self.dangerous_functions = {
            'eval', 'exec', 'compile', 'open', '__import__',
            'globals', 'locals', 'vars', 'getattr', 'setattr',
            'delattr', 'execfile', 'system', 'popen', 'spawn',
            'fork', 'ptrace', 'kill', 'chmod', 'chown',
            'remove', 'unlink', 'rmdir', 'mkdir', 'symlink',
        }
        
        # Critical: Patterns for system commands
        self.system_command_patterns = [
            r'rm\s+-rf\s+/',
            r'fork\s*bomb',
            r':\(\)\s*{\s*:\|:&\s*}\s*;:',
            r'dd\s+if=/dev/zero',
            r'>\s*/dev/sda',
            r'mkfs\.',
            r'fdisk',
            r'iptables',
            r'shutdown',
            r'reboot',
            r'init\s+[0-6]',
            r'kill\s+-9\s+1',
            r'chmod\s+777',
            r'wget.*\|.*sh',
            r'curl.*\|.*sh',
        ]
        
        # High: Network and resource abuse patterns
        self.network_abuse_patterns = [
            r'while\s+True.*socket',
            r'while\s+True.*requests',
            r'socket\.socket.*while\s+True',
            r'for\s+.*in\s+range\(\d{6,}\)',
        ]
        
        # Medium: Resource exhaustion patterns
        self.resource_exhaustion_patterns = [
            r'range\(\s*\d{7,}\s*\)',
            r'while\s+True\s*:',
            r'\[.*\]\s*\*\s*\d{4,}',
            r'__import__\(\s*[\'"]gc[\'"]\s*\)',
        ]

    def analyze_code(self, code: str) -> Tuple[bool, List[SecurityViolation]]:
        """Main analysis method - checks if code is safe to execute"""
        violations = []
        
        # Layer 1: Pattern matching
        violations.extend(self._check_patterns(code))
        
        # Layer 2: AST analysis
        violations.extend(self._ast_analysis(code))
        
        # Layer 3: Import analysis
        violations.extend(self._check_imports(code))
        
        # Layer 4: Runtime behavior analysis
        violations.extend(self._check_runtime_patterns(code))
        
        is_safe = len([v for v in violations if v.severity in [Severity.CRITICAL, Severity.HIGH]]) == 0
        return is_safe, violations

    def _check_patterns(self, code: str) -> List[SecurityViolation]:
        """Check for dangerous patterns in code"""
        violations = []
        lines = code.split('\n')
        
        for line_num, line in enumerate(lines, 1):
            # Check system commands
            for pattern in self.system_command_patterns:
                if re.search(pattern, line, re.IGNORECASE):
                    violations.append(SecurityViolation(
                        line=line_num,
                        code=line.strip(),
                        reason=f"System command detected: {pattern}",
                        severity=Severity.CRITICAL
                    ))
            
            # Check network abuse
            for pattern in self.network_abuse_patterns:
                if re.search(pattern, line, re.IGNORECASE):
                    violations.append(SecurityViolation(
                        line=line_num,
                        code=line.strip(),
                        reason="Network abuse pattern detected",
                        severity=Severity.HIGH
                    ))
            
            # Check resource exhaustion
            for pattern in self.resource_exhaustion_patterns:
                if re.search(pattern, line, re.IGNORECASE):
                    violations.append(SecurityViolation(
                        line=line_num,
                        code=line.strip(),
                        reason="Resource exhaustion pattern detected",
                        severity=Severity.MEDIUM
                    ))
                    
        return violations

    def _ast_analysis(self, code: str) -> List[SecurityViolation]:
        """Analyze code structure using AST"""
        violations = []
        
        try:
            tree = ast.parse(code)
            
            class SecurityVisitor(ast.NodeVisitor):
                def __init__(self, dangerous_modules, dangerous_functions):
                    self.violations = []
                    self.dangerous_modules = dangerous_modules
                    self.dangerous_functions = dangerous_functions
                
                def visit_Import(self, node):
                    for alias in node.names:
                        if alias.name.split('.')[0] in self.dangerous_modules:
                            self.violations.append(SecurityViolation(
                                line=node.lineno,
                                code=f"import {alias.name}",
                                reason=f"Dangerous import: {alias.name}",
                                severity=Severity.CRITICAL
                            ))
                    self.generic_visit(node)
                
                def visit_ImportFrom(self, node):
                    if node.module and node.module.split('.')[0] in self.dangerous_modules:
                        self.violations.append(SecurityViolation(
                            line=node.lineno,
                            code=f"from {node.module} import ...",
                            reason=f"Dangerous import from: {node.module}",
                            severity=Severity.CRITICAL
                        ))
                    self.generic_visit(node)
                
                def visit_Call(self, node):
                    if isinstance(node.func, ast.Name):
                        if node.func.id in self.dangerous_functions:
                            self.violations.append(SecurityViolation(
                                line=node.lineno,
                                code=f"{node.func.id}()",
                                reason=f"Dangerous function call: {node.func.id}",
                                severity=Severity.CRITICAL
                            ))
                    elif isinstance(node.func, ast.Attribute):
                        if node.func.attr in self.dangerous_functions:
                            self.violations.append(SecurityViolation(
                                line=node.lineno,
                                code=f".{node.func.attr}()",
                                reason=f"Dangerous method call: {node.func.attr}",
                                severity=Severity.CRITICAL
                            ))
                    self.generic_visit(node)
            
            visitor = SecurityVisitor(self.dangerous_imports, self.dangerous_functions)
            visitor.visit(tree)
            violations.extend(visitor.violations)
            
        except SyntaxError as e:
            violations.append(SecurityViolation(
                line=e.lineno or 0,
                code=code[:100] if len(code) > 100 else code,
                reason=f"Syntax error in code: {str(e)}",
                severity=Severity.LOW
            ))
            
        return violations

    def _check_imports(self, code: str) -> List[SecurityViolation]:
        """Check for dangerous imports"""
        violations = []
        
        import_patterns = [
            r'import\s+(\S+)',
            r'from\s+(\S+)\s+import',
            r'__import__\s*\(\s*[\'"](\S+)[\'"]',
        ]
        
        for pattern in import_patterns:
            matches = re.finditer(pattern, code)
            for match in matches:
                module = match.group(1).split('.')[0]
                if module in self.dangerous_imports:
                    line_num = code[:match.start()].count('\n') + 1
                    violations.append(SecurityViolation(
                        line=line_num,
                        code=match.group(0),
                        reason=f"Dangerous module: {module}",
                        severity=Severity.CRITICAL
                    ))
                    
        return violations

    def _check_runtime_patterns(self, code: str) -> List[SecurityViolation]:
        """Check for runtime abuse patterns"""
        violations = []
        
        obfuscation_patterns = [
            r'exec\s*\(\s*.*\\x[0-9a-fA-F]{2}',
            r'eval\s*\(\s*.*\\x[0-9a-fA-F]{2}',
            r'base64\.b64decode',
            r'codecs\.decode',
            r'__builtins__',
            r'\.__class__\.__bases__',
            r'\.__subclasses__\(\)',
        ]
        
        for pattern in obfuscation_patterns:
            matches = re.finditer(pattern, code)
            for match in matches:
                line_num = code[:match.start()].count('\n') + 1
                violations.append(SecurityViolation(
                    line=line_num,
                    code=match.group(0),
                    reason="Potential code obfuscation or manipulation detected",
                    severity=Severity.HIGH
                ))
                
        return violations