import React, { useState, useEffect} from 'react';
import Modal from 'react-modal';
import { BACKEND_URL } from '../constants';
import { toast } from 'react-toastify';
import "../styles/InventoryDetailsModal.scss"
import "../styles/UpdateCompModal.scss"

type complaint = {
    comp_id:string,
    comp_nos:string,
    comp_loc:string,
    comp_des:string,
    comp_stat:string,
    comp_date:string
}

type item = {
    item_name:string,
    item_desc:string,
    item_qty:number,
    item_price:number,
    item_id:string
}


interface InventoryDetailsModalProps {
    isOpen: boolean;
    onRequestClose: () => void;
    comp: complaint;
}

const empty:item = {item_name:"", item_desc:"", item_price: 0, item_qty:0, item_id:""}

const CompDetailsModal: React.FC<InventoryDetailsModalProps> = ({
    isOpen,
    onRequestClose,
    comp,
}) => {
    const [newCompNos, setNewCompNo] = useState<string>('');
    const [newLoc, setNewLoc] = useState<string>('');
    const [newDesc, setNewDesc] = useState<string>('');
    const [invenItems, setInvenItem] = useState<item[]>([])
    const [itemSel, setItemSel] = useState<item>(empty);
    const [quant, setQuant] = useState<number>(0)
    useEffect(() => {
        fetchInvenItems()
        if (comp) {
            setNewCompNo(comp.comp_loc);
            setNewLoc(comp.comp_loc)
            setNewDesc(comp.comp_des);
        }
    }, [comp]);

    const fetchInvenItems = () => {
        fetch(BACKEND_URL+'/inven/all', {
            method:"GET",
            credentials:"include"
        }).then((data) => {
            if(data.ok){
                data.json().then((dataJson:item[]) => {
                    setInvenItem(dataJson)
                })
            }
        })
    }

    const handleCompNosChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewCompNo(event.target.value);
    };

    const handleLocChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewLoc(event.target.value);
    };

    const handleDescChange = (event: React.ChangeEvent<HTMLTextAreaElement>) => {
        setNewDesc(event.target.value);
    };

    const handleAddInven = (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
        event.preventDefault()
        fetch(BACKEND_URL+"/inven/use", {
            method: "POST",
            credentials: "include",
            body: JSON.stringify({comp_id: comp.comp_id, item_id: itemSel.item_id, item_qty:quant})
        }).then((data) => {
            if(data.ok){
                toast.success("Inventory added to Complaint", {
                    position: "bottom-center"
                })
            }else{
                toast.error("Error adding Inventory to complaint", {
                    position: "bottom-center"
                })
            }
        })
    }

    const onSelChange = (event: React.ChangeEvent<HTMLSelectElement>) => {
        var foundItem = invenItems.find(itemFind => itemFind.item_id === event.target.value)
        setItemSel(foundItem!)
    }

    const handleUpdate = (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
        event.preventDefault()
        const time = new Date()
        console.log({comp_id: comp.comp_id, comp_nos: newCompNos, comp_loc: newLoc, comp_des: newDesc, comp_date: time.toISOString()})
        fetch(BACKEND_URL+"/comp/update", {
            method:"POST",
            credentials:'include',
            body: JSON.stringify({comp_id: comp.comp_id, comp_nos: newCompNos, comp_loc: newLoc, comp_des: newDesc, comp_date: time.toISOString()})
        }).then((data) => {
            onRequestClose()
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
    }

    return (
        <Modal
            isOpen={isOpen}
            onRequestClose={onRequestClose}
            contentLabel="Inventory Details Modal"
            ariaHideApp={false}
            className="modal"
            overlayClassName="overlay"
        >
            <h2>Inventory Details</h2>
            {comp && (
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
                <label>Comp Description:</label>
                <textarea value={newDesc} onChange={handleDescChange} placeholder='Enter Item Description'></textarea>
                <div className="item-add">
                    <div className="item-add-item">
                        <label>Select Inventory item</label>
                        <select value={itemSel.item_id} onChange={onSelChange}>
                            {invenItems.map((item, idx) => (
                                <option key={idx} value={item.item_id}>{item.item_name}</option>
                            ))}
                        </select>
                    </div>
                    <div className="item-add-item">
                        <label>Select Quantity</label>
                        <input type='number' placeholder='Enter quantity' onChange={e => setQuant(parseFloat(e.target.value))} value={quant}/>
                    </div>
                </div>
                <button onClick={handleAddInven} className='btn-updt'>Add Inventory Item</button>
                <button onClick={handleUpdate} className='btn-add'>Update</button>
            </form>
            )}
        </Modal>
    );
}

export default CompDetailsModal;
