import React, { useState, useEffect} from 'react';
import Modal from 'react-modal';
import { BACKEND_URL } from '../constants';
import { toast } from 'react-toastify';
import "../styles/InventoryDetailsModal.scss"


type item = {
    item_name:string,
    item_desc:string,
    item_qty:number,
    item_price:number,
    item_id:string,
    item_unit:string
}

interface InventoryDetailsModalProps {
    isOpen: boolean;
    onRequestClose: () => void;
    item: item;
}

const InventoryDetailsModal: React.FC<InventoryDetailsModalProps> = ({
    isOpen,
    onRequestClose,
    item,
}) => {
    const [newItemName, setNewItemName] = useState<string>(item.item_name);
    const [newPrice, setNewPrice] = useState<number>(item.item_price);
    const [newQty, setNewQTy] = useState<number>(item.item_qty);
    const [newDesc, setNewDesc] = useState<string>(item.item_desc);
    const [newUnit, setNewUnit] = useState<string>(item.item_unit);

    useEffect(() => {
        if (item) {
            setNewItemName(item.item_name);
            setNewPrice(item.item_price);
            setNewQTy(item.item_qty);
            setNewDesc(item.item_desc);
            setNewUnit(item.item_unit)
        }
    }, [item]);

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

    const handleItemUnitChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewUnit(event.target.value)
    }


    const handleUpdate = (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
        event.preventDefault()
        fetch(BACKEND_URL+"/inven/invUpdate", {
            method:"POST",
            credentials:'include',
            body: JSON.stringify({item_id: item.item_id, item_name: newItemName, item_desc: newDesc, item_price: newPrice, item_qty: newQty, item_unit: newUnit})
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

    const handleDelete = (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
        event.preventDefault()
        fetch(BACKEND_URL+"/inven/delinv",{
            method: "POST",
            credentials:'include',
            body: JSON.stringify({item_id: item.item_id})
        }).then((data) => {
            onRequestClose()
            if(data.ok){
                toast.success("Item Deleted successfully", {
                    position: "bottom-center"
                })
            }else{
                toast.error("Error deleting item", {
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
            {item && (
                <form >
                <div className="input-sm-line">
                    <div className="input-grp">
                        <label>Item Name:</label>
                        <input
                            type="text"
                            value={newItemName}
                            onChange={handleItemNameChange}
                            placeholder='Enter Item name'
                        />
                    </div>
                    <div className="input-grp">
                        <label>Item Unit:</label>
                        <input
                            type="text"
                            value={newUnit}
                            onChange={handleItemUnitChange}
                            placeholder='Enter Item Unit'
                        />
                    </div>
                </div>
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
                <button onClick={handleUpdate} className='btn-updt'>Update</button>
                <button onClick={handleDelete} className='btn-del'>Delete</button>
            </form>
            )}
        </Modal>
    );
}

export default InventoryDetailsModal;
