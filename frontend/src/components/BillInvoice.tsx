import React, { useEffect, useState } from 'react';
import '../styles/Invoice.scss';
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
    item_l: number;
    item_b: number;
    item_h: number;
    comp_id: string;
    comp_nos: string;
    comp_loc: string;
    comp_des: string;
    comp_stat: string;
    comp_date: string;
    bill_no:string;
    upto_use: number;
    upto_amt: number;
};

type InvoiceProps = {
    billId :number;
    desc: string;
};

const BillInvoice = React.forwardRef<HTMLDivElement, InvoiceProps>(({ billId, desc }, ref) => {
    const [data, setData] = useState<InvenUsed[]>([]);

    useEffect(() => {
        fetch(BACKEND_URL + "/bill/getItems", {
            method: "POST",
            credentials: "include",
            body: JSON.stringify({
                "bill_no": billId
            })
        }).then((resp) => {
            if(resp.ok){
                resp.json().then((data: InvenUsed[]) => {
                    setData(data);
                })
            }
        })
    }, [billId])



    const calculateTotal = () => {
        return data.reduce((acc, item) => acc + item.item_used * item.item_price, 0);
    };

    return (
        <div ref={ref} className="invoice-main">
            <div className="invoice-header">
                <div className='invoice-header-title'>Abstract of {desc} R/A Bill</div>
                <div className='invoice-header-section'>Name of work - Routine/repir maintenance in connection with sanitary infrastructure at IIT Kharagpur</div>
                <div className='invoice-header-section'>Work order no - IW/SS/WO/Maintenance/2023-24/18</div>
                <div className='invoice-header-section'>Date of Commencement: 09.02.2024</div>
                <div className='invoice-header-section'>Date of Completion: 08.02.2025</div>
                <div className='invoice-header-section'>Date of Measurement: 09.02.2024 to 21.08.2024</div>
            </div>
            <table className='invoice-table'>
                <thead>
                    <tr>
                        <th style={{maxWidth: '10px'}}>Sl. No</th>
                        <th style={{maxWidth: '65px'}}>Description of Item</th>
                        <th style={{maxWidth: '10px'}}>Unit</th>
                        <th style={{maxWidth: '10px'}}>Rate</th>
                        {billId != 1 && <th>Upto Previous</th>}
                        {billId != 1 && <th>In this Bill</th>}
                        <th style={{maxWidth: '25px'}}>Total upto date</th>
                        {billId != 1 && <th>Upto Previous</th>}
                        {billId != 1 && <th>In this Bill</th>}
                        <th style={{maxWidth: '25px'}}>Total upto date</th>
                    </tr>
                </thead>
                <tbody>
                    {data.map((item, idx) => (
                        <tr key={idx}>
                            <td>{idx + 1}</td>
                            <td style={{textAlign: "left"}}>{item.item_desc}</td>
                            <td>{item.item_unit}</td>
                            <td>{`₹${item.item_price.toFixed(2)}`}</td>
                            {billId != 1 && <td>{item.upto_use - item.item_used}</td>}
                            {billId != 1 && <td>{item.item_used}</td>}
                            <td>{item.upto_use}</td>
                            {billId != 1 && <td>{`₹${(item.upto_amt - (item.item_used * item.item_price)).toFixed(2)}`}</td>}
                            {billId != 1 && <td>{`₹${(item.item_used * item.item_price).toFixed(2)}`}</td>}
                            <td>{`₹${(item.upto_amt).toFixed(2)}`}</td>
                        </tr>
                    ))}
                    <tr key="end">
                        <td style={{borderRight: "none", fontWeight: "800"}}></td>
                        <td style={{borderLeft: "none", borderRight: "none"}}>Total Rs.:</td>
                        <td style={{borderLeft: "none", borderRight: "none"}}></td>
                        <td style={{borderLeft: "none", borderRight: "none"}}></td>
                        <td  style={{borderLeft: "none", borderRight: "none"}}></td>
                        {billId != 1 &&(
                            <>
                                <td style={{borderLeft: "none", borderRight: "none"}}></td>
                                <td style={{borderLeft: "none", borderRight: "none"}}></td>
                                <td  style={{borderLeft: "none", borderRight: "none"}}></td>
                            </>
                        )}
                        <td>{`₹${calculateTotal().toFixed(2)}`}</td>
                        {billId != 1 && <td  style={{borderLeft: "none"}}></td>}
                    </tr>
                </tbody>
            </table>
        </div>
    );
});

export default BillInvoice;
