import { Home, User, LogOut, Megaphone, Package, PackageOpen } from 'lucide-react';
import '../styles/SideNav.scss';
import { Link } from 'react-router-dom';
import logo from '../assets/IIT_Kharagpur_Logo.png'


const SideNav = () => {
	return (
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
  	);
};

export default SideNav;
