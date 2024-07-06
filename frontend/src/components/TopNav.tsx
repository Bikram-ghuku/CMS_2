import { jwtDecode } from "jwt-decode";
import { User } from "lucide-react";
import { getCookie} from 'typescript-cookie'
import "../styles/TopNav.scss"

type claims = {
    uname:string,
    role:string
}


function TopNav() {
    const sessionCookie = getCookie("session-token")
    const claimsJson:claims = jwtDecode(sessionCookie!)
    return (
        <div className="top-nav">
            <div className="top-nav-items">
                <User />
                {claimsJson.uname}
            </div>
        </div>
    )
}

export default TopNav