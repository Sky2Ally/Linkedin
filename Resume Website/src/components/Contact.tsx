
import React from 'react';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent } from '@/components/ui/card';
import { MapPin, Mail, Linkedin, Github, Phone, ExternalLink } from 'lucide-react';
import { Button } from '@/components/ui/button';

const Contact = () => {
  const contactInfo = [
    {
      icon: <MapPin className="h-5 w-5" />,
      title: 'Location',
      value: 'Footscray, VIC, 3011',
      link: null,
    },
    {
      icon: <Mail className="h-5 w-5" />,
      title: 'Email',
      value: 'bhuvanvirmani303@gmail.com',
      link: 'mailto:bhuvanvirmani303@gmail.com',
    },
    {
      icon: <Phone className="h-5 w-5" />,
      title: 'Phone',
      value: '+61434096407',
      link: 'tel:+61434096407',
    },
    {
      icon: <Linkedin className="h-5 w-5" />,
      title: 'LinkedIn',
      value: 'Connect with me',
      link: 'https://www.linkedin.com/in/bhuvan-virmani-5510a8219/',
    },
    {
      icon: <Github className="h-5 w-5" />,
      title: 'GitHub',
      value: 'View my repositories',
      link: 'https://github.com/Sky2Ally/Linkedin',
    },
    {
      icon: <ExternalLink className="h-5 w-5" />,
      title: 'Migration Project',
      value: 'View live demo',
      link: 'https://sky2ally.github.io/Linkedin/D3Website/',
    },
  ];

  return (
    <section id="contact" className="py-20 bg-secondary/10">
      <div className="section-container">
        <div className="space-y-4 max-w-3xl mx-auto text-center mb-16">
          <Badge variant="outline" className="mb-2">Get In Touch</Badge>
          <h2 className="text-3xl md:text-4xl font-bold">Contact Information</h2>
          <p className="text-muted-foreground text-lg">
            Connect with me to discuss opportunities or collaborations
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 max-w-4xl mx-auto">
          {contactInfo.map((info, index) => (
            <Card 
              key={index} 
              className="border border-border/20 bg-card/50 backdrop-blur-sm hover:shadow-md transition-all duration-300"
            >
              <CardContent className="p-6 flex flex-col items-center text-center">
                <div className="h-12 w-12 rounded-full bg-accent/10 text-accent flex items-center justify-center mb-4">
                  {info.icon}
                </div>
                <h3 className="text-lg font-medium mb-2">{info.title}</h3>
                {info.link ? (
                  <a 
                    href={info.link} 
                    className="text-accent hover:underline inline-flex items-center gap-1"
                    target={info.link.startsWith('http') ? '_blank' : undefined}
                    rel={info.link.startsWith('http') ? 'noopener noreferrer' : undefined}
                  >
                    {info.value}
                  </a>
                ) : (
                  <p className="text-foreground/80">{info.value}</p>
                )}
              </CardContent>
            </Card>
          ))}
        </div>

        <div className="mt-12 text-center">
          <Button asChild size="lg" className="rounded-full px-8 shadow-md">
            <a href="mailto:bhuvanvirmani303@gmail.com">Send Email</a>
          </Button>
          <div className="mt-6 flex justify-center gap-4">
            <Button asChild variant="outline" size="sm" className="rounded-full">
              <a href="https://sky2ally.github.io/Linkedin/" target="_blank" rel="noopener noreferrer">
                View Resume
              </a>
            </Button>
            <Button asChild variant="outline" size="sm" className="rounded-full">
              <a href="https://sky2ally.github.io/Linkedin/D3Website/" target="_blank" rel="noopener noreferrer">
                View Project
              </a>
            </Button>
          </div>
          <p className="mt-4 text-muted-foreground">
            References available upon request.
          </p>
        </div>
      </div>
    </section>
  );
};

export default Contact;
