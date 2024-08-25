import React, { useState, useEffect} from 'react';
import Modal from 'react-modal';
import { BACKEND_URL } from '../constants';
import { toast } from 'react-toastify';
import "../styles/InventoryDetailsModal.scss"


type InvenUsed = {
    id: string;
    item_id: string;
    item_name: string;
    item_used: number;
    item_desc: string;
    item_l: number;
    item_b: number;
    item_h: number;
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
    const [newQty, setNewQTy] = useState<number>(0);
    const [l, setL] = useState<number>(0);
    const [b, setB] = useState<number>(0);
    const [h, setH] = useState<number>(0);

    useEffect(() => {
        if (inveUse) {
            setNewQTy(inveUse.item_used);
            setL(inveUse.item_l);
            setB(inveUse.item_b);
            setH(inveUse.item_h)
        }
    }, [inveUse]);


    const handleQtyChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewQTy(Number(event.target.value));
        setL(0);
        setB(0);
        setH(0);
    };


    const handleUpdate = (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
        event.preventDefault()
        fetch(BACKEND_URL+"/inven/updtuse", {
            method:"POST",
            credentials:'include',
            body: JSON.stringify({item_qty_diff: newQty - inveUse.item_used, id: inveUse.id, item_id: inveUse.item_id, item_l_diff: l - inveUse.item_l, item_b_diff: b - inveUse.item_b, item_h_diff: h - inveUse.item_h})
        }).then((data) => {
            onRequestClose()
            if(data.ok){
                toast.success("Item Updated Successfully", {
                    position: "bottom-center"
                })
            }else{
                toast.error("Error updating Item", {
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

    useEffect(() => {
        let x:number = 0;
        if(l != 0 || b != 0 || h != 0) x = 1;
        if(l != 0) x*=l;
        if(b != 0) x*=b;
        if(h != 0) x*=h;
        setNewQTy(x)
    }, [l, b, h])


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
                            value={inveUse.item_name}
                            placeholder='Enter Item name'
                            readOnly
                        />
                    </div>
                </div>
                <div className="input-sm-line">
                    <div className="input-grp">
                        <label>Quantity Used:</label>
                        <input
                            type="number"
                            value={newQty}
                            onChange={handleQtyChange}
                            placeholder='Enter Item Quantity'
                        />
                    </div>
                </div>
                <div className="input-sm-line">
                    <div className="input-grp">
                        <label>Length Used:</label>
                        <input
                            type="number"
                            value={l}
                            onChange={(e) => setL(parseFloat(e.target.value))}
                            placeholder='Enter Item Quantity'
                        />
                    </div>
                    <div className="input-grp">
                        <label>Breadth Used:</label>
                        <input
                            type="number"
                            value={b}
                            onChange={(e) => setB(parseFloat(e.target.value))}
                            placeholder='Enter Item Quantity'
                        />
                    </div>
                    <div className="input-grp">
                        <label>Height Used:</label>
                        <input
                            type="number"
                            value={h}
                            onChange={(e) => setH(parseFloat(e.target.value))}
                            placeholder='Enter Item Quantity'
                        />
                    </div>
                </div>

                <label>Item Description: </label>
                <textarea value={inveUse.item_desc} readOnly className='btn-opt'></textarea>
                <button onClick={handleUpdate} className='btn-updt'>Update</button>
                <button onClick={handleDelete} className='btn-del'>Delete</button>
            </form>
            )}
        </Modal>
    );
}

export default UpdateInventUse;
