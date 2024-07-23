import TopNav from '../components/TopNav'
import SideNav from '../components/SideNav'
import Footer from '../components/Footer'
import { Id, ToastContainer, toast } from 'react-toastify'
import { useEffect, useRef, useState } from 'react'
import { Plus } from 'lucide-react';
import "../styles/Complaint.scss"
import { useDownloadExcel } from 'react-export-table-to-excel';
import { BACKEND_URL } from '../constants'

type billItem = {
    item_id:string;
    item_des:string;
    item_unit:string;
    item_used: number;
    item_price: number;
    upto_use: number;
    upto_amt: number;
}

type bill = {
    bill_id: string;
    bill_dt: string;
}

const empty: billItem = {item_id:"", item_des:"", item_unit: "", item_used: 0, item_price: 0, upto_amt: 0, upto_use: 0}

function Abstract() {
    const [bIems, setBItems] = useState<billItem[]>([]);
    const [bills, setBills] = useState<bill[]>([]);
    const toastId = useRef<Id>();


    useEffect(() => {
        toastId.current = toast.info("Getting bills. Please Wait....", { autoClose: false, closeOnClick: false, })
        fetch(BACKEND_URL + '/bill/all', {
            method: "GET",
            credentials: "include"
        }).then((data) => {
            if(data.ok){
                data.json().then((datajson: bill[]) => {
                    toast.update(toastId.current!, {
                        render: "Loaded Data", 
                        autoClose: 2000
                    })
                    setBills(datajson)
                })
            }else{
                toast.update(toastId.current!, {
                    render: "Error Loading Data", 
                    autoClose: 3000
                })
            }
        })
    }, [])

    const openModal = () => {
        toastId.current = toast.info("Making bill. Please Wait....", { autoClose: false, closeOnClick: false, })
        fetch(BACKEND_URL + '/bill/make', {
            method: "GET",
            credentials: "include"
        }).then((data) => {
            if(data.ok){
                toast.update(toastId.current!, {
                    render: "Bill Created Sccessfully", 
                    autoClose: 2000
                })
            }else{
                toast.update(toastId.current!, {
                    render: "Error Creating Bill", 
                    autoClose: 3000
                })
            }
        })
    }

    return (
        <div>
            <TopNav />
            <SideNav />
            <div className="user-main">
                <div className="user-title">Bills Made</div>
                <div className="user-actions">
                    <div className="user-add">
                        <button className='user-add-btn' onClick={() => openModal()}>
                            <Plus /> New Bill
                        </button>
                    </div>
                </div>
                <div className="user-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Sl. No.</th>
                                <th>Generation Date</th>
                                <th>Generation Time</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {
                                bills.map((item, idx) => {
                                    const dateTime = new Date(item.bill_dt);
                                    return (
                                        <tr key={idx}>
                                            <td>{idx + 1}</td>
                                            <td>{dateTime.toLocaleDateString()}</td>
                                            <td>{dateTime.toLocaleTimeString()}</td>
                                            <td>
                                                <div className='btn-opt'>Download Bill</div>
                                            </td>
                                        </tr>
                                    )
                                })
                            }
                        </tbody>
                    </table>
                </div>
            </div>
            <Footer />
            <ToastContainer />
        </div>
    )
}

export default Abstract