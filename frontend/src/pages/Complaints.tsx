import { useEffect, useState } from 'react'
import '../styles/Complaints.scss'
import { BACKEND_URL } from '../constants';
import CloseCompModal from '../components/CloseCompModal';
import CompDetailsModal from '../components/UpdateCompModal';

interface FinDatetime {
    Time: string;
    Valid: boolean;
}

interface FinText {
    String: string;
    Valid: boolean;
}

type complaint = {
    comp_id:string,
    comp_nos:string,
    comp_loc:string,
    comp_des:string,
    comp_stat:string,
    comp_date:string,
    fin_datetime: FinDatetime,
    fin_text: FinText
}

const empty:complaint = {comp_id: "", comp_nos: "", comp_loc: "", comp_des: "", comp_stat: "", comp_date: "", fin_datetime : {Time: "", Valid: false}, fin_text:{String:"", Valid:false}}

function Complaints() {
    const [complaints, setComplaints] = useState<complaint[]>([])
    const [isLoad, setLoad] = useState(false);
    const [isUpdateModalOpen, setIsUpdateModalOpen] = useState<boolean>(false);
    const [isCloseModalOpen, setIsCloseModalOpen] = useState<boolean>(false);
    const [currComp, setCurrComp] = useState<complaint>(empty)

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

    const openUpdateModal = (comp: complaint) => {
        setCurrComp(comp)
        setIsUpdateModalOpen(true);
    };

    const closeUpdateModal = () => {
        setIsUpdateModalOpen(false);
    };

    const openCloseModal = (comp: complaint) => {
        setCurrComp(comp)
        setIsCloseModalOpen(true);
    };

    const closeCloseModal = () => {
        setIsCloseModalOpen(false);
    };

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
                                        <td className='btn-opt'>
                                            <div onClick={() => openUpdateModal(item)}>View</div>
                                            <div onClick={() => openCloseModal(item)}>Close</div>
                                        </td>
                                    </tr>
                                )
                            })
                        }
                    </tbody>
                </table>
            </div>
            <CloseCompModal isOpen={isCloseModalOpen} onRequestClose={closeCloseModal} comp={currComp} />
            <CompDetailsModal isOpen={isUpdateModalOpen} onRequestClose={closeUpdateModal} comp={currComp}/>
        </div>
    )
}

export default Complaints