import {BrowserRouter as Router, Routes, Route} from "react-router-dom"
import Login from './pages/Login'
import Home from './pages/Home'
import Complaints from './pages/Complaints'
function App() {
  return (
    <>
      <Router>
        <Routes>
          <Route path='/login' Component={Login}/>
          <Route path='/dashboard' Component={Home} />
          <Route path='/complaints' Component={Complaints} />
        </Routes>
      </Router>
    </>
  )
}

export default App
