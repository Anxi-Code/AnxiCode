import { Moon, Sun } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { useEffect, useState } from 'react';

export const ThemeToggle = () => {
  const [isDark, setIsDark] = useState(true);

  useEffect(() => {
    // Set dark theme by default
    document.documentElement.classList.add('dark');
  }, []);

  const toggleTheme = () => {
    const newIsDark = !isDark;
    setIsDark(newIsDark);
    
    if (newIsDark) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
    
    console.log(`[Theme] Switched to ${newIsDark ? 'dark' : 'light'} mode`);
  };

  return (
    <Button
      variant="ghost"
      size="icon"
      onClick={toggleTheme}
      className="relative overflow-hidden"
      title={`Switch to ${isDark ? 'light' : 'dark'} theme`}
    >
      <Sun
        className={`h-5 w-5 transition-all duration-300 ${
          isDark ? 'rotate-90 scale-0 opacity-0' : 'rotate-0 scale-100 opacity-100'
        }`}
      />
      <Moon
        className={`absolute h-5 w-5 transition-all duration-300 ${
          isDark ? 'rotate-0 scale-100 opacity-100' : '-rotate-90 scale-0 opacity-0'
        }`}
      />
      <span className="sr-only">Toggle theme</span>
    </Button>
  );
};
