import { useState } from 'react';
import '../styles/Login.scss'
import logo from '../assets/IIT_Kharagpur_Logo.png'

const Login = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');



  return (
    <div className="login-container">
      <div className="login-box">
        <img src={logo} alt="IIT Kharagpur Logo" className="logo" />
        <h2>CIMS Login</h2>
        <div className='form'>
          <div className="form-group">
            <input
            type="text"
            id="username"
            name="username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            placeholder='Username'
            required
            />
          </div>
          <div className="form-group">
            <input
            type="password"
            id="password"
            name="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder='Password'
            required
            />
          </div>
          <button type="submit">Login</button>
        </div>
      </div>
    </div>
  );
};

  export default Login;
