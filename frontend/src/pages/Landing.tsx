import React from 'react';
import '../styles/LandingPage.scss';

const LandingPage: React.FC = () => {
	return (
    	<div className="landing-page">
      		<header className="header">
        		<h1>Welcome to Our Website</h1>
        		<p>Your journey starts here.</p>
        		<button className="cta-button">Get Started</button>
      		</header>
    	</div>
  	);
};

export default LandingPage;
