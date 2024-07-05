import { useState } from 'react';
import '../styles/Login.scss'
import logo from '../assets/IIT_Kharagpur_Logo.png'
import { Loader2 } from 'lucide-react'
import { BACKEND_URL } from '../constants';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

const Login = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [isLoad, setLoad] = useState(false);
  const handleLogin = () => {
    setLoad(true)
    fetch(BACKEND_URL+'/user/login', {
      method: "POST",
      body: JSON.stringify({"uname": username, "pswd": password}),
      credentials: "include"
    }).then((data) => {
      if(data.ok){
        toast.success("Login successful", {
          position: "bottom-center"
        })
        setTimeout(() => {
          document.location = "./dashboard"
        }, 1000)
      }else{
        toast.error("Login Error", {
          position: "bottom-center"
        })
        setLoad(false)
      }
    })
  }

  return (
    <>
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
            <button type="submit" disabled={isLoad} onClick={() => handleLogin()}>
              <div className="msg">{isLoad && <Loader2 className='animate-spin'/>} Login</div>
            </button>
          </div>
        </div>
      </div>
      <ToastContainer autoClose={1000}/>
    </>
  );
};

  export default Login;
