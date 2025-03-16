
import React from 'react';
import { ChevronDown } from 'lucide-react';
import { Button } from '@/components/ui/button';

const Hero = () => {
  return (
    <section className="relative min-h-screen flex items-center justify-center bg-gradient-to-b from-background via-background to-secondary/10 overflow-hidden">
      <div className="absolute inset-0 z-0 opacity-5">
        <div className="absolute top-1/4 left-1/4 w-64 h-64 rounded-full bg-accent blur-3xl"></div>
        <div className="absolute bottom-1/3 right-1/4 w-80 h-80 rounded-full bg-primary blur-3xl"></div>
      </div>
      
      <div className="section-container relative z-10 flex flex-col items-center text-center gap-6">
        <div className="inline-block px-3 py-1 rounded-full bg-accent/10 text-accent text-sm font-medium tracking-wide mb-2">
          Data Analyst & Business Analyst
        </div>
        
        <h1 className="text-4xl sm:text-5xl md:text-6xl font-bold tracking-tight">
          Bhuvan Virmani
        </h1>
        
        <p className="max-w-3xl text-lg md:text-xl text-foreground/80 leading-relaxed">
          Skilled in transforming complex datasets into actionable business insights with expertise in 
          <span className="text-accent font-medium"> Python</span>,
          <span className="text-accent font-medium"> SQL</span>,
          <span className="text-accent font-medium"> Tableau</span>, and
          <span className="text-accent font-medium"> Power BI</span>.
        </p>
        
        <div className="flex flex-col sm:flex-row gap-4 mt-4">
          <Button asChild size="lg" className="rounded-full px-8 shadow-md">
            <a href="#contact">Get In Touch</a>
          </Button>
          <Button asChild variant="outline" size="lg" className="rounded-full px-8 border-accent/20 hover:bg-accent/5">
            <a href="https://sky2ally.github.io/Linkedin/" target="_blank" rel="noopener noreferrer">View Resume</a>
          </Button>
        </div>
      </div>
      
      <a 
        href="#about"
        className="absolute bottom-12 left-1/2 -translate-x-1/2 text-foreground/70 animate-bounce"
        aria-label="Scroll to About section"
      >
        <ChevronDown className="h-8 w-8" />
      </a>

      <div className="absolute bottom-0 left-0 right-0 h-24 bg-gradient-to-t from-background to-transparent"></div>
    </section>
  );
};

export default Hero;
