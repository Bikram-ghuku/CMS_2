import React, { useState, useEffect } from 'react';
import Modal from 'react-modal';
import { BACKEND_URL } from '../constants';
import { toast } from 'react-toastify';
import "../styles/UpdateCompModal.scss";

type Complaint = {
    comp_id: string;
    comp_nos: string;
    comp_loc: string;
    comp_des: string;
    comp_stat: string;
    comp_date: string;
};

// type Item = {
//     item_name: string;
//     item_desc: string;
//     item_qty: number;
//     item_price: number;
//     item_id: string;
//     item_nos: number;
// };

interface InventoryDetailsModalProps {
    isOpen: boolean;
    onRequestClose: () => void;
    comp: Complaint;
}

// const emptyItem: Item = { item_name: "", item_desc: "", item_price: 0, item_qty: 0, item_id: "", item_nos: 0 };

const CompDetailsModal: React.FC<InventoryDetailsModalProps> = ({
    isOpen,
    onRequestClose,
    comp,
}) => {
    const [newCompNos, setNewCompNo] = useState<string>('');
    const [newLoc, setNewLoc] = useState<string>('');
    const [newDesc, setNewDesc] = useState<string>('');

    useEffect(() => {
        if (comp) {
            setNewCompNo(comp.comp_nos);
            setNewLoc(comp.comp_loc);
            setNewDesc(comp.comp_des);
        }
    }, [comp]);


    const handleCompNosChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewCompNo(event.target.value);
    };

    const handleLocChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewLoc(event.target.value);
    };

    const handleDescChange = (event: React.ChangeEvent<HTMLTextAreaElement>) => {
        setNewDesc(event.target.value);
    };

    const handleUpdate = (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
        event.preventDefault();
        const time = new Date();
        fetch(BACKEND_URL + "/comp/update", {
            method: "POST",
            credentials: 'include',
            body: JSON.stringify({ comp_id: comp.comp_id, comp_nos: newCompNos, comp_loc: newLoc, comp_des: newDesc, comp_date: time.toISOString() }),
        }).then((data) => {
            onRequestClose();
            if (data.ok) {
                toast.success("Complaint updated successfully", {
                    position: "bottom-center",
                });
            } else {
                toast.error("Error updating complaint", {
                    position: "bottom-center",
                });
            }
        });
    };

    return (
        <Modal
            isOpen={isOpen}
            onRequestClose={onRequestClose}
            contentLabel="Inventory Details Modal"
            ariaHideApp={false}
            className="modal"
            overlayClassName="overlay"
        >
            <h2>Complain Details</h2>
            {comp && (
                <form>
                    <label>Complaint Number:</label>
                    <input
                        type="text"
                        value={newCompNos}
                        onChange={handleCompNosChange}
                        placeholder="Enter complaint Number"
                    />
                    <label>Complaint Location:</label>
                    <input
                        type="text"
                        value={newLoc}
                        onChange={handleLocChange}
                        placeholder="Enter Complaint Location"
                    />
                    <label>Complaint Description:</label>
                    <textarea
                        value={newDesc}
                        onChange={handleDescChange}
                        placeholder="Enter Complaint Description"
                    ></textarea>
                    <button onClick={handleUpdate} className="btn-add">Update</button>
                </form>
            )}
        </Modal>
    );
};

export default CompDetailsModal;
