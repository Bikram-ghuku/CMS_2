import React, { useEffect, useState } from 'react';
import '../styles/InvoiceComp.scss';
import { BACKEND_URL } from '../constants';


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
    comp_id: string;
    comp_nos: string;
    comp_loc: string;
    comp_des: string;
    comp_stat: string;
    comp_date: string;
};

type InvoiceProps = {
    CompId: string,
    compDesc: string
};

const InvoiceCompTable = React.forwardRef<HTMLTableElement, InvoiceProps>(({ CompId, compDesc}, ref) => {

    const [selectedItems, setSelectedItems] = useState<InvenUsed[]>([])
    useEffect(() => {
        if(CompId == "") return;
        fetch(BACKEND_URL+'/inven/usecomp', {
            method:"POST",
            credentials:"include",
            body: JSON.stringify({comp_id:CompId})
        }).then((data) => {
            if(data.ok){
                data.json().then((datajson:InvenUsed[]) => {
                    if(datajson != null) setSelectedItems(datajson);
                })
            }
        })
    }, [CompId])

    const calculateTotal = () => {
        return selectedItems.reduce((acc, item) => acc + item.item_used * item.item_price, 0);
    };


    return (
        <div className="invoice-main">
            <table className='invoice-table' ref={ref}>
                <thead>
                    <tr className="invoice-header">
                        <th colSpan={12}>
                            Institute Works <br/> Sanitary Section <br/> IIT Kharagpur
                        </th>
                    </tr>
                    <tr className="invoice-work-name">
                        <th colSpan={12}>
                            Name of work: {compDesc}
                        </th>
                    </tr>
                    <tr>
                        <th>Sl. No</th>
                        <th>Description of Item</th>
                        <th>Unit</th>
                        <th>Quantity</th>
                        <th>Rate</th>
                        <th>Amount (Rs.)</th>
                        <th>Upto Previous quantity</th>
                        <th>In this Bill quantity</th>
                        <th>Total upto date</th>
                        <th>Upto previous amount</th>
                        <th>In this Bill amount</th>
                        <th>Total upto date</th>
                    </tr>
                </thead>
                <tbody>
                    {selectedItems.map((item, idx) => (
                        <tr key={idx}>
                            <td>{idx + 1}</td>
                            <td style={{textAlign: "left"}}>{item.item_desc}</td>
                            <td>{item.item_unit}</td>
                            <td>{item.item_used}</td>
                            <td>{`₹${item.item_price.toFixed(2)}`}</td>
                            <td>{`₹${(item.item_used * item.item_price).toFixed(2)}`}</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    ))}
                    <tr key="end">
                        <td style={{borderRight: "none", fontWeight: "800"}}></td>
                        <td style={{borderLeft: "none", borderRight: "none"}}>Total Rs.:</td>
                        <td style={{borderLeft: "none", borderRight: "none"}}></td>
                        <td style={{borderLeft: "none", borderRight: "none"}}></td>
                        <td  style={{borderLeft: "none", borderRight: "none"}}></td>
                        <td>{`₹${calculateTotal().toFixed(2)}`}</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
    );
});

export default InvoiceCompTable;
