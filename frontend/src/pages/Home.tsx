import { jwtDecode } from "jwt-decode";
import { getCookie} from 'typescript-cookie'
import '../styles/Home.scss'
import SideNav from "../components/SideNav";
import { Boxes, Loader2, Megaphone, User, Users } from "lucide-react";
import { useEffect, useState } from "react";
import { BACKEND_URL } from "../constants";
import { ToastContainer, toast } from 'react-toastify';
import PieChart from "../components/PieChart";
import ChartComponent from "../components/GraphChart";

type claims = {
    uname:string,
    role:string
}

type ghPoint = {
    comp_data: string,
    comp_count: number
}
type nums = {
    inven_nos:number,
    comp_open_nos:number,
    comp_close_nos:number,
    user_nos:number
}
function Home() {
    const sessionCookie = getCookie("session-token")
    const claimsJson:claims = jwtDecode(sessionCookie!)
    const [load, setIsLoad] = useState(true)
    const [chartData, setChartData] = useState({openComp: 0, closeComp: 0})
    const [numData, setNumData] = useState<nums>({
        inven_nos:0,
        comp_open_nos:0,
        comp_close_nos:0,
        user_nos:0
    })
    const [ghdata, setGhData] = useState<ghPoint[]>();
    const [ghLoad, setIsghLoad] = useState(true);

    if(claimsJson.role == "worker"){
        document.location = "./complaints"
    }

    useEffect(()=>{
        fetch(BACKEND_URL+"/stat/num", {
            method:"GET",
            credentials: "include"
        }).then((data) => {
            if(data.ok){
                data.json().then((data) => {
                    setIsLoad(false)
                    setNumData(data)
                    setChartData({openComp: data.comp_open_nos, closeComp: data.comp_close_nos})
                })
            }else{
                toast.error("Loading Error", {
                    position: "bottom-center"
              })
            }
        }).catch((err) => {
            toast.error("Error: "+err, {
				position: "bottom-center"
			});
        });
    }, [])

    useEffect(()=>{
        fetch(BACKEND_URL+"/stat/chart", {
            method:"GET",
            credentials: "include"
        }).then((data) => {
            if(data.ok){
                data.json().then((data:ghPoint[]) => {
                    if(data == null) return;
                    setIsghLoad(false)
                    setGhData(data);
                })
            }else{
                toast.error("Loading Error", {
                    position: "bottom-center"
              })
            }
        }).catch((err) => {
            toast.error("Error: "+err, {
				position: "bottom-center"
			});
        });
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
                                <div className="opts-item-nos">{numData.comp_open_nos + numData.comp_close_nos}</div>
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
                <div className="home-stats">
                    <div className="home-stats-title">
                        Statistics
                    </div>
                    <div className="home-stats-graphs">
                        <div className="home-stats-graph1">
                            {!load && <PieChart customProps={chartData}/>}
                        </div>
                        <div className="home-stats-graph2">
                            {!ghLoad && <ChartComponent data={ghdata!}/>}
                        </div>
                    </div>
                </div>
                <div className="home-footer">
                        Copyright © Sanitary Section, IIT Kharagpur.
                </div>
            </div>
            <ToastContainer/>
        </div>
    )
}

export default Home