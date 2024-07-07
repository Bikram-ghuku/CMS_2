import { useEffect, useState } from 'react'
import SideNav from '../components/SideNav'
import TopNav from '../components/TopNav'
import { BACKEND_URL } from '../constants'
import { ToastContainer, toast } from 'react-toastify';
import { Link } from 'react-router-dom';
import "../styles/Complaint.scss"
import { Plus } from 'lucide-react';
import Modal from 'react-modal'
import Footer from '../components/Footer';

type complaint = {
    comp_id:string,
    comp_nos:string,
    comp_loc:string,
    comp_des:string,
    comp_stat:string,
    comp_date:string
}


function Complaint() {
    const [comps, setComps] = useState<complaint[]>([])
    const [filteredComps, setFilteredComps] = useState<complaint[]>([]);
    const [searchInput, setSearchInput] = useState<string>('');
    const [isModalOpen, setIsModalOpen] = useState<boolean>(false);
    const [newCompNos, setNewCompNos] = useState<string>('');
    const [newLoc, setNewLoc] = useState<string>('');
    const [newDesc, setNewDesc] = useState<string>('');

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

    const handleCompNosChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewCompNos(event.target.value);
    };

    const handleLocChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewLoc(event.target.value);
    };

    const handleDescChange = (event: React.ChangeEvent<HTMLTextAreaElement>) => {
        setNewDesc(event.target.value);
    };


    const handleRegister = () => {
        const dateTime = new Date()
        console.log(dateTime.toUTCString())
        fetch(BACKEND_URL+"/comp/add", {
            method:"POST",
            credentials:"include",
            body:JSON.stringify({comp_nos: newCompNos, comp_loc: newLoc, comp_des: newDesc, comp_date: dateTime.toISOString()})
        }).then((data) => {
            setIsModalOpen(false)
            setNewCompNos('')
            setNewLoc('')
            setNewDesc('')
            if(data.ok){
                toast.success("New Complaint added successfully", {
                    position: "bottom-center"
                })
            }else{
                toast.error("Error adding new complaint", {
                    position: "bottom-center"
                })
            }
        })
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
                                                <Link to={"./forgot_pswd/"+item.comp_id}>View Details</Link>
                                            </td>
                                        </tr>
                                    )
                                })
                            }
                        </tbody>
                    </table>
                </div>
            </div>
            <Modal
                isOpen={isModalOpen}
                onRequestClose={closeModal}
                contentLabel="New Complaint Modal"
                className="modal"
                overlayClassName="overlay"
            >
                <h2>New Complaint</h2>
                <form>
                    <label>Complaint Number:</label>
                    <input
                        type="text"
                        value={newCompNos}
                        onChange={handleCompNosChange}
                        placeholder='Enter complaint Number'
                    />
                    <label>Complaint Location:</label>
                    <input
                        type="text"
                        value={newLoc}
                        onChange={handleLocChange}
                        placeholder='Enter Complaint Location'
                    />
                    <label>Complaint Description:</label>
                    <textarea value={newDesc} onChange={handleDescChange} placeholder='Enter Complaint Description'></textarea>
                    <button type="button" onClick={handleRegister}>Add Complaint</button>
                </form>
            </Modal>
            <ToastContainer/>
            <Footer />
        </div>
    )
}

export default Complaint