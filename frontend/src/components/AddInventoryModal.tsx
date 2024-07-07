import React, {useState} from 'react';
import Modal from 'react-modal';
import { toast } from 'react-toastify';
import { BACKEND_URL } from '../constants'
import "../styles/AddInventoryModal.scss"


interface AddInventoryModalProps {
    isOpen: boolean;
    onRequestClose: () => void;
}

const AddInventoryModal: React.FC<AddInventoryModalProps> = ({
    isOpen,
    onRequestClose
}) => {
    const [newItemName, setNewItemName] = useState<string>('');
    const [newPrice, setNewPrice] = useState<number>(0);
    const [newQty, setNewQTy] = useState<number>(0);
    const [newDesc, setNewDesc] = useState<string>('');


    const handleRegister = (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
        event.preventDefault()
        const dateTime = new Date()
        console.log(dateTime.toUTCString())
        fetch(BACKEND_URL+"/inven/addItem", {
            method:"POST",
            credentials:"include",
            body:JSON.stringify({item_name: newItemName, item_qty: newQty, item_price: newPrice, item_desc: newDesc})
        }).then((data) => {
            setNewItemName('')
            setNewPrice(0)
            setNewQTy(0);
            setNewDesc('')
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
    return (
        <Modal
            isOpen={isOpen}
            onRequestClose={onRequestClose}
            contentLabel="New Inventory Modal"
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
    );
}

export default AddInventoryModal;
