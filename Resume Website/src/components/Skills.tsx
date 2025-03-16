
import React from 'react';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent } from '@/components/ui/card';
import { Code, Database, LineChart, Shield } from 'lucide-react';

const Skills = () => {
  const skillCategories = [
    {
      icon: <Code className="h-5 w-5" />,
      title: 'Programming',
      skills: ['Python', 'R', 'JavaScript', 'SQL', 'HTML/CSS'],
      color: 'bg-blue-100 text-blue-600',
    },
    {
      icon: <LineChart className="h-5 w-5" />,
      title: 'Data & Visualization',
      skills: ['SQL', 'Tableau', 'Power BI', 'KNIME', 'D3.js'],
      color: 'bg-green-100 text-green-600',
    },
    {
      icon: <Database className="h-5 w-5" />,
      title: 'Cloud & Big Data',
      skills: ['AWS (EC2, S3)', 'Azure', 'Hadoop', 'Hive', 'PySpark', 'Pipelines'],
      color: 'bg-purple-100 text-purple-600',
    },
    {
      icon: <Shield className="h-5 w-5" />,
      title: 'Security & Networking',
      skills: ['Email Security (SPF, DKIM, DMARC)', 'Active Directory', 'Windows Server'],
      color: 'bg-red-100 text-red-600',
    },
  ];

  const coreCompetencies = [
    'Critical Thinking',
    'Problem Solving',
    'Data Management',
    'Statistical Analysis',
    'Business Intelligence',
    'Data Visualization',
    'Machine Learning',
    'Process Optimization',
  ];

  return (
    <section id="skills" className="py-20 bg-background">
      <div className="section-container">
        <div className="space-y-4 max-w-3xl mx-auto text-center mb-16">
          <Badge variant="outline" className="mb-2">Expertise</Badge>
          <h2 className="text-3xl md:text-4xl font-bold">Key Skills</h2>
          <p className="text-muted-foreground text-lg">
            Technical proficiencies and domain expertise
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">
          {skillCategories.map((category, index) => (
            <div 
              key={index} 
              className="animate-scale-in"
              style={{animationDelay: `${index * 100}ms`}}
            >
              <div className="flex items-center mb-4">
                <div className={`h-8 w-8 rounded-full ${category.color.split(' ')[0]} flex items-center justify-center mr-3`}>
                  {category.icon}
                </div>
                <h3 className="text-xl font-semibold">{category.title}</h3>
              </div>
              <Card className="border border-border/40">
                <CardContent className="p-6">
                  <div className="flex flex-wrap gap-3">
                    {category.skills.map((skill, i) => (
                      <div 
                        key={i} 
                        className="px-4 py-2 rounded-full bg-secondary text-foreground/80 text-sm font-medium"
                      >
                        {skill}
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            </div>
          ))}
        </div>

        <div className="mt-16">
          <h3 className="text-xl font-semibold text-center mb-8">Core Competencies</h3>
          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4">
            {coreCompetencies.map((competency, index) => (
              <div 
                key={index} 
                className="p-4 bg-accent/5 border border-accent/20 rounded-lg text-center animate-scale-in"
                style={{animationDelay: `${index * 50 + 400}ms`}}
              >
                <span className="text-foreground">{competency}</span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
};

export default Skills;
