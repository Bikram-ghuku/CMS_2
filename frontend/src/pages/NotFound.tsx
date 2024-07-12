import React from 'react';
import '../styles/NotFound.scss';
import logo from '../assets/IIT_Kharagpur_Logo.png'


const NotFound: React.FC = () => {
    return (
        <div className="not-found">
            <img src={logo} alt="CIMS Logo" className="logo" />
            <h1>404</h1>
            <p>Page Not Found</p>
            <a href="/" className="back-home">Go Back Home</a>
        </div>
    );
};

export default NotFound;
