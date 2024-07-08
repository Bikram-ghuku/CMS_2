import { useEffect, useState, useRef } from 'react'
import Footer from '../components/Footer'
import SideNav from '../components/SideNav'
import TopNav from '../components/TopNav'
import "../styles/Invenused.scss"
import { BACKEND_URL } from '../constants'
import Invoice from '../components/Invoice'
import { useReactToPrint } from 'react-to-print';

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
    comp_id: string;
    comp_nos: string;
    comp_loc: string;
    comp_des: string;
    comp_stat: string;
    comp_date: string;
};

function Invenused() {
    const [comps, setComps] = useState<InvenUsed[]>([])
    const [filteredComps, setFilteredComps] = useState<InvenUsed[]>([]);
    const [searchInput, setSearchInput] = useState<string>('');
    const [isGenBillVisible, setGenBillVisible] = useState<boolean>(false)
    const [selectedItemsId, setSelectedItemsId] = useState<string[]>([]);
    const [selectedItem, setSelectedItem] = useState<InvenUsed[]>([]);
    const componentRef = useRef<HTMLDivElement>(null);

    useEffect(() => {
        fetch(BACKEND_URL+"/inven/useall", {
            method:"GET",
            credentials:"include"
        }).then((data) => {
            if(data.ok){
                data.json().then((dataJson:InvenUsed[]) => {
                    setComps(dataJson)
                    setFilteredComps(dataJson)
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
                                <th>Item Name</th>
                                <th>Item Description</th>
                                <th>Quantity Used</th>
                                <th>Complaint Number</th>
                                <th>Complaint Location</th>
                                <th>Used By</th>
                                <th>Price Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            {
                                filteredComps.map((item, idx) => {
                                    return (
                                        <tr key={idx}>
                                             <td>
                                                <input
                                                    type="checkbox"
                                                    checked={selectedItemsId.includes(item.id)}
                                                    onChange={() => handleCheckboxChange(item.id)}
                                                />
                                            </td>
                                            <td>{item.item_name}</td>
                                            <td>{item.item_desc}</td>
                                            <td>{item.item_used}</td>
                                            <td>{item.comp_nos}</td>
                                            <td>{item.comp_loc}</td>
                                            <td>{item.username}</td>
                                            <td>{'₹'+item.item_used * item.item_price}</td>
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
                    <Invoice ref={componentRef} selectedItems={selectedItem} />
                </div>
            </div>
            <Footer />
        </div>
    )
}

export default Invenused