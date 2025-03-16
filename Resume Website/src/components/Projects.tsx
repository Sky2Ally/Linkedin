
import React from 'react';
import { Badge } from '@/components/ui/badge';
import ProjectCard from './ProjectCard';

const Projects = () => {
  const projects = [
    {
      title: 'Forest Fire Damage Prediction Model',
      description: 'Predictive analysis to help forecast forest fire patterns and damage extents',
      details: [
        'Built a predictive model using R, analyzing 5 years of weather data to predict fire spread patterns.',
        'Improved prediction accuracy by 20%, aiding government agencies in disaster prevention.',
        'Utilized libraries like ggplot2 for data visualization and analysis, enhancing predictive efficiency.',
      ],
      technologies: ['R', 'ggplot2', 'Statistical Modeling', 'Predictive Analysis'],
    },
    {
      title: 'Electric Mobility Business Analysis with Tableau',
      description: 'Comprehensive market analysis and visualization for electric vehicle industry',
      details: [
        'Conducted a detailed EV market analysis (2019–2023) for SparkEV, identifying sales trends and high-performing models.',
        'Built interactive Tableau dashboards/ PowerBI and utilized SQL to query and process large datasets, to support data-driven strategic decisions, improving product lineup and pricing.',
        'Provided strategic recommendations that optimized pricing and product lineup decisions.',
      ],
      technologies: ['Tableau', 'PowerBI', 'SQL', 'Market Analysis', 'Data Visualization'],
    },
    {
      title: 'Interactive Migration Patterns Web-Application',
      description: 'Web application to visualize and analyze human migration trends',
      details: [
        'Developed a responsive web app with D3.js, featuring dynamic visualisations such as bar, line, and pie charts.',
        'Integrated real-time data filtering and interactive tooltips for better user insights.',
      ],
      technologies: ['JavaScript', 'D3.js', 'HTML/CSS', 'Interactive Visualization'],
    },
    {
      title: 'Airline Dataset Cleaning and Analysis with KNIME',
      description: 'Data preprocessing and trend analysis for airline operations',
      details: [
        'Cleaned and standardized 6,000-record airline dataset, ensuring data integrity for analysis.',
        'Conducted trend analysis, uncovering key insights into customer behaviour and airline performance.',
      ],
      technologies: ['KNIME', 'Data Cleaning', 'Trend Analysis', 'Data Standardization'],
    },
    {
      title: 'Data Analysis with Tableau',
      description: 'Inventory performance visualization and optimization',
      details: [
        'Analysed inventory performance metrics, including turnover rates and safety stock levels, using Tableau.',
        'Identified inefficiencies in overstock management, particularly for mountain bikes, and proposed JIT inventory solutions.',
        'Recommended improvements in demand forecasting and real-time tracking to optimize operations.',
      ],
      technologies: ['Tableau', 'Inventory Analysis', 'JIT Optimization', 'Demand Forecasting'],
    },
    {
      title: 'Email Security Gateway Implementation',
      description: 'Advanced email security system with threat protection',
      details: [
        'Designed a sophisticated email security gateway to filter malicious content using advanced threat intelligence.',
        'Ensured compliance with SPF, DKIM, and DMARC protocols, ensuring robust protection against phishing, spam, and spoofing.',
        'Incorporated encryption and DLP features to safeguard sensitive data, achieving a highly secure and compliant email system.',
      ],
      technologies: ['Email Security', 'SPF/DKIM/DMARC', 'DLP', 'Encryption', 'Compliance'],
    },
  ];

  return (
    <section id="projects" className="py-20 bg-secondary/30">
      <div className="section-container">
        <div className="space-y-4 max-w-3xl mx-auto text-center mb-16">
          <Badge variant="outline" className="mb-2">Portfolio</Badge>
          <h2 className="text-3xl md:text-4xl font-bold">Featured Projects</h2>
          <p className="text-muted-foreground text-lg">
            A selection of my data-driven solutions and technical implementations
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {projects.map((project, index) => (
            <ProjectCard
              key={index}
              title={project.title}
              description={project.description}
              details={project.details}
              technologies={project.technologies}
              index={index}
            />
          ))}
        </div>
      </div>
    </section>
  );
};

export default Projects;
