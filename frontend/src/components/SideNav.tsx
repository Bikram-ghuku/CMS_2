import { Home, User, LogOut, Megaphone, Package, PackageOpen } from 'lucide-react';
import '../styles/SideNav.scss';

const SideNav = () => {
	return (
    	<div className={`sidenav`}>
      		<div className="title">
        		CIMS
      		</div>
      		<nav>
        		<ul>
          			<li>
						<Home />
						<span>Home</span>
					</li>
        			<li>
						<User />
						<span>Users</span>
          			</li>
					<li>
						<Megaphone />
						<span>Complaints</span>
					</li>
					<li>
						<Package />
						<span>Inventory</span>
					</li>
					<li>
						<PackageOpen />
						<span>Inventory Used</span>
					</li>
          			<li>
            			<LogOut />
            			<span>Logout</span>
          			</li>
        		</ul>
      		</nav>
    	</div>
  	);
};

export default SideNav;
