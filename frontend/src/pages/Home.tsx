import { jwtDecode } from "jwt-decode";
import { getCookie} from 'typescript-cookie'
import '../styles/Home.scss'
import SideNav from "../components/SideNav";
import { Boxes, Megaphone, User, Users } from "lucide-react";

type claims = {
    uname:string,
    role:string
}
function Home() {
    const sessionCookie = getCookie("session-token")
    const claimsJson:claims = jwtDecode(sessionCookie!)
    console.log(claimsJson.uname)
    if(claimsJson.role == "worker"){
        document.location = "./complaints"
    }
    return (
        <div className="home-main">
            <div className="home-side-nav">
                <SideNav/>
            </div>
            <div className="home">
                <div className="home-top">
                    <User />
                    {claimsJson.uname}
                </div>
                <div className="home-opts">
                    <div className="opts-title">
                        Dashboard
                    </div>
                    <div className="opts-items-wrap">
                        <div className="opts-item item-green">
                            <div className="opt-item-left">
                                <div className="opts-item-title">Complaints</div>
                                <div className="opts-item-nos">2</div>
                            </div>
                            <div className="opts-item-icon">
                                <Megaphone size={100} strokeWidth={1}/>
                            </div>
                        </div>
                        <div className="opts-item item-blue">
                            <div className="opt-item-left">
                                <div className="opts-item-title">Inventory</div>
                                <div className="opts-item-nos">2</div>
                            </div>
                            <div className="opts-item-icon">
                                <Boxes size={100} strokeWidth={1} />
                            </div>
                        </div>
                        <div className="opts-item item-yellow">
                            <div className="opt-item-left">
                                <div className="opts-item-title">Users</div>
                                <div className="opts-item-nos">2</div>
                            </div>
                            <div className="opts-item-icon">
                                <Users size={100} strokeWidth={1}/>
                            </div>
                        </div>
                    </div>
                </div>
                <div className="home-inven-use"></div>
                <div className="home-footer"></div>
            </div>
        </div>
    )
}

export default Home