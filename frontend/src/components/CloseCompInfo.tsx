import React from 'react'
import Modal from 'react-modal';
import { BACKEND_URL } from '../constants';
import { toast } from 'react-toastify';


interface FinDatetime {
    Time: string;
    Valid: boolean;
}

interface FinText {
    String: string;
    Valid: boolean;
}

type complaint = {
    comp_id:string,
    comp_nos:string,
    comp_loc:string,
    comp_des:string,
    comp_stat:string,
    comp_date:string,
    fin_datetime: FinDatetime,
    fin_text: FinText
}

interface AddInventoryModalProps {
    isOpen: boolean;
    onRequestClose: () => void;
    comp: complaint;
}

const CloseCompInfo:React.FC<AddInventoryModalProps> = ({
    isOpen,
    onRequestClose,
    comp
}) => {
    const dateTime = new Date(comp.fin_datetime.Time);
    const reOpen = (e: React.MouseEvent<HTMLButtonElement>) => {
        e.preventDefault()
        const dateTime = new Date()
        console.log(dateTime.toUTCString())
        fetch(BACKEND_URL+"/comp/open", {
            method:"POST",
            credentials:"include",
            body:JSON.stringify({comp_nos: comp.comp_nos, comp_id: comp.comp_id , fin_text: '', fin_datetime: dateTime.toISOString()})
        }).then((data) => {
            onRequestClose()
            if(data.ok){
                toast.success("Complaint ReOpened successfully", {
                    position: "bottom-center"
                })
            }else{
                toast.error("Error ReOpening complaint", {
                    position: "bottom-center"
                })
            }
        })
    }
    const handleDelete = () => {
        fetch(BACKEND_URL+'/comp/delete', {
            method: "POST",
            credentials:"include",
            body: JSON.stringify({comp_id: comp.comp_id})
        }).then((data) => {
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
    }
    return (
        <Modal
        isOpen={isOpen}
        onRequestClose={onRequestClose}
        contentLabel="New Inventory Modal"
        className="modal"
        ariaHideApp={false}
        overlayClassName="overlay"
    >
        <h2>Closed Complaint Info</h2>
            <form>
                <label>Complaint Number:</label>
                <input
                    type="text"
                    value={comp.comp_nos}
                    placeholder='Enter complaint Number'
                    disabled
                />
                <label>Complaint Closing Date Time:</label>
                <input
                    type="text"
                    value={dateTime.toLocaleString()}
                    disabled
                />
                <label>Closing Text: </label>
                <textarea value={comp.fin_text.String}placeholder='Enter Closing Message' disabled></textarea>
                <button onClick={reOpen}>Reopen</button>
                <button type='button' onClick={handleDelete} style={{background: "red"}}>Delete Complaint</button>
            </form>
    </Modal>
    )
}

export default CloseCompInfo