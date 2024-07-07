import { useEffect, useState } from 'react'
import SideNav from '../components/SideNav'
import TopNav from '../components/TopNav'
import { BACKEND_URL } from '../constants'
import { ToastContainer, toast } from 'react-toastify';
import "../styles/Complaint.scss"
import { Plus } from 'lucide-react';
import Footer from '../components/Footer';
import AddCompModal from '../components/AddCompModal';
import CloseCompModal from '../components/CloseCompModal';
import CompDetailsModal from '../components/UpdateCompModal';

type complaint = {
    comp_id:string,
    comp_nos:string,
    comp_loc:string,
    comp_des:string,
    comp_stat:string,
    comp_date:string
}

const empty:complaint = {comp_id: "", comp_nos: "", comp_loc: "", comp_des: "", comp_stat: "", comp_date: ""}
function Complaint() {
    const [comps, setComps] = useState<complaint[]>([])
    const [filteredComps, setFilteredComps] = useState<complaint[]>([]);
    const [searchInput, setSearchInput] = useState<string>('');
    const [isModalOpen, setIsModalOpen] = useState<boolean>(false);
    const [isCloseModalOpen, setIsCloseModalOpen] = useState<boolean>(false);
    const [currComp, setCurrComp] = useState<complaint>(empty)
    const [isUpdateModalOpen, setIsUpdateModalOpen] = useState<boolean>(false)

    useEffect(() => {
        fetch(BACKEND_URL+'/comp/all', {
            method:"GET",
            credentials:'include'
        }).then((data) => {
            if(data.ok){
                data.json().then((jsondata:complaint[]) => {
                    setComps(jsondata)
                    setFilteredComps(jsondata)
                })
            }else{
                toast.error("Loading Error", {
                    position: "bottom-center"
              })
            }
        })
    }, [])

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
                                            <td>{item.comp_nos}</td>
                                            <td>{item.comp_loc}</td>
                                            <td>{item.comp_des}</td>
                                            <td>{item.comp_stat}</td>
                                            <td>{dateTime.toLocaleDateString()}</td>
                                            <td>{dateTime.toLocaleTimeString()}</td>
                                            <td>
                                                <div onClick={() => openCloseModal(item)}>Close</div>
                                                <div onClick={() => openUpdateModal(item)}>Update</div>
                                            </td>
                                        </tr>
                                    )
                                })
                            }
                        </tbody>
                    </table>
                </div>
            </div>
            <CloseCompModal isOpen={isCloseModalOpen} onRequestClose={closeCloseModal} comp={currComp}/>
            <AddCompModal isOpen={isModalOpen} onRequestClose={closeModal}/>
            <CompDetailsModal isOpen={isUpdateModalOpen} onRequestClose={closeUpdateModal} comp={currComp}/>
            <ToastContainer/>
            <Footer />
        </div>
    )
}

export default Complaint