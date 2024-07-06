import { jwtDecode } from "jwt-decode";
import { getCookie} from 'typescript-cookie'
import '../styles/Home.scss'
import SideNav from "../components/SideNav";
import { Boxes, Loader2, Megaphone, User, Users } from "lucide-react";
import { useEffect, useState } from "react";
import { BACKEND_URL } from "../constants";
import { ToastContainer, toast } from 'react-toastify';

type claims = {
    uname:string,
    role:string
}

type nums = {
    inven_nos:number,
    comp_nos:number,
    user_nos:number
}
function Home() {
    const sessionCookie = getCookie("session-token")
    const claimsJson:claims = jwtDecode(sessionCookie!)
    const [load, setIsLoad] = useState(true)
    const [numData, setNumData] = useState<nums>({
        inven_nos:0,
        comp_nos:0,
        user_nos:0
    })
    if(claimsJson.role == "worker"){
        document.location = "./complaints"
    }

    useEffect(()=>{
        fetch(BACKEND_URL+"/stat/num", {
            method:"GET",
            credentials: "include"
        }).then((data) => {
            setIsLoad(false)
            if(data.ok){
                data.json().then((data) => {
                    setNumData(data)
                })
            }else{
                toast.error("Loading Error", {
                    position: "bottom-center"
              })
            }
        })
    }, [])
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
                                <div className="opts-item-nos">{numData.comp_nos}</div>
                            </div>
                            <div className="opts-item-icon">
                            {load ? <Loader2 className='animate-spin' size={100} /> : <Megaphone size={100} strokeWidth={1}/>}
                            </div>
                        </div>
                        <div className="opts-item item-blue">
                            <div className="opt-item-left">
                                <div className="opts-item-title">Inventory</div>
                                <div className="opts-item-nos">{numData.inven_nos}</div>
                            </div>
                            <div className="opts-item-icon">
                            {load ? <Loader2 className='animate-spin' size={100} /> : <Boxes size={100} strokeWidth={1} />}
                            </div>
                        </div>
                        <div className="opts-item item-yellow">
                            <div className="opt-item-left">
                                <div className="opts-item-title">Users</div>
                                <div className="opts-item-nos">{numData.user_nos}</div>
                            </div>
                            <div className="opts-item-icon">
                                {load ? <Loader2 className='animate-spin' size={100} /> : <Users size={100} strokeWidth={1}/>}
                            </div>
                        </div>
                    </div>
                </div>
                <hr className="home-hr"/>
                <div className="home-inven-use"></div>
                <div className="home-footer">
                        Copyright © Sanitary Section, IIT Kharagpur.
                </div>
            </div>
            <ToastContainer/>
        </div>
    )
}

export default Home