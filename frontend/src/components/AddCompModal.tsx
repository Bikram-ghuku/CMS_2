import React, {useState} from 'react';
import Modal from 'react-modal';
import { toast } from 'react-toastify';
import { BACKEND_URL } from '../constants'
import "../styles/AddInventoryModal.scss"


interface AddInventoryModalProps {
    isOpen: boolean;
    onRequestClose: () => void;
}

const AddCompModal: React.FC<AddInventoryModalProps> = ({
    isOpen,
    onRequestClose
}) => {
    const [newCompNos, setNewCompNos] = useState<string>('');
    const [newLoc, setNewLoc] = useState<string>('');
    const [newDesc, setNewDesc] = useState<string>('');


    const handleCompNosChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewCompNos(event.target.value);
    };

    const handleLocChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewLoc(event.target.value);
    };

    const handleDescChange = (event: React.ChangeEvent<HTMLTextAreaElement>) => {
        setNewDesc(event.target.value);
    };


    const handleRegister = () => {
        const dateTime = new Date()
        console.log(dateTime.toUTCString())
        fetch(BACKEND_URL+"/comp/add", {
            method:"POST",
            credentials:"include",
            body:JSON.stringify({comp_nos: newCompNos, comp_loc: newLoc, comp_des: newDesc, comp_date: dateTime.toISOString()})
        }).then((data) => {
            onRequestClose()
            setNewCompNos('')
            setNewLoc('')
            setNewDesc('')
            if(data.ok){
                toast.success("New Complaint added successfully", {
                    position: "bottom-center"
                })
            }else{
                toast.error("Error adding new complaint", {
                    position: "bottom-center"
                })
            }
        })
    };
    return (
        <Modal
            isOpen={isOpen}
            onRequestClose={onRequestClose}
            contentLabel="New Inventory Modal"
            className="modal"
            overlayClassName="overlay"
        >
            <h2>New Complaint</h2>
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
                    <label>Complaint Description:</label>
                    <textarea value={newDesc} onChange={handleDescChange} placeholder='Enter Complaint Description'></textarea>
                    <button type="button" onClick={handleRegister}>Add Complaint</button>
                </form>
        </Modal>
    );
}

export default AddCompModal;
