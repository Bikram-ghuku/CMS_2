import {BrowserRouter as Router, Routes, Route} from "react-router-dom"
import Login from './pages/Login'
import Home from './pages/Home'
import Complaints from './pages/Complaints'
import Users from "./pages/Users"
import Complaint from "./pages/Complaint"
import Inventory from "./pages/Inventory"
import Invenused from "./pages/Invenused"
function App() {
  return (
    <>
      <Router>
        <Routes>
          <Route path='/login' Component={Login}/>
          <Route path='/dashboard' Component={Home} />
          <Route path='/complaints' Component={Complaints} />
          <Route path='/users' Component={Users} />
          <Route path='/complaint' Component={Complaint} />
          <Route path='/inventory' Component={Inventory} />
          <Route path='/invenused' Component={Invenused} />
        </Routes>
      </Router>
    </>
  )
}

export default App
