import React from 'react';
import '../styles/LandingPage.scss';
import { Link } from 'react-router-dom';

const LandingPage: React.FC = () => {
	return (
    	<div className="landing-page">
      		<header className="header">
        		<h1>Welcome to Our Website</h1>
        		<p>Your journey starts here.</p>
        		<button className="cta-button" >
					<Link to="/login">
						Get Started
					</Link>
				</button>
      		</header>
    	</div>
  	);
};

export default LandingPage;
