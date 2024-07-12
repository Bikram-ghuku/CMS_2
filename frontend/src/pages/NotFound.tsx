import React from 'react';
import '../styles/NotFound.scss';

const NotFound: React.FC = () => {
    return (
        <div className="not-found">
            <h1>404</h1>
            <p>Page Not Found</p>
            <a href="/" className="back-home">Go Back Home</a>
        </div>
    );
};

export default NotFound;
