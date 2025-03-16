
import React from 'react';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent } from '@/components/ui/card';
import { BriefcaseIcon, GraduationCap, LineChart, CloudIcon } from 'lucide-react';

const About = () => {
  const expertise = [
    {
      icon: <LineChart className="h-5 w-5" />,
      title: 'Data Analysis',
      description: 'Transforming raw data into actionable insights that drive business decisions.',
    },
    {
      icon: <BriefcaseIcon className="h-5 w-5" />,
      title: 'Business Analysis',
      description: 'Analyzing business processes and identifying opportunities for optimization.',
    },
    {
      icon: <GraduationCap className="h-5 w-5" />,
      title: 'Statistical Analysis',
      description: 'Applying statistical methods to interpret data and predict trends.',
    },
    {
      icon: <CloudIcon className="h-5 w-5" />,
      title: 'Cloud Computing',
      description: 'Leveraging AWS and Azure platforms for scalable data solutions.',
    },
  ];

  return (
    <section id="about" className="py-20 bg-background">
      <div className="section-container">
        <div className="space-y-4 max-w-3xl mx-auto text-center mb-16">
          <Badge variant="outline" className="mb-2">About Me</Badge>
          <h2 className="text-3xl md:text-4xl font-bold">Professional Profile</h2>
          <p className="text-muted-foreground text-lg">
            Data Analyst | Business Analyst with expertise in transforming complex datasets into actionable business insights.
          </p>
        </div>

        <div className="flex flex-col md:flex-row gap-8 mb-12">
          <div className="flex-1 space-y-6">
            <p className="text-lg leading-relaxed">
              Experienced in data visualization, statistical analysis, business intelligence, and cloud computing (AWS, Azure). Strong problem-solving abilities, with a proven track record of improving processes and optimizing business operations.
            </p>
            <p className="text-lg leading-relaxed">
              Passionate about leveraging data-driven solutions to optimize business processes and drive strategic decision-making.
            </p>
          </div>
          <div className="flex-1 space-y-6">
            <p className="text-lg leading-relaxed">
              Currently pursuing a Bachelor of Computer Science (Data Science) at Swinburne University of Technology, where I'm developing advanced skills in machine learning, data mining, and big data analytics.
            </p>
            <p className="text-lg leading-relaxed">
              I combine technical expertise with strong business acumen to deliver impactful solutions that address real-world challenges.
            </p>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mt-12">
          {expertise.map((item, index) => (
            <Card key={index} className="card-hover border border-border/40">
              <CardContent className="p-6">
                <div className="h-12 w-12 rounded-lg bg-accent/10 text-accent flex items-center justify-center mb-4">
                  {item.icon}
                </div>
                <h3 className="text-lg font-semibold mb-2">{item.title}</h3>
                <p className="text-muted-foreground">{item.description}</p>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </section>
  );
};

export default About;
