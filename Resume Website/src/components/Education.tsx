
import React from 'react';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { GraduationCap } from 'lucide-react';

const Education = () => {
  return (
    <section id="education" className="py-20 bg-background">
      <div className="section-container">
        <div className="space-y-4 max-w-3xl mx-auto text-center mb-16">
          <Badge variant="outline" className="mb-2">Learning Path</Badge>
          <h2 className="text-3xl md:text-4xl font-bold">Education & Qualifications</h2>
          <p className="text-muted-foreground text-lg">
            Academic credentials and certifications
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-1 gap-8">
          <Card className="border border-border/40 overflow-hidden animate-scale-in">
            <div className="relative">
              <div className="absolute top-0 left-0 w-1 h-full bg-accent"></div>
              <CardHeader className="pb-2">
                <div className="flex items-start">
                  <div className="mr-4">
                    <div className="h-12 w-12 rounded-full bg-accent/10 text-accent flex items-center justify-center">
                      <GraduationCap className="h-6 w-6" />
                    </div>
                  </div>
                  <div>
                    <CardTitle className="text-xl">Bachelor of Computer Science (Data Science)</CardTitle>
                    <p className="text-muted-foreground">Swinburne University of Technology | Mar 2022 – Dec 2024</p>
                  </div>
                </div>
              </CardHeader>
              <CardContent>
                <p className="text-foreground/80">
                  Pursuing a comprehensive program focused on data science, machine learning, and statistical analysis. The curriculum emphasizes both theoretical knowledge and practical applications in the field of data science.
                </p>
              </CardContent>
            </div>
          </Card>

          <div className="space-y-4">
            <h3 className="text-xl font-semibold mb-4">Certifications</h3>
            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
              <div className="bg-secondary/50 p-4 rounded-lg animate-scale-in" style={{animationDelay: '100ms'}}>
                <p className="font-medium">LinkedIn Learning:</p>
                <ul className="list-disc pl-5 text-foreground/80 mt-2 space-y-1">
                  <li>Excel Essential Training (Microsoft 365) [2023]</li>
                  <li>A day in life of a Data Scientist [2023]</li>
                  <li>The Non-Technical Skills of effective Data Scientist [2023]</li>
                  <li>Advanced Python: Working With Data [2024]</li>
                  <li>Advanced Python: Working With Databases [2024]</li>
                  <li>Business Analyst Foundations [2024]</li>
                </ul>
              </div>
              <div className="bg-secondary/50 p-4 rounded-lg animate-scale-in" style={{animationDelay: '200ms'}}>
                <p className="font-medium">Microsoft:</p>
                <ul className="list-disc pl-5 text-foreground/80 mt-2">
                  <li>DP900 Azure Data Fundamentals</li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Education;
