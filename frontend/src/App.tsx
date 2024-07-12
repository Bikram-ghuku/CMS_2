import {BrowserRouter as Router, Routes, Route} from "react-router-dom"
import Login from './pages/Login'
import Home from './pages/Home'
import Complaints from './pages/Complaints'
import Users from "./pages/Users"
import Complaint from "./pages/Complaint"
import Inventory from "./pages/Inventory"
import Invenused from "./pages/Invenused"
import LandingPage from "./pages/Landing"
import NotFound from "./pages/NotFound"
import * as Sentry from "@sentry/react";

Sentry.init({
	dsn: "https://e9a51c4ebb5c8ece98f591f7f775c77c@o1272929.ingest.us.sentry.io/4507589866291200",
	integrations: [
		Sentry.browserTracingIntegration(),
	  	Sentry.replayIntegration(),
	],
	tracesSampleRate: 1.0,
	tracePropagationTargets: ["localhost", /^\//],
	replaysSessionSampleRate: 0.1,
	replaysOnErrorSampleRate: 1.0,
  });

function App() {
	return (
    	<>
    		<Router>
        		<Routes>
					<Route path="/" Component={LandingPage} />
          			<Route path='/login' Component={Login}/>
          			<Route path='/dashboard' Component={Home} />
          			<Route path='/complaints' Component={Complaints} />
          			<Route path='/users' Component={Users} />
          			<Route path='/complaint' Component={Complaint} />
          			<Route path='/inventory' Component={Inventory} />
          			<Route path='/invenused' Component={Invenused} />
					<Route path="/*" Component={NotFound} />
        		</Routes>
      		</Router>
    	</>
  	)
}

export default App
