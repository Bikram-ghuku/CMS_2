import { useEffect, useState } from 'react'
import SideNav from '../components/SideNav'
import TopNav from '../components/TopNav'
import { BACKEND_URL } from '../constants'
import { ToastContainer, toast } from 'react-toastify';
import { Link } from 'react-router-dom';
import "../styles/Inventory.scss"
import { Plus } from 'lucide-react';
import Footer from '../components/Footer';
import AddInventoryModal from '../components/AddInventoryModal';

type item = {
    item_name:string,
    item_desc:string,
    item_qty:number,
    item_price:number,
    item_id:string
}


function Inventory() {
    const [comps, setComps] = useState<item[]>([])
    const [filteredComps, setFilteredComps] = useState<item[]>([]);
    const [searchInput, setSearchInput] = useState<string>('');
    const [isModalOpen, setIsModalOpen] = useState<boolean>(false);


    useEffect(() => {
        fetch(BACKEND_URL+'/inven/all', {
            method:"GET",
            credentials:'include'
        }).then((data) => {
            if(data.ok){
                data.json().then((jsondata:item[]) => {
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
                                <th>Name</th>
                                <th>Description</th>
                                <th>Cost</th>
                                <th>Quantity</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            {
                                filteredComps.map((item, idx) => {
                                    return (
                                        <tr key={idx}>
                                            <td>{item.item_name}</td>
                                            <td>{item.item_desc}</td>
                                            <td>{'₹'+item.item_price}</td>
                                            <td>{item.item_qty}</td>
                                            <td>
                                                <Link to={"./forgot_pswd/"+item.item_id}>View Details</Link>
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
            <ToastContainer/>
            <Footer />
        </div>
    )
}

export default Inventory