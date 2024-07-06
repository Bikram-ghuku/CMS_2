import { useEffect, useState } from 'react'
import SideNav from '../components/SideNav'
import TopNav from '../components/TopNav'
import { BACKEND_URL } from '../constants'
import { ToastContainer, toast } from 'react-toastify';
import { Link } from 'react-router-dom';
import "../styles/Inventory.scss"
import { Plus } from 'lucide-react';
import Modal from 'react-modal'
import Footer from '../components/Footer';

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
    const [newItemName, setNewItemName] = useState<string>('');
    const [newPrice, setNewPrice] = useState<number>(0);
    const [newQty, setNewQTy] = useState<number>(0);
    const [newDesc, setNewDesc] = useState<string>('');

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
            comp.item_desc.toLowerCase().includes(searchText.toLowerCase())
        );
        setFilteredComps(filtered);
    };

    const openModal = () => {
        setIsModalOpen(true);
    };

    const closeModal = () => {
        setIsModalOpen(false);
    };

    const handleItemNameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewItemName(event.target.value);
    };

    const handleQtyChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewQTy(Number(event.target.value));
    };

    const handlePriceChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewPrice(Number(event.target.value));
    };

    const handleDescChange = (event: React.ChangeEvent<HTMLTextAreaElement>) => {
        setNewDesc(event.target.value);
    };


    const handleRegister = () => {
        const dateTime = new Date()
        console.log(dateTime.toUTCString())
        fetch(BACKEND_URL+"/inven/addItem", {
            method:"POST",
            credentials:"include",
            body:JSON.stringify({item_name: newItemName, item_qty: newQty, item_price: newPrice, item_desc: newDesc})
        }).then((data) => {
            setIsModalOpen(false)
            setNewItemName('')
            setNewPrice(0)
            setNewQTy(0);
            setNewDesc('')
            if(data.ok){
                toast.success("New item added successfully", {
                    position: "bottom-center"
                })
            }else{
                toast.error("Error adding new item", {
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
            <Modal
                isOpen={isModalOpen}
                onRequestClose={closeModal}
                contentLabel="New User Modal"
                className="modal"
                overlayClassName="overlay"
            >
                <h2>New Inventory</h2>
                <form>
                    <label>Item Name:</label>
                    <input
                        type="text"
                        value={newItemName}
                        onChange={handleItemNameChange}
                        placeholder='Enter Item name'
                    />
                    <div className="input-sm-line">
                        <div className="input-grp">
                            <label>Item Quantity:</label>
                            <input
                                type="number"
                                value={newQty}
                                onChange={handleQtyChange}
                                placeholder='Enter Item Quantity'
                            />
                        </div>
                        <div className="input-grp">
                            <label>Item Price:</label>
                            <input
                                type="number"
                                value={newPrice}
                                onChange={handlePriceChange}
                                placeholder='Enter Item Price'
                            />
                        </div>
                    </div>
                    <label>Item Description:</label>
                    <textarea value={newDesc} onChange={handleDescChange} placeholder='Enter Item Description'></textarea>
                    <button type="button" onClick={handleRegister}>Add Item</button>
                </form>
            </Modal>
            <ToastContainer/>
            <Footer />
        </div>
    )
}

export default Inventory