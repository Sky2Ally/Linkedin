
import React from 'react';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { CalendarIcon, BriefcaseIcon } from 'lucide-react';

const Experience = () => {
  const experiences = [
    {
      title: 'IT Business Analyst - Internship',
      company: 'Builders Academy Australia',
      period: 'Feb 2024 to June 2024',
      responsibilities: [
        'Analysed 10,000+ student records using Excel and VET Track, identifying key enrollment trends and optimizing resource allocation.',
        'Developed daily and weekly reporting dashboards, reducing student onboarding time by 15%.',
        'Provided data-driven insights that improved strategic planning for student intake and course offerings.',
        'Received commendation from supervisors for mentoring new interns and fostering a collaborative learning environment.',
      ],
    },
    {
      title: 'IT Support Officer - Contract',
      company: 'University Of Melbourne',
      period: 'Sept 2023 to Nov 2024',
      responsibilities: [
        'Provided technical support, troubleshooting, and issue resolution for students and faculty during exam periods, ensuring minimal disruptions.',
        'Diagnosed and resolved hardware, software, and network issues, including Windows, macOS, and Microsoft 365 applications.',
        'Assisted students with LMS platforms, VPN connectivity, and collaboration tools like Teams and Zoom.',
        'Managed help desk tickets and escalated complex issues following ITIL best practices.',
        'Supported Active Directory (AD) user management, password resets, and access control.',
        'Implemented proactive troubleshooting measures, reducing repeat requests by 20%.',
      ],
    },
  ];

  return (
    <section id="experience" className="py-20 bg-secondary/30">
      <div className="section-container">
        <div className="space-y-4 max-w-3xl mx-auto text-center mb-16">
          <Badge variant="outline" className="mb-2">Career Path</Badge>
          <h2 className="text-3xl md:text-4xl font-bold">Work Experience</h2>
          <p className="text-muted-foreground text-lg">
            My professional journey across data analysis and IT support roles
          </p>
        </div>

        <div className="space-y-12">
          {experiences.map((exp, index) => (
            <Card key={index} className="overflow-hidden border border-border/40 animate-scale-in" style={{animationDelay: `${index * 100}ms`}}>
              <div className="relative">
                <div className="absolute top-0 left-0 w-1 h-full bg-accent"></div>
                <CardHeader className="pb-2">
                  <div className="flex flex-col md:flex-row md:justify-between md:items-center gap-2">
                    <div>
                      <CardTitle className="text-xl md:text-2xl">{exp.title}</CardTitle>
                      <p className="text-lg font-medium text-accent">{exp.company}</p>
                    </div>
                    <div className="flex items-center text-muted-foreground">
                      <CalendarIcon className="mr-2 h-4 w-4" />
                      <span>{exp.period}</span>
                    </div>
                  </div>
                </CardHeader>
                <CardContent>
                  <ul className="space-y-2 list-disc pl-5">
                    {exp.responsibilities.map((resp, i) => (
                      <li key={i} className="text-foreground/80">
                        {resp}
                      </li>
                    ))}
                  </ul>
                </CardContent>
              </div>
            </Card>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Experience;
