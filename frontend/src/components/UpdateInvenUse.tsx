import React, { useState, useEffect} from 'react';
import Modal from 'react-modal';
import { BACKEND_URL } from '../constants';
import { toast } from 'react-toastify';
import "../styles/InventoryDetailsModal.scss"


type InvenUsed = {
    id: string;
    item_name: string;
    item_qty: number;
};

interface InventoryDetailsModalProps {
    isOpen: boolean;
    onRequestClose: () => void;
    inveUse: InvenUsed;
}

const UpdateInventUse: React.FC<InventoryDetailsModalProps> = ({
    isOpen,
    onRequestClose,
    inveUse,
}) => {
    const [newItemName, setNewItemName] = useState<string>('');
    const [newQty, setNewQTy] = useState<number>(0);

    useEffect(() => {
        if (inveUse) {
            setNewItemName(inveUse.item_name);
            setNewQTy(inveUse.item_qty);
        }
    }, [inveUse]);

    const handleItemNameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewItemName(event.target.value);
    };

    const handleQtyChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewQTy(Number(event.target.value));
    };


    const handleUpdate = (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
        event.preventDefault()
        fetch(BACKEND_URL+"/inven/invUpdate", {
            method:"POST",
            credentials:'include',
            body: JSON.stringify({item_name: newItemName, item_qty: newQty})
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
        fetch(BACKEND_URL+"/inven/deluse",{
            method: "POST",
            credentials:'include',
            body: JSON.stringify({id: inveUse.id})
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
            {inveUse && (
                <form >
                <div className="input-sm-line">
                    <div className="input-grp">
                        <label>Item Name:</label>
                        <input
                            type="text"
                            value={newItemName}
                            onChange={handleItemNameChange}
                            placeholder='Enter Item name'
                            readOnly
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
                </div>
                <button onClick={handleUpdate} className='btn-updt'>Update</button>
                <button onClick={handleDelete} className='btn-del'>Delete</button>
            </form>
            )}
        </Modal>
    );
}

export default UpdateInventUse;
