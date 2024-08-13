import React, { useState, useEffect } from 'react';
import Modal from 'react-modal';
import Select from 'react-select';
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

type Item = {
    item_name: string;
    item_desc: string;
    item_qty: number;
    item_price: number;
    item_id: string;
    item_nos: number;
};

interface InventoryDetailsModalProps {
    isOpen: boolean;
    onRequestClose: () => void;
    comp: Complaint;
}

const emptyItem: Item = { item_name: "", item_desc: "", item_price: 0, item_qty: 0, item_id: "", item_nos: 0 };

const CompDetailsModal: React.FC<InventoryDetailsModalProps> = ({
    isOpen,
    onRequestClose,
    comp,
}) => {
    const [newCompNos, setNewCompNo] = useState<string>('');
    const [newLoc, setNewLoc] = useState<string>('');
    const [newDesc, setNewDesc] = useState<string>('');
    const [invenItems, setInvenItem] = useState<Item[]>([]);
    const [itemSel, setItemSel] = useState<Item>(emptyItem);
    const [quant, setQuant] = useState<number>(0);
    const [l, setL] = useState<number>(0);
    const [b, setB] = useState<number>(0);
    const [h, setH] = useState<number>(0);

    useEffect(() => {
        fetchInvenItems();
        if (comp) {
            setNewCompNo(comp.comp_nos);
            setNewLoc(comp.comp_loc);
            setNewDesc(comp.comp_des);
        }
    }, [comp]);

    const fetchInvenItems = () => {
        fetch(BACKEND_URL + '/inven/all', {
            method: "GET",
            credentials: "include",
        }).then((data) => {
            if (data.ok) {
                data.json().then((dataJson: Item[]) => {
                    setInvenItem(dataJson);
                });
            }
        });
    };

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
        event.preventDefault();
        fetch(BACKEND_URL + "/inven/use", {
            method: "POST",
            credentials: "include",
            body: JSON.stringify({ comp_id: comp.comp_id, item_id: itemSel.item_id, item_qty: quant, item_l: l, item_b: b, item_h: h }),
        }).then((data) => {
            if (data.ok) {
                toast.success("Inventory added to Complaint", {
                    position: "bottom-center",
                });
            } else {
                toast.error("Error adding Inventory to complaint", {
                    position: "bottom-center",
                });
            }
        });
    };
    
    useEffect(() => {
        var x:number = 0;
        if(l != 0 || b != 0 || h != 0) x = 1;
        if(l != 0) x*=l;
        if(b != 0) x*=b;
        if(h != 0) x*=h;
        setQuant(x)
    }, [l, b, h])

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

    const handleSelectChange = (selectedOption: any) => {
        const foundItem = invenItems.find(item => item.item_id === selectedOption.value);
        setItemSel(foundItem!);
    };

    const selectOptions = invenItems.map((item) => ({
        value: item.item_id,
        label: item.item_nos + ') ' + item.item_desc,
    }));

    const HandleQuantChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        setQuant(parseFloat(e.target.value));
        setL(0);
        setB(0);
        setH(0);
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
                    <div className="item-add">
                        <div className="item-add-item item-1">
                            <label>Select Inventory item</label>
                            <Select
                                className='item-add-sel'
                                options={selectOptions}
                                onChange={handleSelectChange}
                                placeholder="Select Item"
                            />
                        </div>
                        <div className="item-add-item item-2">
                            <label>Quantity</label>
                            <input
                                type="number"
                                placeholder="Enter quantity"
                                onChange={HandleQuantChange}
                                value={quant}
                            />
                        </div>
                    </div>
                    <div className="item-add">
                        <div className="item-add-item">
                            <label>Enter Length</label>
                            <input
                                type="number"
                                placeholder="Enter Length"
                                onChange={(e) => setL(parseFloat(e.target.value))}
                                value={l}
                            />
                        </div>
                        <div className="item-add-item">
                            <label>Enter Breadth</label>
                            <input
                                type="number"
                                placeholder="Enter Breadth"
                                onChange={(e) => setB(parseFloat(e.target.value))}
                                value={b}
                            />
                        </div>
                        <div className="item-add-item">
                            <label>Enter Height</label>
                            <input
                                type="number"
                                placeholder="Enter Height"
                                onChange={(e) => setH(parseFloat(e.target.value))}
                                value={h}
                            />
                        </div>
                    </div>
                    <button onClick={handleAddInven} className="btn-updt">Add Inventory Item</button>
                    <button onClick={handleUpdate} className="btn-add">Update</button>
                </form>
            )}
        </Modal>
    );
};

export default CompDetailsModal;
