import TopNav from '../components/TopNav'
import SideNav from '../components/SideNav'
import Footer from '../components/Footer'
import { Id, ToastContainer, toast } from 'react-toastify'
import { useEffect, useRef, useState } from 'react'
import { Plus } from 'lucide-react';
import "../styles/Complaint.scss"
import { BACKEND_URL } from '../constants'
import AbsComp from '../components/Abstract'
import { useReactToPrint } from 'react-to-print'
import Modal from 'react-modal';
import "../styles/AddInventoryModal.scss"

type bill = {
    bill_id: string;
    bill_dt: string;
    bill_wn: string;
}

const empty: bill = {bill_dt: "", bill_id: "", bill_wn: ""}

function Abstract() {
    const [bills, setBills] = useState<bill[]>([]);
    const [actBill, setActBill] = useState<bill>(empty);
    const [isModalOpen, setIsModalOpen] = useState<boolean>(false);
    const [workName, setWorkName] = useState<string>('');
    const toastId = useRef<Id>();
    const componentRef = useRef<HTMLDivElement>(null);
    const [isGenBillVisible, setGenBillVisible] = useState<boolean>(false);


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
                    if(datajson != null) setBills(datajson)
                })
            }else{
                toast.update(toastId.current!, {
                    render: "Error Loading Data", 
                    autoClose: 3000
                })
            }
        })
    }, [])

    const createBill = () => {
        toastId.current = toast.info("Making bill. Please Wait....", { autoClose: false, closeOnClick: false, });
        fetch(BACKEND_URL + '/bill/make', {
            method: "POST",
            credentials: "include",
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ work_name: workName })
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

            closeModal()
        })
    }

    useEffect(() => {
        setGenBillVisible(actBill.bill_id !== "")
    }, [actBill])

    const handleSel = (comp: bill) => {
        if(actBill.bill_id === comp.bill_id) setActBill(empty)
        else setActBill(comp)
    }

    const handlePrint = useReactToPrint({
        content: () => componentRef.current,
    });

    const openModal = () => {
        setWorkName('');
        setIsModalOpen(true);
    };

    const closeModal = () => {
        setIsModalOpen(false);
    };
    
    return (
        <div>
            <TopNav />
            <SideNav />
            <div className="user-main">
                <div className="user-title">Bills Made</div>
                <div className="user-actions">
                    <div className="user-add">
                        <button className='user-add-btn' onClick={() => openModal()}>
                            <Plus /> New Abstract
                        </button>
                    </div>
                </div>
                <div className="user-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Select</th>
                                <th>Generation Date</th>
                                <th>Generation Time</th>
                                <th>Work Name</th>
                            </tr>
                        </thead>
                        <tbody>
                            {
                                bills.map((item, idx) => {
                                    const dateTime = new Date(item.bill_dt);
                                    return (
                                        <tr key={idx}>
                                            <td><input type='checkbox' onChange={() => handleSel(item)} checked={actBill.bill_id === item.bill_id}/></td>
                                            <td>{dateTime.toLocaleDateString()}</td>
                                            <td>{dateTime.toLocaleTimeString()}</td>
                                            <td>{item.bill_wn}</td>
                                        </tr>
                                    )
                                })
                            }
                        </tbody>
                    </table>
                </div>
                <div className="user-genbill" hidden={!isGenBillVisible}>
                        <button hidden={!isGenBillVisible} onClick={handlePrint}>Generate Bill .pdf</button>
                    </div>
                <div style={{ display: 'none' }}>
                    <AbsComp ref={componentRef} CompId={actBill.bill_id} compDesc={actBill.bill_wn} />
                </div>
            </div>
            <Footer />
            <ToastContainer />
            <Modal
                isOpen={isModalOpen}
                onRequestClose={closeModal}
                contentLabel="Inventory Details Modal"
                ariaHideApp={false}
                className="modal"
                overlayClassName="overlay"
            >
                <h2>Create New Bill</h2>
                <form>
                    <label>Description: </label>
                    <textarea value={workName} onChange={(e) => setWorkName(e.target.value)} placeholder='Enter Complaint Description'></textarea>
                    <button type="button" onClick={createBill}>New Bill</button>
                </form>
            </Modal>
        </div>
    )
}

export default Abstract