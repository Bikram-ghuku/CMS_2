import React, {useState} from 'react';
import Modal from 'react-modal';
import { toast } from 'react-toastify';
import { BACKEND_URL } from '../constants'
import "../styles/AddInventoryModal.scss"

type complaint = {
    comp_id:string,
    comp_nos:string,
    comp_loc:string,
    comp_des:string,
    comp_stat:string,
    comp_date:string
}

interface AddInventoryModalProps {
    isOpen: boolean;
    onRequestClose: () => void;
    comp: complaint;
}

const CloseCompModal: React.FC<AddInventoryModalProps> = ({
    isOpen,
    onRequestClose,
    comp
}) => {
    const [newDesc, setNewDesc] = useState<string>('');

    const handleDescChange = (event: React.ChangeEvent<HTMLTextAreaElement>) => {
        setNewDesc(event.target.value);
    };

    const handleRegister = () => {
        const dateTime = new Date()
        console.log(dateTime.toUTCString())
        fetch(BACKEND_URL+"/comp/close", {
            method:"POST",
            credentials:"include",
            body:JSON.stringify({comp_nos: comp.comp_nos, comp_id: comp.comp_id , fin_text: newDesc, fin_datetime: dateTime.toISOString()})
        }).then((data) => {
            onRequestClose()
            setNewDesc('')
            if(data.ok){
                toast.success("Complaint Closed successfully", {
                    position: "bottom-center"
                })
            }else{
                toast.error("Error closing complaint", {
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
            ariaHideApp={false}
            overlayClassName="overlay"
        >
            <h2>Close Complaint</h2>
                <form>
                    <label>Complaint Number:</label>
                    <input
                        type="text"
                        value={comp.comp_nos}
                        placeholder='Enter complaint Number'
                        disabled
                    />
                    <label>Complaint Location:</label>
                    <input
                        type="text"
                        value={comp.comp_loc}
                        disabled
                    />
                    <label>Closing Text: </label>
                    <textarea value={newDesc} onChange={handleDescChange} placeholder='Enter Closing Message'></textarea>
                    <button type="button" onClick={handleRegister}>Close Complaint</button>
                </form>
        </Modal>
    );
}

export default CloseCompModal;
