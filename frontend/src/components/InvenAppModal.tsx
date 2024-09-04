import { useState, useEffect } from "react";
import Modal from 'react-modal';
import { BACKEND_URL } from '../constants';
import { toast } from 'react-toastify';
import "../styles/InvenAppModal.scss";
import Select from 'react-select';

interface InvenAppProp {
    isOpen: boolean;
    onRequestClose: () => void;
    compId: string;
}

type Item = {
    item_name: string;
    item_desc: string;
    item_qty: number;
    item_price: number;
    item_id: string;
    item_nos: number;
};

type InvenUsed = {
    id: string;
    item_used: number;
    user_id: string;
    username: string;
    role: string;
    item_id: string;
    item_name: string;
    item_qty: number;
    item_price: number;
    item_desc: string;
    item_unit: string;
    item_l: number;
    item_b: number;
    item_h: number;
    comp_id: string;
    comp_nos: string;
    comp_loc: string;
    comp_des: string;
    comp_stat: string;
    comp_date: string;
    bill_no: string;
    upto_use: number;
    upto_amt: number;
    serial_no: number;
};

const emptyItem: Item = { item_name: "", item_desc: "", item_price: 0, item_qty: 0, item_id: "", item_nos: 0 };

const emptyInven:InvenUsed = {
    id: "", item_used:0, user_id:"", username:"", role:"", 
    item_id:"", item_name:"", item_qty: 0, item_price: 0, item_desc: "", item_unit:"", 
    item_l: 0, item_b: 0, item_h: 0, bill_no:"",
    comp_id:"", comp_nos:"", comp_loc:"", comp_des:"", comp_stat:"", comp_date:"",
    upto_use: 0, upto_amt: 0, serial_no: 0
};

type selOption = {
    value: string;
    label: string;
}
const InvenAppModal = ({ isOpen, onRequestClose, compId }: InvenAppProp) => {
    const [quant, setQuant] = useState<number>(0);
    const [l, setL] = useState<number>(0);
    const [b, setB] = useState<number>(0);
    const [h, setH] = useState<number>(0);
    const [invenItems, setInvenItem] = useState<Item[]>([]);
    const [itemSel, setItemSel] = useState<Item>(emptyItem);
    const [viewItems, setViewItems] = useState<InvenUsed[]>([]);
    const [selectedItemsId, setSelectedItemsId] = useState<string>("");
    const [selectedItem, setSelectedItem] = useState<InvenUsed>(emptyInven);
    const [isUpdtVisible, setUpdtVisible] = useState<boolean>(false);
    const [selValue, setSelValue] = useState<selOption>({value: "-1", label: "Select Item"});


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

    const fetchCompUse = () => {
        fetch(BACKEND_URL + '/inven/usecomp', {
            method: "POST",
            credentials: "include",
            body: JSON.stringify({ comp_id: compId })
        }).then((data) => {
            if (data.ok) {
                data.json().then((dataJson: InvenUsed[]) => {
                    if (dataJson != null) setViewItems(dataJson);
                })
            }
        }).catch()
    }

    useEffect(() => {
        fetchInvenItems();
        fetchCompUse();
    }, [compId]);

    useEffect(() => {
        let x: number = 0;
        if (l != 0 || b != 0 || h != 0) x = 1;
        if (l != 0) x *= l;
        if (b != 0) x *= b;
        if (h != 0) x *= h;
        setQuant(x)
    }, [l, b, h]);

    const handleAddInven = (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
        event.preventDefault();
        fetch(BACKEND_URL + "/inven/use", {
            method: "POST",
            credentials: "include",
            body: JSON.stringify({ comp_id: compId, item_id: itemSel.item_id, item_qty: quant, item_l: l, item_b: b, item_h: h }),
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

    const handleSelectChange = (selectedOption: any) => {
        setSelValue({value: selectedOption.value, label: selectedOption.label})
        const foundItem = invenItems.find(item => item.item_id === selectedOption.value);
        setItemSel(foundItem!);
    };

    const selectOptions = invenItems.map((item) => ({
        value: item.item_id,
        label: item.item_nos + ') ' + item.item_desc,
    }));

    const handleQuantChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        setQuant(parseFloat(e.target.value));
        setL(0);
        setB(0);
        setH(0);
    }

    const handleCheckboxChange = (item: InvenUsed) => {
        setSelectedItemsId((str) => {
            return str == "" ? item.id : "";
        });

        setSelectedItem(item);
    };

    const updtItemUsed = (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
        event.preventDefault()
        fetch(BACKEND_URL+"/inven/updtuse", {
            method:"POST",
            credentials:'include',
            body: JSON.stringify({item_qty_diff: quant - selectedItem.item_used, id: selectedItem.id, item_id: selectedItem.item_id, item_l_diff: l - selectedItem.item_l, item_b_diff: b - selectedItem.item_b, item_h_diff: h - selectedItem.item_h})
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

    const delItemUsed = (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
        event.preventDefault()
        fetch(BACKEND_URL+"/inven/deluse",{
            method: "POST",
            credentials:'include',
            body: JSON.stringify({id: selectedItem.id})
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
        setUpdtVisible(selectedItemsId.length != 0);
        if(selectedItemsId.length != 0){
            setQuant(selectedItem.item_used);
            setL(selectedItem.item_l);
            setB(selectedItem.item_b);
            setH(selectedItem.item_h);
            setSelValue({
                value: selectedItem.item_id,
                label: selectedItem.serial_no + ') ' + selectedItem.item_desc,
            });
        }else{
            setQuant(0);
            setL(0);
            setB(0);
            setH(0);
            setSelValue({value: "-1", label: "Select Item"});
        }
    }, [selectedItemsId])

    return (
        <Modal
            isOpen={isOpen}
            onRequestClose={onRequestClose}
            contentLabel="Add Inventory Modal"
            className="modal"
            overlayClassName="overlay"
        >
            <h2 className="modal-title">Inventory Used</h2>
            <div className="modal-content">
                <div className="user-table-container">
                    <table className="user-table">
                        <thead>
                            <tr>
                                <th>Select</th>
                                <th>BOQ no</th>
                                <th>Qty</th>
                                <th>Length</th>
                                <th>Breadth</th>
                                <th>Height</th>
                            </tr>
                        </thead>
                        <tbody>
                            {viewItems.map((item) => (
                                <tr key={item.serial_no}>
                                    <td>
                                        <input
                                            type="checkbox"
                                            checked={selectedItemsId === item.id}
                                            onChange={() => handleCheckboxChange(item)}
                                        />
                                    </td>
                                    <td>{item.serial_no}</td>
                                    <td>{item.item_used}</td>
                                    <td>{item.item_l}</td>
                                    <td>{item.item_b}</td>
                                    <td>{item.item_h}</td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
                <form className="modal-form">
                    <div className="item-add">
                        <div className="item-add-item item-1">
                            <label>Select Inventory item</label>
                            <Select
                                className='item-add-sel'
                                options={selectOptions}
                                onChange={handleSelectChange}
                                placeholder="Select Item"
                                value={selValue}
                            />
                        </div>
                        <div className="item-add-item item-2">
                            <label>Quantity</label>
                            <input
                                type="number"
                                placeholder="Enter quantity"
                                onChange={handleQuantChange}
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
                    <button onClick={handleAddInven} className="btn-updt" hidden={isUpdtVisible}>Add Inventory Item</button>
                    <button className="btn-updt" hidden={!isUpdtVisible} onClick={updtItemUsed}>Update Inventory Usage</button>
                    <button className="btn-updt" hidden={!isUpdtVisible} onClick={delItemUsed}>Delete Inventory Usage</button>
                </form>
            </div>
        </Modal>
    )
}

export default InvenAppModal;
