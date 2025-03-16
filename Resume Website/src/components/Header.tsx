
import React, { useState, useEffect } from 'react';
import { cn } from '@/lib/utils';
import { Download, Menu, X } from 'lucide-react';
import { Button } from '@/components/ui/button';

const Header = () => {
  const [isScrolled, setIsScrolled] = useState(false);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 50);
    };

    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const navItems = [
    { name: 'About', href: '#about' },
    { name: 'Experience', href: '#experience' },
    { name: 'Education', href: '#education' },
    { name: 'Projects', href: '#projects' },
    { name: 'Skills', href: '#skills' },
    { name: 'Contact', href: '#contact' },
  ];

  return (
    <header
      className={cn(
        'fixed top-0 left-0 right-0 z-50 transition-all duration-300 py-4',
        isScrolled
          ? 'bg-background/80 backdrop-blur-md shadow-sm'
          : 'bg-transparent'
      )}
    >
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center">
          <a
            href="#"
            className="text-xl font-bold text-foreground tracking-tight"
          >
            Bhuvan<span className="text-accent">.</span>
          </a>

          {/* Desktop Navigation */}
          <nav className="hidden md:flex items-center space-x-8">
            {navItems.map((item) => (
              <a
                key={item.name}
                href={item.href}
                className="text-sm font-medium text-foreground/80 hover:text-accent transition-colors duration-200 py-2"
              >
                {item.name}
              </a>
            ))}
            <Button asChild size="sm" className="ml-4 shadow-sm">
              <a href="https://sky2ally.github.io/Linkedin/" target="_blank" rel="noopener noreferrer">
                <Download className="mr-2 h-4 w-4" />
                Resume
              </a>
            </Button>
          </nav>

          {/* Mobile Menu Button */}
          <button
            className="md:hidden text-foreground"
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
            aria-label={mobileMenuOpen ? "Close menu" : "Open menu"}
          >
            {mobileMenuOpen ? (
              <X className="h-6 w-6" />
            ) : (
              <Menu className="h-6 w-6" />
            )}
          </button>
        </div>
      </div>

      {/* Mobile Navigation */}
      <div
        className={cn(
          'fixed inset-0 bg-background/95 backdrop-blur-sm flex flex-col pt-24 px-4 md:hidden z-40 transition-all duration-300 ease-in-out',
          mobileMenuOpen
            ? 'opacity-100 translate-y-0'
            : 'opacity-0 -translate-y-full pointer-events-none'
        )}
      >
        <div className="flex flex-col space-y-4">
          {navItems.map((item) => (
            <a
              key={item.name}
              href={item.href}
              className="text-lg font-medium py-2 border-b border-border/20"
              onClick={() => setMobileMenuOpen(false)}
            >
              {item.name}
            </a>
          ))}
          <Button asChild className="mt-4">
            <a href="https://sky2ally.github.io/Linkedin/" target="_blank" rel="noopener noreferrer">
              <Download className="mr-2 h-4 w-4" />
              Download Resume
            </a>
          </Button>
        </div>
      </div>
    </header>
  );
};

export default Header;
