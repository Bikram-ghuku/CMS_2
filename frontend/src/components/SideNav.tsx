import { Home, User, LogOut, Megaphone, Package, PackageOpen } from 'lucide-react';
import '../styles/SideNav.scss';
import { Link } from 'react-router-dom';
import logo from '../assets/IIT_Kharagpur_Logo.png'
import { jwtDecode } from "jwt-decode";
import { getCookie} from 'typescript-cookie'

type claims = {
    uname:string,
    role:string
}

const SideNav = () => {
	const sessionCookie = getCookie("session-token")
    const claimsJson:claims = jwtDecode(sessionCookie!)
	return (
		<div className='sidenav-main'>
			<div className='top-info'>
				<div className="top-bar">
                    <User />
                    {claimsJson.uname}
                </div>
			</div>
			<div className={`sidenav`}>
				<div className="title">
					<img src={logo} alt="IIT Kharagpur Logo" className="logo" />
					<div className='title-text'>
						Complaints & Inventory Management System
				</div>
				</div>
				<nav>
					<ul>
						<Link to="/dashboard">
							<li>
								<Home />
								<span>Home</span>
							</li>
						</Link>
						<Link to="/users">
							<li>
								<User />
								<span>Users</span>
							
							</li>
						</Link>
						<Link to="/complaint">
							<li>
								<Megaphone />
								<span>Complaints</span>
							</li>
						</Link>
						<Link to="/inventory">
							<li>
								<Package />
								<span>Inventory</span>
							</li>
						</Link>
						<Link to="/invenused">
							<li>
								<PackageOpen />
								<span>Inventory Used</span>
							</li>
						</Link>
						<Link to="/login">
							<li>
								<LogOut />
								<span>Logout</span>
							</li>
						</Link>
					</ul>
				</nav>
			</div>
		</div>
  	);
};

export default SideNav;
