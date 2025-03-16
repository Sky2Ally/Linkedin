
import React, { useEffect } from 'react';
import Header from '@/components/Header';
import Hero from '@/components/Hero';
import About from '@/components/About';
import Experience from '@/components/Experience';
import Education from '@/components/Education';
import Projects from '@/components/Projects';
import Skills from '@/components/Skills';
import Contact from '@/components/Contact';

const Index = () => {
  useEffect(() => {
    // Cleanup function to remove event listeners
    const cleanupListeners = () => {
      document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.removeEventListener('click', handleAnchorClick);
      });
    };
    
    // Handler for anchor clicks
    const handleAnchorClick = function(e: Event) {
      e.preventDefault();
      const anchor = e.currentTarget as HTMLAnchorElement;
      const targetId = anchor.getAttribute('href')?.substring(1);
      if (targetId) {
        const targetElement = document.getElementById(targetId);
        if (targetElement) {
          targetElement.scrollIntoView({ behavior: 'smooth' });
          // Update URL without page reload
          window.history.pushState(null, '', `#${targetId}`);
        }
      }
    };
    
    // Smooth scroll to section when URL has hash
    if (window.location.hash) {
      setTimeout(() => {
        const id = window.location.hash.substring(1);
        const element = document.getElementById(id);
        if (element) {
          element.scrollIntoView({ behavior: 'smooth' });
        }
      }, 100);
    }
    
    // Add smooth scrolling for all anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
      anchor.addEventListener('click', handleAnchorClick);
    });
    
    // Set page title
    document.title = "Bhuvan Virmani | Data & Business Analyst";
    
    // Cleanup event listeners on component unmount
    return cleanupListeners;
  }, []);

  return (
    <div className="min-h-screen overflow-x-hidden bg-background text-foreground">
      <Header />
      <main>
        <Hero />
        <About />
        <Experience />
        <Education />
        <Projects />
        <Skills />
        <Contact />
      </main>
      <footer className="bg-background py-8 border-t border-border/10">
        <div className="section-container text-center">
          <p className="text-muted-foreground">
            &copy; {new Date().getFullYear()} Bhuvan Virmani. All rights reserved.
          </p>
          <div className="mt-4 flex justify-center gap-6 text-sm text-muted-foreground">
            <a 
              href="https://www.linkedin.com/in/bhuvan-virmani-5510a8219/" 
              target="_blank" 
              rel="noopener noreferrer"
              className="hover:text-accent transition-colors"
            >
              LinkedIn
            </a>
            <a 
              href="https://github.com/Sky2Ally/Linkedin" 
              target="_blank" 
              rel="noopener noreferrer"
              className="hover:text-accent transition-colors"
            >
              GitHub
            </a>
            <a 
              href="https://sky2ally.github.io/Linkedin/" 
              target="_blank" 
              rel="noopener noreferrer"
              className="hover:text-accent transition-colors"
            >
              Resume
            </a>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default Index;
