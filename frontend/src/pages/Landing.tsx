import React from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/LandingPage.scss';
import logo from '../assets/IIT_Kharagpur_Logo.png'


const LandingPage: React.FC = () => {
	const navigate = useNavigate();

	const handleGetStarted = () => {
		navigate('/login');
	};

	return (
		<div className="landing-page">
		<header className="header">
			<div className="hero-section">
				<img src={logo} alt="CIMS Logo" className="logo" />
				<h1>Welcome to CIMS</h1>
				<p>Your one-stop solution for maintaining complaints, managing inventory, and generating bills.</p>
				<button className="cta-button" onClick={handleGetStarted}>Get Started</button>
			</div>
		</header>
		<section className="description-section">
			<div className="description-content">
				<h2>About CIMS</h2>
				<p>
					CIMS (Complaints and Inventory Management System) is designed to streamline your workflow and enhance efficiency.
					With CIMS, you can easily manage complaints, maintain your inventory, and generate bills, all in one place.
				</p>
			</div>
		</section>
		</div>
	);
};

export default LandingPage;
