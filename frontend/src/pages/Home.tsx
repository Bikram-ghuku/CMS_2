import { jwtDecode } from "jwt-decode";
import { getCookie} from 'typescript-cookie'
import '../styles/Home.scss'

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
        <div>
            <div className="home-top"></div>
            <div className="home-opts">
                <div className="opts-items-wrap">
                    <div className="opts-item">
                        <div className="opts-item-title">Complaints</div>
                    </div>
                    <div className="opts-item">
                        <div className="opts-item-title">Inventory</div>
                    </div>
                    <div className="opts-item">
                        <div className="opts-item-title">Users</div>
                    </div>
                </div>
            </div>
            <div className="home-footer"></div>
        </div>
    )
}

export default Home