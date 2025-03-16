
import React, { useState } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { ChevronDown, ChevronUp } from 'lucide-react';
import { cn } from '@/lib/utils';

type ProjectCardProps = {
  title: string;
  description: string;
  details: string[];
  technologies: string[];
  index: number;
};

const ProjectCard = ({ title, description, details, technologies, index }: ProjectCardProps) => {
  const [isExpanded, setIsExpanded] = useState(false);

  return (
    <Card 
      className={cn(
        "border border-border/40 overflow-hidden transition-all duration-300 animate-scale-in",
        isExpanded ? "shadow-lg" : "hover:shadow-md",
      )}
      style={{animationDelay: `${index * 100}ms`}}
    >
      <CardHeader className="pb-3">
        <CardTitle className="text-xl flex justify-between items-start">
          <span>{title}</span>
          <button 
            onClick={() => setIsExpanded(!isExpanded)}
            className="text-muted-foreground hover:text-foreground transition-colors p-1"
          >
            {isExpanded ? <ChevronUp size={18} /> : <ChevronDown size={18} />}
          </button>
        </CardTitle>
        <CardDescription>{description}</CardDescription>
      </CardHeader>
      <CardContent>
        <div className={cn(
          "grid gap-4 transition-all duration-300 ease-in-out",
          isExpanded ? "grid-rows-[1fr]" : "grid-rows-[0fr]"
        )}>
          <div className={cn(
            "overflow-hidden transition-all duration-300",
            isExpanded ? "opacity-100 mt-3" : "opacity-0"
          )}>
            <ul className="list-disc pl-5 space-y-2 text-foreground/80 mb-4">
              {details.map((detail, i) => (
                <li key={i}>{detail}</li>
              ))}
            </ul>
          </div>
        </div>
        
        <div className="flex flex-wrap gap-2 mt-4">
          {technologies.map((tech, i) => (
            <Badge key={i} variant="secondary" className="font-normal">
              {tech}
            </Badge>
          ))}
        </div>
      </CardContent>
    </Card>
  );
};

export default ProjectCard;
