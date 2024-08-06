import { useEffect, useRef, useState } from 'react'
import SideNav from '../components/SideNav'
import TopNav from '../components/TopNav'
import { BACKEND_URL } from '../constants'
import { Id, ToastContainer, toast } from 'react-toastify'
import "../styles/Complaint.scss"
import { Plus } from 'lucide-react';
import Footer from '../components/Footer';
import AddCompModal from '../components/AddCompModal';
import CloseCompModal from '../components/CloseCompModal';
import CompDetailsModal from '../components/UpdateCompModal';
import CloseCompInfo from '../components/CloseCompInfo';
import InvoiceComp from '../components/InvoiceComp';
import { useReactToPrint } from 'react-to-print';
import InvoiceCompTable from '../components/InvoiceCompTable';
import { useDownloadExcel } from 'react-export-table-to-excel';


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
function Complaint() {
    const [comps, setComps] = useState<complaint[]>([])
    const [filteredComps, setFilteredComps] = useState<complaint[]>([]);
    const [searchInput, setSearchInput] = useState<string>('');
    const [isModalOpen, setIsModalOpen] = useState<boolean>(false);
    const [isCloseModalOpen, setIsCloseModalOpen] = useState<boolean>(false);
    const [currComp, setCurrComp] = useState<complaint>(empty)
    const [isUpdateModalOpen, setIsUpdateModalOpen] = useState<boolean>(false)
    const [isClInfoModalOpen, setClInfoModalOpen] = useState<boolean>(false);
    const componentRef = useRef<HTMLDivElement>(null);
    const tableRef = useRef<HTMLTableElement>(null);
    const [isGenBillVisible, setGenBillVisible] = useState<boolean>(false)
    const [selectedItem, setSelectedItem] = useState<complaint>(empty);
    const toastId = useRef<Id>();

    useEffect(() => {
        toastId.current = toast.info("Getting complaints. Please Wait....", { autoClose: false, closeOnClick: false, })
        fetch(BACKEND_URL+'/comp/all', {
            method:"GET",
            credentials:'include'
        }).then((data) => {
            if(data.ok){
                data.json().then((jsondata:complaint[]) => {
                    setComps(jsondata)
                    setFilteredComps(jsondata)
                })
                toast.update(toastId.current!, {
                    render: "Loaded Data", 
                    autoClose: 2000
                })
            }else{
                toast.update(toastId.current!, {
                    render: "Error Loading Data", 
                    autoClose: 3000
                })
            }
        }).catch((err) => {
            toast.update(toastId.current!, {
                render: "Error Loading Data: "+ err, 
                autoClose: 3000
            })
        })
    }, [])

    useEffect(() => {
        setGenBillVisible(selectedItem.comp_id !== "")
    }, [selectedItem])

    const handleSearchInputChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        const inputValue = event.target.value;
        setSearchInput(inputValue);
        filterComps(inputValue);
    };

    const filterComps = (searchText: string) => {
        const filtered = comps.filter((comp) =>
            comp.comp_des.toLowerCase().includes(searchText.toLowerCase()) ||
            comp.comp_loc.toLowerCase().includes(searchText.toLowerCase()) ||
            comp.comp_nos.toLowerCase().includes(searchText.toLowerCase())
        );
        setFilteredComps(filtered);
    };

    const openModal = () => {
        setIsModalOpen(true);
    };

    const closeModal = () => {
        setIsModalOpen(false);
    };

    const openCloseModal = (comp: complaint) => {
        setCurrComp(comp)
        setIsCloseModalOpen(true);
    };

    const closeCloseModal = () => {
        setIsCloseModalOpen(false);
    };

    const openUpdateModal = (comp: complaint) => {
        setCurrComp(comp)
        setIsUpdateModalOpen(true);
    };

    const closeUpdateModal = () => {
        setIsUpdateModalOpen(false);
    };

    const openClInfoModal = (comp: complaint) => {
        setCurrComp(comp)
        setClInfoModalOpen(true);
    };

    const closeClInfoModal = () => {
        setClInfoModalOpen(false);
    };

    const handlePrint = useReactToPrint({
        content: () => componentRef.current,
    });

    const { onDownload } = useDownloadExcel({
        currentTableRef: tableRef.current,
        filename: 'bill_table',
        sheet: 'bill'
    })

    const handleSel = (comp: complaint) => {
        if(selectedItem.comp_id === comp.comp_id) setSelectedItem(empty)
        else setSelectedItem(comp)
    }
    return (
        <div>
            <SideNav />
            <TopNav />
            <div className="user-main">
                <div className="user-title">Registered Complaints</div>
                <div className="user-actions">
                    <div className="user-search">
                        <input
                            placeholder='Enter text to search'
                            value={searchInput}
                            onChange={handleSearchInputChange}
                        />
                    </div>
                    <div className="user-add">
                        <button className='user-add-btn' onClick={() => openModal()}>
                            <Plus /> New Complaint
                        </button>
                    </div>
                </div>
                <div className="user-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Select</th>
                                <th>Number</th>
                                <th>Location</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            {
                                filteredComps.map((item, idx) => {
                                    const dateTime = new Date(item.comp_date);
                                    return (
                                        <tr key={idx}>
                                            <td><input type='checkbox' onChange={() => handleSel(item)} checked={selectedItem.comp_id === item.comp_id}/></td>
                                            <td>{item.comp_nos}</td>
                                            <td>{item.comp_loc}</td>
                                            <td>{item.comp_des}</td>
                                            <td>{item.comp_stat}</td>
                                            <td>{dateTime.toLocaleDateString()}</td>
                                            <td>{dateTime.toLocaleTimeString()}</td>
                                            <td>
                                                <div onClick={() => openUpdateModal(item)} className='btn-opt'>Update</div>
                                                {item.comp_stat === "open" ? <div onClick={() => openCloseModal(item)} className='btn-opt'>Close</div> : <div onClick={() => openClInfoModal(item)} className='btn-opt'>Info</div>}
                                            </td>
                                        </tr>
                                    )
                                })
                            }
                        </tbody>
                    </table>
                </div>
                <div className="user-genbill" hidden={!isGenBillVisible}>
                    <button hidden={!isGenBillVisible} onClick={handlePrint}>Generate Bill .pdf</button>
                    <button hidden={!isGenBillVisible} onClick={onDownload}>Generate Bill .xlsx</button>
                </div>
                <div style={{ display: 'none' }}>
                    <InvoiceComp ref={componentRef} CompId={selectedItem.comp_id} compDesc={selectedItem.comp_des} />
                    <InvoiceCompTable ref={tableRef} CompId={selectedItem.comp_id} compDesc={selectedItem.comp_des} />
                </div>
            </div>
            <CloseCompInfo isOpen={isClInfoModalOpen} onRequestClose={closeClInfoModal} comp={currComp} />
            <CloseCompModal isOpen={isCloseModalOpen} onRequestClose={closeCloseModal} comp={currComp}/>
            <AddCompModal isOpen={isModalOpen} onRequestClose={closeModal}/>
            <CompDetailsModal isOpen={isUpdateModalOpen} onRequestClose={closeUpdateModal} comp={currComp}/>
            <ToastContainer/>
            <Footer />
        </div>
    )
}

export default Complaint