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
	dsn: "https://5653fec6874858b7db8111b3bb6af040@o1272929.ingest.us.sentry.io/4507589639929856",
	integrations: [
	  Sentry.browserTracingIntegration(),
	  Sentry.replayIntegration(),
	],
	// Performance Monitoring
	tracesSampleRate: 1.0, //  Capture 100% of the transactions
	// Set 'tracePropagationTargets' to control for which URLs distributed tracing should be enabled
	tracePropagationTargets: ["localhost", /^\//],
	// Session Replay
	replaysSessionSampleRate: 0.1, // This sets the sample rate at 10%. You may want to change it to 100% while in development and then sample at a lower rate in production.
	replaysOnErrorSampleRate: 1.0, // If you're not already sampling the entire session, change the sample rate to 100% when sampling sessions where errors occur.
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
