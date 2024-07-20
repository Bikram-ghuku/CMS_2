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
    upto_use: number;
    upto_amt: number;
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

const InvoiceComp = React.forwardRef<HTMLDivElement, InvoiceProps>(({ CompId, compDesc}, ref) => {

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
        <div ref={ref} className="invoice-main">
            <div className="invoice-header">
                <div>Institute Works <br/> Sanitary Section <br/> IIT Kharagpur</div>
            </div>
            <div className='invoice-work-name'>
                Name of work: {compDesc}
            </div>
            <table className='invoice-table'>
                <thead>
                    <tr>
                        <th style={{maxWidth: '7px'}}>Sl. No</th>
                        <th style={{width:'45px'}}>Description of Item</th>
                        <th style={{maxWidth: '15px'}}>Unit</th>
                        <th style={{maxWidth: '37px'}}>Quantity</th>
                        <th style={{maxWidth: '15px'}}>Rate</th>
                        <th style={{maxWidth: '15px'}}>Amount (Rs.)</th>
                        <th style={{maxWidth: '37px'}}>Upto Previous quantity</th>
                        <th style={{maxWidth: '35px'}}>In this Bill quantity</th>
                        <th style={{maxWidth: '25px'}}>Total upto date</th>
                        <th style={{maxWidth: '37px'}}>Upto previous amount</th>
                        <th style={{maxWidth: '15px'}}>In this Bill amount</th>
                        <th style={{maxWidth: '15px'}}>Total upto date</th>
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
                            <td>{item.upto_use}</td>
                            <td>{item.item_used}</td>
                            <td>{item.upto_use + item.item_used}</td>
                            <td>{`₹${item.upto_amt}`}</td>
                            <td>{`₹${(item.item_used * item.item_price).toFixed(2)}`}</td>
                            <td>{`₹${(item.upto_amt + (item.item_used * item.item_price)).toFixed(2)}`}</td>
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

export default InvoiceComp;
