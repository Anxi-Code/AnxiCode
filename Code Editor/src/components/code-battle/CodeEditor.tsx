import { useState, useRef, useCallback, useMemo, useEffect } from 'react';
import { cn } from '@/lib/utils';

// CHANGE HERE for dynamic language switching - Add/modify languages here
export type SupportedLanguage = 'python' | 'cpp' | 'java' | 'javascript';

interface CodeEditorProps {
  initialCode?: string;
  className?: string;
  // CHANGE HERE for dynamic language switching - Pass language prop
  language?: SupportedLanguage;
  onCodeChange?: (code: string) => void;
}

// CHANGE HERE for dynamic language switching - Starter templates for each language
const STARTER_TEMPLATES: Record<SupportedLanguage, string> = {
  python: `def two_sum(nums, target):
    """
    Find two numbers that add up to target.
    Return their indices.
    """
    seen = {}
    
    for i, num in enumerate(nums):
        complement = target - num
        if complement in seen:
            return [seen[complement], i]
        seen[num] = i
    
    return []


if __name__ == "__main__":
    nums = [2, 7, 11, 15]
    target = 9
    result = two_sum(nums, target)
    print(f"Result: {result}")
`,
  cpp: `#include <iostream>
#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        unordered_map<int, int> seen;
        
        for (int i = 0; i < nums.size(); i++) {
            int complement = target - nums[i];
            if (seen.find(complement) != seen.end()) {
                return {seen[complement], i};
            }
            seen[nums[i]] = i;
        }
        return {};
    }
};

int main() {
    Solution sol;
    vector<int> nums = {2, 7, 11, 15};
    int target = 9;
    auto result = sol.twoSum(nums, target);
    cout << "Result: [" << result[0] << ", " << result[1] << "]" << endl;
    return 0;
}
`,
  java: `import java.util.HashMap;
import java.util.Map;

class Solution {
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> seen = new HashMap<>();
        
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (seen.containsKey(complement)) {
                return new int[] {seen.get(complement), i};
            }
            seen.put(nums[i], i);
        }
        return new int[] {};
    }
    
    public static void main(String[] args) {
        Solution sol = new Solution();
        int[] nums = {2, 7, 11, 15};
        int[] result = sol.twoSum(nums, 9);
        System.out.println("Result: [" + result[0] + ", " + result[1] + "]");
    }
}
`,
  javascript: `function twoSum(nums, target) {
    /**
     * Find two numbers that add up to target.
     * Return their indices.
     */
    const seen = new Map();
    
    for (let i = 0; i < nums.length; i++) {
        const complement = target - nums[i];
        if (seen.has(complement)) {
            return [seen.get(complement), i];
        }
        seen.set(nums[i], i);
    }
    return [];
}

// Test the solution
const nums = [2, 7, 11, 15];
const target = 9;
const result = twoSum(nums, target);
console.log("Result:", result);
`
};

// CHANGE HERE for dynamic language switching - Language keywords and builtins for syntax highlighting
const LANGUAGE_KEYWORDS: Record<SupportedLanguage, { keywords: string[]; builtins: string[] }> = {
  python: {
    keywords: ['def', 'return', 'if', 'else', 'elif', 'for', 'while', 'in', 'not', 'and', 'or',
      'True', 'False', 'None', 'import', 'from', 'class', 'try', 'except', 'finally',
      'with', 'as', 'lambda', 'pass', 'break', 'continue', 'global', 'nonlocal', 'assert'],
    builtins: ['print', 'len', 'range', 'enumerate', 'list', 'dict', 'set', 'int', 'str', 'float', 'bool', 'map', 'filter', 'zip', 'sorted', 'reversed', 'sum', 'min', 'max', 'abs', 'input', 'open', 'type', 'isinstance']
  },
  cpp: {
    keywords: ['int', 'float', 'double', 'char', 'void', 'bool', 'return', 'if', 'else', 'for', 'while',
      'do', 'switch', 'case', 'break', 'continue', 'class', 'struct', 'public', 'private', 'protected',
      'virtual', 'override', 'const', 'static', 'new', 'delete', 'nullptr', 'true', 'false',
      'include', 'using', 'namespace', 'template', 'typename', 'auto', 'sizeof'],
    builtins: ['cout', 'cin', 'endl', 'vector', 'string', 'map', 'unordered_map', 'set', 'unordered_set', 'pair', 'size', 'push_back', 'pop_back', 'find', 'begin', 'end', 'sort', 'reverse', 'swap']
  },
  java: {
    keywords: ['public', 'private', 'protected', 'class', 'interface', 'extends', 'implements',
      'static', 'final', 'void', 'int', 'float', 'double', 'boolean', 'char', 'String',
      'return', 'if', 'else', 'for', 'while', 'do', 'switch', 'case', 'break', 'continue',
      'new', 'this', 'super', 'null', 'true', 'false', 'try', 'catch', 'finally', 'throw', 'throws', 'import', 'package'],
    builtins: ['System', 'out', 'println', 'print', 'length', 'HashMap', 'Map', 'List', 'ArrayList', 'Arrays', 'Math', 'Integer', 'Double', 'Boolean', 'Character', 'StringBuilder', 'toString', 'equals', 'compareTo']
  },
  javascript: {
    keywords: ['const', 'let', 'var', 'function', 'return', 'if', 'else', 'for', 'while', 'do',
      'switch', 'case', 'break', 'continue', 'class', 'extends', 'new', 'this', 'super',
      'null', 'undefined', 'true', 'false', 'try', 'catch', 'finally', 'throw', 'async', 'await',
      'import', 'export', 'default', 'from', 'of', 'in', 'typeof', 'instanceof'],
    builtins: ['console', 'log', 'warn', 'error', 'Math', 'Array', 'Object', 'String', 'Number', 'Boolean', 'Map', 'Set', 'Promise', 'JSON', 'parse', 'stringify', 'push', 'pop', 'shift', 'unshift', 'slice', 'splice', 'forEach', 'map', 'filter', 'reduce', 'find', 'includes', 'indexOf', 'join', 'split', 'replace', 'trim', 'toLowerCase', 'toUpperCase', 'setTimeout', 'setInterval', 'fetch']
  }
};

// INTELLISENSE - Autocomplete suggestions for each language
const AUTOCOMPLETE_SUGGESTIONS: Record<SupportedLanguage, { name: string; snippet: string; description: string }[]> = {
  python: [
    { name: 'print', snippet: 'print()', description: 'Print to console' },
    { name: 'len', snippet: 'len()', description: 'Get length of object' },
    { name: 'range', snippet: 'range()', description: 'Generate range of numbers' },
    { name: 'enumerate', snippet: 'enumerate()', description: 'Enumerate iterable' },
    { name: 'def', snippet: 'def function_name():\n    pass', description: 'Define function' },
    { name: 'class', snippet: 'class ClassName:\n    def __init__(self):\n        pass', description: 'Define class' },
    { name: 'for', snippet: 'for i in range():\n    ', description: 'For loop' },
    { name: 'while', snippet: 'while condition:\n    ', description: 'While loop' },
    { name: 'if', snippet: 'if condition:\n    ', description: 'If statement' },
    { name: 'elif', snippet: 'elif condition:\n    ', description: 'Elif statement' },
    { name: 'else', snippet: 'else:\n    ', description: 'Else statement' },
    { name: 'try', snippet: 'try:\n    \nexcept Exception as e:\n    ', description: 'Try-except block' },
    { name: 'with', snippet: 'with open() as f:\n    ', description: 'With statement' },
    { name: 'lambda', snippet: 'lambda x: ', description: 'Lambda function' },
    { name: 'list', snippet: 'list()', description: 'Create list' },
    { name: 'dict', snippet: 'dict()', description: 'Create dictionary' },
    { name: 'set', snippet: 'set()', description: 'Create set' },
    { name: 'sorted', snippet: 'sorted()', description: 'Sort iterable' },
    { name: 'map', snippet: 'map(function, iterable)', description: 'Map function' },
    { name: 'filter', snippet: 'filter(function, iterable)', description: 'Filter function' },
    { name: 'input', snippet: 'input()', description: 'Get user input' },
    { name: 'int', snippet: 'int()', description: 'Convert to integer' },
    { name: 'str', snippet: 'str()', description: 'Convert to string' },
    { name: 'float', snippet: 'float()', description: 'Convert to float' },
  ],
  cpp: [
    { name: 'cout', snippet: 'cout << ', description: 'Output to console' },
    { name: 'cin', snippet: 'cin >> ', description: 'Input from console' },
    { name: 'endl', snippet: 'endl', description: 'End line' },
    { name: 'vector', snippet: 'vector<int> ', description: 'Vector container' },
    { name: 'string', snippet: 'string ', description: 'String type' },
    { name: 'map', snippet: 'map<int, int> ', description: 'Map container' },
    { name: 'unordered_map', snippet: 'unordered_map<int, int> ', description: 'Hash map' },
    { name: 'set', snippet: 'set<int> ', description: 'Set container' },
    { name: 'for', snippet: 'for (int i = 0; i < n; i++) {\n    \n}', description: 'For loop' },
    { name: 'while', snippet: 'while (condition) {\n    \n}', description: 'While loop' },
    { name: 'if', snippet: 'if (condition) {\n    \n}', description: 'If statement' },
    { name: 'else', snippet: 'else {\n    \n}', description: 'Else statement' },
    { name: 'class', snippet: 'class ClassName {\npublic:\n    \n};', description: 'Class definition' },
    { name: 'struct', snippet: 'struct StructName {\n    \n};', description: 'Struct definition' },
    { name: 'push_back', snippet: 'push_back()', description: 'Add element to vector' },
    { name: 'size', snippet: 'size()', description: 'Get container size' },
    { name: 'sort', snippet: 'sort(v.begin(), v.end())', description: 'Sort container' },
    { name: 'find', snippet: 'find()', description: 'Find element' },
    { name: 'pair', snippet: 'pair<int, int> ', description: 'Pair type' },
    { name: 'make_pair', snippet: 'make_pair()', description: 'Create pair' },
  ],
  java: [
    { name: 'System.out.println', snippet: 'System.out.println()', description: 'Print to console' },
    { name: 'System.out.print', snippet: 'System.out.print()', description: 'Print without newline' },
    { name: 'public', snippet: 'public ', description: 'Public modifier' },
    { name: 'private', snippet: 'private ', description: 'Private modifier' },
    { name: 'class', snippet: 'class ClassName {\n    \n}', description: 'Class definition' },
    { name: 'public static void main', snippet: 'public static void main(String[] args) {\n    \n}', description: 'Main method' },
    { name: 'for', snippet: 'for (int i = 0; i < n; i++) {\n    \n}', description: 'For loop' },
    { name: 'foreach', snippet: 'for (Type item : collection) {\n    \n}', description: 'Enhanced for loop' },
    { name: 'while', snippet: 'while (condition) {\n    \n}', description: 'While loop' },
    { name: 'if', snippet: 'if (condition) {\n    \n}', description: 'If statement' },
    { name: 'else', snippet: 'else {\n    \n}', description: 'Else statement' },
    { name: 'try', snippet: 'try {\n    \n} catch (Exception e) {\n    \n}', description: 'Try-catch block' },
    { name: 'HashMap', snippet: 'HashMap<Integer, Integer> map = new HashMap<>();', description: 'Create HashMap' },
    { name: 'ArrayList', snippet: 'ArrayList<Integer> list = new ArrayList<>();', description: 'Create ArrayList' },
    { name: 'Arrays.sort', snippet: 'Arrays.sort()', description: 'Sort array' },
    { name: 'String', snippet: 'String ', description: 'String type' },
    { name: 'Integer', snippet: 'Integer ', description: 'Integer wrapper' },
    { name: 'toString', snippet: 'toString()', description: 'Convert to string' },
    { name: 'equals', snippet: 'equals()', description: 'Check equality' },
  ],
  javascript: [
    { name: 'console.log', snippet: 'console.log()', description: 'Log to console' },
    { name: 'console.error', snippet: 'console.error()', description: 'Log error' },
    { name: 'console.warn', snippet: 'console.warn()', description: 'Log warning' },
    { name: 'const', snippet: 'const name = ', description: 'Constant declaration' },
    { name: 'let', snippet: 'let name = ', description: 'Variable declaration' },
    { name: 'function', snippet: 'function name() {\n    \n}', description: 'Function declaration' },
    { name: 'arrow', snippet: 'const name = () => {\n    \n}', description: 'Arrow function' },
    { name: 'async', snippet: 'async function name() {\n    \n}', description: 'Async function' },
    { name: 'await', snippet: 'await ', description: 'Await promise' },
    { name: 'for', snippet: 'for (let i = 0; i < n; i++) {\n    \n}', description: 'For loop' },
    { name: 'forEach', snippet: 'forEach((item) => {\n    \n})', description: 'forEach loop' },
    { name: 'map', snippet: 'map((item) => )', description: 'Map array' },
    { name: 'filter', snippet: 'filter((item) => )', description: 'Filter array' },
    { name: 'reduce', snippet: 'reduce((acc, item) => , initialValue)', description: 'Reduce array' },
    { name: 'if', snippet: 'if (condition) {\n    \n}', description: 'If statement' },
    { name: 'else', snippet: 'else {\n    \n}', description: 'Else statement' },
    { name: 'try', snippet: 'try {\n    \n} catch (error) {\n    \n}', description: 'Try-catch block' },
    { name: 'fetch', snippet: 'fetch(url).then(res => res.json())', description: 'Fetch API' },
    { name: 'Promise', snippet: 'new Promise((resolve, reject) => {\n    \n})', description: 'Create Promise' },
    { name: 'setTimeout', snippet: 'setTimeout(() => {\n    \n}, ms)', description: 'Set timeout' },
    { name: 'JSON.parse', snippet: 'JSON.parse()', description: 'Parse JSON' },
    { name: 'JSON.stringify', snippet: 'JSON.stringify()', description: 'Stringify to JSON' },
  ]
};

// Syntax highlighter
const highlightCode = (code: string, gutterWidth: number, activeLine: number | null, language: SupportedLanguage): JSX.Element[] => {
  const { keywords, builtins } = LANGUAGE_KEYWORDS[language];
  const lines = code.split('\n');
  const commentPattern = language === 'python' ? /^(#.*)/ : /^(\/\/.*)|(\/\*[\s\S]*?\*\/)/;
  
  return lines.map((line, lineIndex) => {
    const tokens: JSX.Element[] = [];
    let remaining = line;
    let keyIndex = 0;
    const isActive = activeLine === lineIndex + 1;

    while (remaining.length > 0) {
      const commentMatch = remaining.match(commentPattern);
      if (commentMatch) {
        const matched = commentMatch[1] || commentMatch[2] || commentMatch[0];
        tokens.push(<span key={`${lineIndex}-${keyIndex++}`} className="text-syntax-comment italic">{matched}</span>);
        remaining = remaining.slice(matched.length);
        continue;
      }

      if (language === 'python') {
        const tripleStringMatch = remaining.match(/^("""[\s\S]*?"""|'''[\s\S]*?''')/);
        if (tripleStringMatch) {
          tokens.push(<span key={`${lineIndex}-${keyIndex++}`} className="text-syntax-string">{tripleStringMatch[1]}</span>);
          remaining = remaining.slice(tripleStringMatch[1].length);
          continue;
        }
      }

      const stringMatch = remaining.match(/^(["'`](?:[^"'`\\]|\\.)*["'`])/);
      if (stringMatch) {
        tokens.push(<span key={`${lineIndex}-${keyIndex++}`} className="text-syntax-string">{stringMatch[1]}</span>);
        remaining = remaining.slice(stringMatch[1].length);
        continue;
      }

      if (language === 'python') {
        const fstringMatch = remaining.match(/^(f["'](?:[^"'\\]|\\.)*["'])/);
        if (fstringMatch) {
          tokens.push(<span key={`${lineIndex}-${keyIndex++}`} className="text-syntax-string">{fstringMatch[1]}</span>);
          remaining = remaining.slice(fstringMatch[1].length);
          continue;
        }
      }

      if (language === 'cpp') {
        const preprocessorMatch = remaining.match(/^(#\w+)/);
        if (preprocessorMatch) {
          tokens.push(<span key={`${lineIndex}-${keyIndex++}`} className="text-syntax-keyword font-semibold">{preprocessorMatch[1]}</span>);
          remaining = remaining.slice(preprocessorMatch[1].length);
          continue;
        }
      }

      const numberMatch = remaining.match(/^(\d+\.?\d*)/);
      if (numberMatch) {
        tokens.push(<span key={`${lineIndex}-${keyIndex++}`} className="text-syntax-number">{numberMatch[1]}</span>);
        remaining = remaining.slice(numberMatch[1].length);
        continue;
      }

      const wordMatch = remaining.match(/^([a-zA-Z_]\w*)/);
      if (wordMatch) {
        const word = wordMatch[1];
        if (keywords.includes(word)) {
          tokens.push(<span key={`${lineIndex}-${keyIndex++}`} className="text-syntax-keyword font-semibold">{word}</span>);
        } else if (builtins.includes(word)) {
          tokens.push(<span key={`${lineIndex}-${keyIndex++}`} className="text-syntax-function">{word}</span>);
        } else if (remaining[word.length] === '(') {
          tokens.push(<span key={`${lineIndex}-${keyIndex++}`} className="text-syntax-function">{word}</span>);
        } else {
          tokens.push(<span key={`${lineIndex}-${keyIndex++}`} className="text-syntax-variable">{word}</span>);
        }
        remaining = remaining.slice(word.length);
        continue;
      }

      tokens.push(<span key={`${lineIndex}-${keyIndex++}`} className="text-foreground">{remaining[0]}</span>);
      remaining = remaining.slice(1);
    }

    // FIX: Cursor alignment - Line rendering matches textarea padding exactly
    return (
      <div key={lineIndex} className={cn("flex transition-colors duration-150", isActive && "bg-primary/10")}>
        <span 
          className={cn("select-none text-right pr-4 transition-colors duration-150 shrink-0", isActive ? "text-primary" : "text-editor-gutter")}
          style={{ width: `${gutterWidth + 1}ch`, minWidth: `${gutterWidth + 1}ch` }}
        >
          {lineIndex + 1}
        </span>
        <span className="flex-1 whitespace-pre" style={{ tabSize: 4 }}>{tokens.length > 0 ? tokens : ' '}</span>
      </div>
    );
  });
};

const AUTO_CLOSE_PAIRS: Record<string, string> = { '(': ')', '[': ']', '{': '}', '"': '"', "'": "'", '`': '`' };

export const CodeEditor = ({ initialCode, className, language = 'python', onCodeChange }: CodeEditorProps) => {
  const [code, setCode] = useState(initialCode || STARTER_TEMPLATES[language]);
  const [activeLine, setActiveLine] = useState<number | null>(null);
  const textareaRef = useRef<HTMLTextAreaElement>(null);
  const preRef = useRef<HTMLPreElement>(null);
  
  // INTELLISENSE - Autocomplete state
  const [showSuggestions, setShowSuggestions] = useState(false);
  const [suggestions, setSuggestions] = useState<{ name: string; snippet: string; description: string }[]>([]);
  const [selectedSuggestion, setSelectedSuggestion] = useState(0);
  const [suggestionPosition, setSuggestionPosition] = useState({ top: 0, left: 0 });
  const [currentWord, setCurrentWord] = useState('');

  useEffect(() => {
    if (!initialCode) {
      setCode(STARTER_TEMPLATES[language]);
    }
  }, [language, initialCode]);

  useEffect(() => {
    onCodeChange?.(code);
  }, [code, onCodeChange]);

  const lineCount = useMemo(() => code.split('\n').length, [code]);
  // FIX: Cursor alignment - gutter width calculation for proper cursor positioning
  const gutterWidth = useMemo(() => Math.max(2, String(lineCount).length), [lineCount]);

  const handleScroll = useCallback(() => {
    if (textareaRef.current && preRef.current) {
      preRef.current.scrollTop = textareaRef.current.scrollTop;
      preRef.current.scrollLeft = textareaRef.current.scrollLeft;
    }
    setShowSuggestions(false);
  }, []);

  // INTELLISENSE - Get current word being typed
  const getCurrentWord = useCallback((text: string, cursorPos: number) => {
    const beforeCursor = text.substring(0, cursorPos);
    const match = beforeCursor.match(/[a-zA-Z_]\w*$/);
    return match ? match[0] : '';
  }, []);

  // INTELLISENSE - Filter suggestions based on current word
  const filterSuggestions = useCallback((word: string) => {
    if (word.length < 1) {
      setShowSuggestions(false);
      return;
    }
    const filtered = AUTOCOMPLETE_SUGGESTIONS[language].filter(s => 
      s.name.toLowerCase().startsWith(word.toLowerCase())
    ).slice(0, 8);
    
    if (filtered.length > 0) {
      setSuggestions(filtered);
      setSelectedSuggestion(0);
      setShowSuggestions(true);
    } else {
      setShowSuggestions(false);
    }
  }, [language]);

  // INTELLISENSE - Calculate suggestion popup position
  const updateSuggestionPosition = useCallback(() => {
    if (!textareaRef.current) return;
    const textarea = textareaRef.current;
    const cursorPos = textarea.selectionStart;
    const textBeforeCursor = code.substring(0, cursorPos);
    const lines = textBeforeCursor.split('\n');
    const currentLineNumber = lines.length;
    const currentCol = lines[lines.length - 1].length;
    
    const lineHeight = 24;
    const charWidth = 8.4;
    const gutterOffset = (gutterWidth + 2) * charWidth;
    
    setSuggestionPosition({
      top: (currentLineNumber * lineHeight) + 16 - textarea.scrollTop,
      left: (currentCol * charWidth) + gutterOffset + 16 - textarea.scrollLeft
    });
  }, [code, gutterWidth]);

  // INTELLISENSE - Insert suggestion
  const insertSuggestion = useCallback((suggestion: { name: string; snippet: string }) => {
    if (!textareaRef.current) return;
    const textarea = textareaRef.current;
    const cursorPos = textarea.selectionStart;
    const wordStart = cursorPos - currentWord.length;
    
    const newCode = code.substring(0, wordStart) + suggestion.snippet + code.substring(cursorPos);
    setCode(newCode);
    setShowSuggestions(false);
    
    // FIX: Cursor & selection logic - Set cursor after inserted text
    const newCursorPos = wordStart + suggestion.snippet.length;
    requestAnimationFrame(() => {
      if (textareaRef.current) {
        textareaRef.current.focus();
        textareaRef.current.setSelectionRange(newCursorPos, newCursorPos);
      }
    });
  }, [code, currentWord]);

  const handleKeyDown = useCallback((e: React.KeyboardEvent<HTMLTextAreaElement>) => {
    const textarea = e.currentTarget;
    const start = textarea.selectionStart;
    const end = textarea.selectionEnd;
    const value = textarea.value;

    // INTELLISENSE - Handle suggestion navigation
    if (showSuggestions) {
      if (e.key === 'ArrowDown') {
        e.preventDefault();
        setSelectedSuggestion(prev => Math.min(prev + 1, suggestions.length - 1));
        return;
      }
      if (e.key === 'ArrowUp') {
        e.preventDefault();
        setSelectedSuggestion(prev => Math.max(prev - 1, 0));
        return;
      }
      if (e.key === 'Enter' || e.key === 'Tab') {
        e.preventDefault();
        insertSuggestion(suggestions[selectedSuggestion]);
        return;
      }
      if (e.key === 'Escape') {
        e.preventDefault();
        setShowSuggestions(false);
        return;
      }
    }

    // Tab indentation
    if (e.key === 'Tab' && !showSuggestions) {
      e.preventDefault();
      const newCode = value.substring(0, start) + '    ' + value.substring(end);
      setCode(newCode);
      requestAnimationFrame(() => {
        textarea.setSelectionRange(start + 4, start + 4);
      });
      return;
    }

    // Auto-closing brackets
    if (AUTO_CLOSE_PAIRS[e.key]) {
      e.preventDefault();
      const closeChar = AUTO_CLOSE_PAIRS[e.key];
      const selectedText = value.substring(start, end);
      
      if (selectedText) {
        const newCode = value.substring(0, start) + e.key + selectedText + closeChar + value.substring(end);
        setCode(newCode);
        requestAnimationFrame(() => {
          textarea.setSelectionRange(start + 1, end + 1);
        });
      } else {
        const newCode = value.substring(0, start) + e.key + closeChar + value.substring(end);
        setCode(newCode);
        requestAnimationFrame(() => {
          textarea.setSelectionRange(start + 1, start + 1);
        });
      }
      return;
    }

    // Auto-indent on Enter
    if (e.key === 'Enter' && !showSuggestions) {
      e.preventDefault();
      const lineStart = value.lastIndexOf('\n', start - 1) + 1;
      const currentLine = value.substring(lineStart, start);
      const indentMatch = currentLine.match(/^(\s*)/);
      let indent = indentMatch ? indentMatch[1] : '';
      const lastChar = value.substring(start - 1, start);
      if (['{', '[', '(', ':'].includes(lastChar)) {
        indent += '    ';
      }
      const newCode = value.substring(0, start) + '\n' + indent + value.substring(end);
      const newPos = start + 1 + indent.length;
      setCode(newCode);
      requestAnimationFrame(() => {
        textarea.setSelectionRange(newPos, newPos);
      });
      return;
    }

    // Skip closing bracket if already there
    if ([')', ']', '}', '"', "'", '`'].includes(e.key) && value[start] === e.key) {
      e.preventDefault();
      requestAnimationFrame(() => {
        textarea.setSelectionRange(start + 1, start + 1);
      });
      return;
    }

    // Backspace removes pair
    if (e.key === 'Backspace' && start === end && start > 0) {
      const charBefore = value[start - 1];
      const charAfter = value[start];
      if (AUTO_CLOSE_PAIRS[charBefore] === charAfter) {
        e.preventDefault();
        const newCode = value.substring(0, start - 1) + value.substring(start + 1);
        setCode(newCode);
        requestAnimationFrame(() => {
          textarea.setSelectionRange(start - 1, start - 1);
        });
        return;
      }
    }
  }, [showSuggestions, suggestions, selectedSuggestion, insertSuggestion]);

  // FIX: Cursor & selection logic - Direct change handler without controlled cursor manipulation
  const handleChange = useCallback((e: React.ChangeEvent<HTMLTextAreaElement>) => {
    const newValue = e.target.value;
    const cursorPos = e.target.selectionStart;
    setCode(newValue);
    
    // INTELLISENSE - Update suggestions
    const word = getCurrentWord(newValue, cursorPos);
    setCurrentWord(word);
    filterSuggestions(word);
    updateSuggestionPosition();
  }, [getCurrentWord, filterSuggestions, updateSuggestionPosition]);

  const handleCursorChange = useCallback(() => {
    if (textareaRef.current) {
      const cursorPos = textareaRef.current.selectionStart;
      const textBeforeCursor = code.substring(0, cursorPos);
      const currentLine = textBeforeCursor.split('\n').length;
      setActiveLine(currentLine);
      
      // INTELLISENSE - Update current word
      const word = getCurrentWord(code, cursorPos);
      setCurrentWord(word);
      if (word.length >= 1) {
        filterSuggestions(word);
        updateSuggestionPosition();
      } else {
        setShowSuggestions(false);
      }
    }
  }, [code, getCurrentWord, filterSuggestions, updateSuggestionPosition]);

  const highlightedCode = useMemo(() => {
    return highlightCode(code, gutterWidth, activeLine, language);
  }, [code, gutterWidth, activeLine, language]);

  return (
    <div className={cn(
      "relative h-full bg-editor rounded-lg overflow-hidden",
      "border border-border/50 shadow-lg",
      "transition-shadow duration-300 hover:shadow-xl",
      className
    )}>
      {/* Line highlight effect */}
      <div className="absolute inset-0 pointer-events-none opacity-50">
        <div 
          className="absolute left-0 right-0 h-6 bg-primary/5 transition-all duration-150"
          style={{ top: activeLine ? `calc(1rem + ${(activeLine - 1) * 1.5}rem)` : '-100px', opacity: activeLine ? 1 : 0 }}
        />
      </div>

      {/* Highlighted code display */}
      <pre ref={preRef} className="absolute inset-0 p-4 font-mono text-sm leading-6 overflow-auto pointer-events-none editor-scrollbar" aria-hidden="true">
        <code className="block">{highlightedCode}</code>
      </pre>

      {/* FIX: Cursor & selection logic - Textarea aligned exactly with highlighted code */}
      <textarea
        ref={textareaRef}
        value={code}
        onChange={handleChange}
        onScroll={handleScroll}
        onKeyDown={handleKeyDown}
        onClick={handleCursorChange}
        onKeyUp={handleCursorChange}
        onSelect={handleCursorChange}
        onBlur={() => setTimeout(() => setShowSuggestions(false), 200)}
        className={cn(
          "absolute inset-0 w-full h-full p-4 font-mono text-sm leading-6",
          "bg-transparent text-transparent caret-primary",
          "resize-none outline-none selection:bg-primary/30",
          "editor-scrollbar",
          "whitespace-pre"
        )}
        style={{ 
          // FIX: Cursor alignment - must match: p-4 (1rem) + gutter width + pr-4 (1rem)
          paddingLeft: `calc(1rem + ${gutterWidth + 1}ch)`,
          tabSize: 4,
          MozTabSize: 4
        } as React.CSSProperties}
        spellCheck={false}
        autoCapitalize="off"
        autoComplete="off"
        autoCorrect="off"
        data-gramm="false"
      />

      {/* INTELLISENSE - Autocomplete dropdown */}
      {showSuggestions && suggestions.length > 0 && (
        <div 
          className="absolute z-50 bg-card border border-border rounded-lg shadow-xl overflow-hidden min-w-[280px] max-w-[400px]"
          style={{ top: suggestionPosition.top, left: Math.min(suggestionPosition.left, 400) }}
        >
          {suggestions.map((suggestion, index) => (
            <div
              key={suggestion.name}
              className={cn(
                "px-3 py-2 cursor-pointer flex items-center justify-between gap-4 transition-colors",
                index === selectedSuggestion ? "bg-primary/20 text-primary" : "hover:bg-muted"
              )}
              onClick={() => insertSuggestion(suggestion)}
              onMouseEnter={() => setSelectedSuggestion(index)}
            >
              <div className="flex items-center gap-2">
                <span className="text-syntax-function font-mono text-sm">{suggestion.name}</span>
              </div>
              <span className="text-xs text-muted-foreground truncate">{suggestion.description}</span>
            </div>
          ))}
          <div className="px-3 py-1.5 bg-muted/50 text-xs text-muted-foreground border-t border-border">
            ↑↓ navigate • Tab/Enter select • Esc close
          </div>
        </div>
      )}
    </div>
  );
};

// PLAYER 1 CODE ACCESS HERE
// PLAYER 2 CODE ACCESS HERE  
// TEAM SUBMISSION LOGIC HERE
// SAVE CODE TO TEMP FILES HERE (if needed)
export const getEditorCode = (editorRef: React.RefObject<HTMLTextAreaElement>): string => {
  return editorRef.current?.value || '';
};