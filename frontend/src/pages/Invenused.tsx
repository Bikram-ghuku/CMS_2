import { useEffect, useState, useRef } from 'react'
import Footer from '../components/Footer'
import SideNav from '../components/SideNav'
import TopNav from '../components/TopNav'
import "../styles/Invenused.scss"
import { BACKEND_URL } from '../constants'
import Invoice from '../components/Invoice'
import { useReactToPrint } from 'react-to-print';
import UpdateInventUse from '../components/UpdateInvenUse'
import { ToastContainer } from 'react-toastify'

type InvenUsed = {
    id: string;
    item_used: number;
    user_id: string;
    username: string;
    role: string;
    item_id: string;
    item_name: string;
    item_qty: number;
    item_price: number;
    item_desc: string;
    item_unit: string;
    item_l: number;
    item_b: number;
    item_h: number;
    comp_id: string;
    comp_nos: string;
    comp_loc: string;
    comp_des: string;
    comp_stat: string;
    comp_date: string;
    bill_no:string;
    upto_use: number;
    upto_amt: number;
};

const empty:InvenUsed = {
    id: "", item_used:0, user_id:"", username:"", role:"", 
    item_id:"", item_name:"", item_qty: 0, item_price: 0, item_desc: "", item_unit:"", 
    item_l: 0, item_b: 0, item_h: 0, bill_no:"",
    comp_id:"", comp_nos:"", comp_loc:"", comp_des:"", comp_stat:"", comp_date:"",
    upto_use: 0, upto_amt: 0
};

type item = {
    item_name:string;
    item_desc:string;
    item_qty:number;
    item_price:number;
    item_id:string;
    item_unit:string
}

function Invenused() {
    const [comps, setComps] = useState<InvenUsed[]>([])
    const [filteredComps, setFilteredComps] = useState<InvenUsed[]>([]);
    const [searchInput, setSearchInput] = useState<string>('');
    const [isGenBillVisible, setGenBillVisible] = useState<boolean>(false)
    const [selectedItemsId, setSelectedItemsId] = useState<string[]>([]);
    const [selectedItem, setSelectedItem] = useState<InvenUsed[]>([]);
    const componentRef = useRef<HTMLDivElement>(null);
    const [editeModalOpen, setEditModalOpen] = useState<boolean>(false);
    const [activeItem, setActiveItem] = useState<InvenUsed>(empty);
    const [allItem, setAllItem] = useState<item[]>([]);

    useEffect(() => {
        fetch(BACKEND_URL + "/inven/all", {
            method: "GET",
            credentials: "include"
        }).then((data) => {
            if(data.ok){
                data.json().then((dataJson: item[]) => {
                    if(dataJson != null) setAllItem(dataJson)
                })
            }
        })
    }, [])

    useEffect(() => {
        fetch(BACKEND_URL+"/inven/useall", {
            method:"GET",
            credentials:"include"
        }).then((data) => {
            if(data.ok){
                data.json().then((dataJson:InvenUsed[]) => {
                    if(dataJson != null){
                        setComps(dataJson)
                        setFilteredComps(dataJson)
                    }
                })
            }
        })
    }, [])

    useEffect(() => {
        setGenBillVisible(selectedItemsId.length != 0)
    }, [selectedItemsId])

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

    const handleCheckboxChange = (itemId: string) => {
        setSelectedItemsId((prevSelected) =>
            prevSelected.includes(itemId)
                ? prevSelected.filter((id) => id !== itemId)
                : [...prevSelected, itemId]
        );

        setSelectedItem((prev) => {
            if (prev.some(item => item.id === itemId)) {
                return prev.filter(item => item.id !== itemId);
            } else {
                const newItem: InvenUsed = comps.find(item => item.id === itemId)!;
                return [...prev, newItem];
            }
        });
    };

    const handlePrint = useReactToPrint({
        content: () => componentRef.current,
    });

    const handleAllSel = () => {
        if (selectedItemsId.length === filteredComps.length) {
            setSelectedItemsId([]);
            setSelectedItem([]);
        } else {
            const allIds = filteredComps.map(item => item.id);
            setSelectedItemsId(allIds);
            setSelectedItem(filteredComps);
        }
    }

    const handleClose = () => {
        setEditModalOpen(false)
    }

    const handleOpen = (item: InvenUsed) => {
        setActiveItem(item)
        setEditModalOpen(true)
    }

    return (
        <div>
            <SideNav />
            <TopNav />
            <div className="user-main">
                <div className="user-title">Used Inventory</div>
                <div className="user-actions">
                    <div className="user-search">
                        <input
                            placeholder='Enter description to search'
                            value={searchInput}
                            onChange={handleSearchInputChange}
                        />
                    </div>
                </div>
                <div className="user-table">
                    <table>
                        <thead>
                            <tr>
                                <th>
                                    <input 
                                        type='checkbox'
                                        onChange={() => handleAllSel()}
                                    />
                                </th>
                                <th>Item Desc</th>
                                <th>Quantity Used</th>
                                <th>Length</th>
                                <th>Breadth</th>
                                <td>Height</td>
                                <th>Complaint No</th>
                                <th>Used By</th>
                                <th>Price Total</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {
                                filteredComps.map((item, idx) => {
                                    if(item.item_used === 0) return
                                    return (
                                        <tr key={idx}>
                                             <td>
                                                <input
                                                    type="checkbox"
                                                    checked={selectedItemsId.includes(item.id)}
                                                    onChange={() => handleCheckboxChange(item.id)}
                                                />
                                            </td>
                                            <td>{item.item_desc}</td>
                                            <td>{item.item_used}</td>
                                            <td>{item.item_l === 0 ? "nil" : item.item_l}</td>
                                            <td>{item.item_b === 0 ? "nil" : item.item_b}</td>
                                            <td>{item.item_h === 0 ? "nil" : item.item_h}</td>
                                            <td>{item.comp_nos}</td>
                                            <td>{item.username}</td>
                                            <td>{'₹'+item.item_used * item.item_price}</td>
                                            <td>
                                                <div onClick={() => handleOpen(item)} className='btn-opt'>
                                                    Edit
                                                </div>
                                            </td>
                                        </tr>
                                    )
                                })
                            }
                        </tbody>
                    </table>
                </div>

                <div className="user-genbill" hidden={!isGenBillVisible}>
                    <button hidden={!isGenBillVisible} onClick={handlePrint}>Generate Bill</button>
                </div>
                <div style={{ display: 'none' }}>
                    <Invoice ref={componentRef} selectedItems={selectedItem} allItems={allItem}/>
                </div>
            </div>
            <Footer />
            <UpdateInventUse onRequestClose={handleClose} inveUse={activeItem} isOpen={editeModalOpen}/>
            <ToastContainer />
        </div>
    )
}

export default Invenused