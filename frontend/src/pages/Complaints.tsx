import { useEffect, useState } from 'react'
import '../styles/Complaints.scss'
import { BACKEND_URL } from '../constants';

type complaint = {
    comp_id: string,
    comp_nos:string,
    comp_loc:string,
    comp_stat:string,
    comp_date:string,
    comp_des:string
}
function Complaints() {
    const [complaints, setComplaints] = useState<complaint[]>([])
    const [isLoad, setLoad] = useState(false);
    useEffect(() => {
        setLoad(true)
        fetch(BACKEND_URL+"/comp/all", {
            method: "GET",
            credentials:"include",
        }).then((data) => {
            if(data.ok){
                setLoad(false)
                data.json().then((dataJson) => {setComplaints(dataJson)})
            }
        })
    }, [])
    return (
        <div className='comp-main'>
            <div className="comp-title">
                <div className="comp-title-txt">Complaints</div>
                <div className="comp-title-desc">All Available Complaints are shown here</div>
            </div>
            <div className="comp-table-wrap">
                <table className='comp-table' hidden={isLoad}>
                    <tbody>
                        <tr>
                            <th>Number</th>
                            <th>Address</th>
                            <th>Status</th>
                            <th className='sm-hide'>Creation Date</th>
                            <th className='sm-hide'>Creation Time</th>
                            <th className='sm-hide tb-desc'>Description</th>
                            <th>View</th>
                        </tr>
                        {
                            complaints.map((item, idx) => {
                                const time = new Date(item.comp_date)
                                return (
                                    <tr key={idx}>
                                        <td>{item.comp_nos}</td>
                                        <td>{item.comp_loc}</td>
                                        <td className={'tr-'+item.comp_stat}>{item.comp_stat}</td>
                                        <td className='sm-hide'>{time.toLocaleDateString()}</td>
                                        <td className='sm-hide'>{time.toLocaleTimeString()}</td>
                                        <td className='sm-hide tb-desc'>{item.comp_des}</td>
                                        <td><a href={"./compActions/"+item.comp_id}>View</a></td>
                                    </tr>
                                )
                            })
                        }
                    </tbody>
                </table>
            </div>
        </div>
    )
}

export default Complaints