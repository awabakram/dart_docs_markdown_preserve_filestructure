import clsx from 'clsx';
import Heading from '@theme/Heading';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Automated Documentation',
    Svg: require('@site/static/img/chemistry_experiment.svg').default,
    description: (
      <>
        Generate structured and professional Markdown documentation for your Dart/Flutter project with a single command.
      </>
    ),
  },
  {
    title: 'Seamless Integration',
    Svg: require('@site/static/img/network_cloud_icon.svg').default,
    description: (
      <>
        Easily integrate the generated Markdown files with documentation platforms like Docusaurus for a polished site.
      </>
    ),
  },
  {
    title: 'Detailed Class and Method Documentation',
    Svg: require('@site/static/img/reading.svg').default,
    description: (
      <>
        Dive deep into your project’s details with class-specific overviews, method documentation, and constructor details, all generated in Markdown format.
      </>
    ),
  }
];

function Feature({Svg, title, description}) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
