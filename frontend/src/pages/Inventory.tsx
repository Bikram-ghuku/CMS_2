import { useEffect, useRef, useState } from 'react'
import SideNav from '../components/SideNav'
import TopNav from '../components/TopNav'
import { BACKEND_URL } from '../constants'
import { Id, ToastContainer, toast } from 'react-toastify'
import "../styles/Inventory.scss"
import { Plus } from 'lucide-react';
import Footer from '../components/Footer';
import AddInventoryModal from '../components/AddInventoryModal';
import InventoryDetailsModal from '../components/InventoryDetailsModal';
import InvUseDesc from '../components/InvUseDesc';

type item = {
    item_nos:number;
    item_name:string;
    item_desc:string;
    item_qty:number;
    item_price:number;
    item_id:string;
    item_unit:string;
}

const empty:item = {item_name:"", item_desc:"", item_price: 0, item_qty:0, item_id:"", item_unit:"", item_nos: 0}

function Inventory() {
    const [comps, setComps] = useState<item[]>([])
    const [filteredComps, setFilteredComps] = useState<item[]>([]);
    const [searchInput, setSearchInput] = useState<string>('');
    const [isModalOpen, setIsModalOpen] = useState<boolean>(false);
    const [isDetModalOpen, setIsDetModalOpen] = useState<boolean>(false);
    const [detItem, setDetItem] = useState<item>(empty);
    const [isLocModalOpen, setIsLocModalOpen] = useState<boolean>(false);
    const [lDesc, setLDesc] = useState<string>('');
    const [compI, setCompI] = useState<string>('');
    const toastId = useRef<Id>();

    useEffect(() => {
        toastId.current = toast.info("Getting Inventory. Please Wait....", { autoClose: false, closeOnClick: false, })
        fetch(BACKEND_URL+'/inven/all', {
            method:"GET",
            credentials:'include'
        }).then((data) => {
            if(data.ok){
                data.json().then((jsondata:item[]) => {
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

    const handleSearchInputChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        const inputValue = event.target.value;
        setSearchInput(inputValue);
        filterComps(inputValue);
    };

    const filterComps = (searchText: string) => {
        const filtered = comps.filter((comp) => 
            comp.item_desc.toLowerCase().includes(searchText.toLowerCase()) ||
            comp.item_name.toLowerCase().includes(searchText.toLowerCase())
        );
        setFilteredComps(filtered);
    };

    const openModal = () => {
        setIsModalOpen(true);
    };

    const closeModal = () => {
        setIsModalOpen(false);
    };

    const openDetModal = (itemdata: item) => {
        setDetItem(itemdata);
        setIsDetModalOpen(true);
    };

    const closeDetModal = () => {
        setIsDetModalOpen(false);
    };

    const openLocModal = (itemdata: item) => {
        setLDesc(itemdata.item_desc);
        setCompI(itemdata.item_id);
        setIsLocModalOpen(true);
    };

    const closeLocModal = () => {
        setIsLocModalOpen(false);
    };


    return (
        <div>
            <SideNav />
            <TopNav />
            <div className="user-main">
                <div className="user-title">Available Inventory</div>
                <div className="user-actions">
                    <div className="user-search">
                        <input
                            placeholder='Enter description to search'
                            value={searchInput}
                            onChange={handleSearchInputChange}
                        />
                    </div>
                    <div className="user-add">
                        <button className='user-add-btn' onClick={() => openModal()}>
                            <Plus /> New Inventory
                        </button>
                    </div>
                </div>
                <div className="user-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Sl No.</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Unit</th>
                                <th>Quantity</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            {
                                filteredComps.map((item, idx) => {
                                    return (
                                        <tr key={idx}>
                                            <td>{item.item_nos}</td>
                                            <td>{item.item_name}</td>
                                            <td style={{width: "50%"}}>{item.item_desc}</td>
                                            <td>{item.item_unit}</td>
                                            <td>{item.item_qty}</td>
                                            <td>
                                                <div onClick={() => openDetModal(item)} className='btn-opt'>Details</div>
                                                <div onClick={() => openLocModal(item)} className='btn-opt'style={{display: "none"}}>Usage</div>
                                            </td>
                                        </tr>
                                    )
                                })
                            }
                        </tbody>
                    </table>
                </div>
            </div>
            <AddInventoryModal isOpen={isModalOpen} onRequestClose={closeModal}/>
            <InventoryDetailsModal isOpen={isDetModalOpen} onRequestClose={closeDetModal} item={detItem}/>
            <InvUseDesc isOpen={isLocModalOpen} onRequestClose={closeLocModal} desc={lDesc} compId={compI}/>
            <ToastContainer/>
            <Footer />
        </div>
    )
}

export default Inventory