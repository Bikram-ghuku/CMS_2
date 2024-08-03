import React, { useEffect, useState } from 'react'
import Modal from 'react-modal'
import { BACKEND_URL } from '../constants';

interface AddUserModalProps {
    desc: string;
    compId: string;
    isOpen: boolean;
    onRequestClose: () => void;
}

type invenUse = {
    comp_nos: string;
    comp_loc: string;
    qty_used: string;
    usedBy: string;
}

const InvUseDesc: React.FC<AddUserModalProps> = ({desc, compId, isOpen, onRequestClose}) =>  {
    const [items, setItems] = useState<invenUse[]>([]);

    useEffect(() => {
        fetch(BACKEND_URL + "/inven/usepdtid", {
            method: "POST",
            body: JSON.stringify({comp_id:compId}),
            credentials: "include"
        }).then((data) => {
            if(data.ok){
                data.json().then((dataJson: invenUse[]) => {
                    setItems(dataJson);
                })
            }
        })
    }, [])


    return (
        <Modal
            isOpen={isOpen}
            onRequestClose={onRequestClose}
            contentLabel="New User Modal"
            className="modal"
            overlayClassName="overlay"
        >
            <h2>Inventory Details</h2>
            <div className="item-title">{desc}</div>
            <div className="item-table">
                <table>
                    <thead>
                        <tr>
                            <th>Sl No.</th>
                            <th>Complain Number</th>
                            <th>Complain Location</th>
                            <th>Quantity Used</th>
                            <th>Used By</th>
                        </tr>
                    </thead>
                    <tbody>
                        {items.map((ele, idx) => (
                            <tr key={idx}>
                                <td>{idx + 1}</td>
                                <td>{ele.comp_nos}</td>
                                <td>{ele.comp_loc}</td>
                                <td>{ele.qty_used}</td>
                                <td>{ele.usedBy}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </Modal>
    )
}

export default InvUseDesc