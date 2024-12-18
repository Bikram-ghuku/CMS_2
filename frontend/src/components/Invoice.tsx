import React, { useEffect, useState } from 'react';
import '../styles/Invoice.scss';


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

type item = {
    item_name:string,
    item_desc:string,
    item_qty:number,
    item_price:number,
    item_id:string,
    item_unit:string
};

type InvoiceProps = {
    selectedItems: InvenUsed[];
    allItems: item[];
};

const empty:InvenUsed = {
    id: "", item_used:0, user_id:"", username:"", role:"", 
    item_id:"", item_name:"", item_qty: 0, item_price: 0, item_desc: "", item_unit:"", 
    item_l: 0, item_b: 0, item_h: 0, bill_no:"",
    comp_id:"", comp_nos:"", comp_loc:"", comp_des:"", comp_stat:"", comp_date:"",
    upto_use: 0, upto_amt: 0
};



const Invoice = React.forwardRef<HTMLDivElement, InvoiceProps>(({ selectedItems, allItems }, ref) => {
    const [data, setData] = useState<InvenUsed[]>([]);

    useEffect(() => {
        const d:InvenUsed[] = [];
        for(let i = 0; i < allItems.length; i++){
            //console.log(i);
            var item_id = allItems[i].item_id;
            const xd: InvenUsed[] = selectedItems.filter((datx) => datx.item_id == item_id);
            var qty: number, upto_use: number, upto_amt: number;
            qty = 0;
            upto_amt = 0;
            upto_use = 0;
            for(let j = 0; j < xd.length; j++){
                qty += xd[j].item_used;
                upto_amt = xd[j].upto_amt;
                upto_use = xd[j].upto_use;
            }
            const iteme: InvenUsed = {...empty, item_desc: allItems[i].item_desc, item_unit: allItems[i].item_unit, item_price: allItems[i].item_price, item_used: qty, upto_amt, upto_use, item_qty: allItems[i].item_qty};
            d.push(iteme);
        }

        console.log(d)
        setData(d)
    }, [allItems, selectedItems])



    const calculateTotal = () => {
        return selectedItems.reduce((acc, item) => acc + item.item_used * item.item_price, 0);
    };

    return (
        <div ref={ref} className="invoice-main">
            <div className="invoice-header">
                <div className='invoice-header-title'>Abstract of 2<sup>nd</sup> R/A Bill</div>
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
                        <th style={{maxWidth: '50px', minWidth: '50px'}}>Total upto date Qty</th>
                        <th style={{maxWidth: '10px'}}>Rate</th>
                        <th style={{maxWidth: '25px'}}>Total upto date Amount (Rs.)</th>
                    </tr>
                </thead>
                <tbody>
                    {data.map((item, idx) => (
                        <tr key={idx}>
                            <td>{idx + 1}</td>
                            <td style={{textAlign: "left"}}>{item.item_desc}</td>
                            <td>{item.item_unit}</td>
                            <td>{item.upto_use}</td>
                            <td>{`₹${item.item_price.toFixed(2)}`}</td>
                            <td>{`₹${(item.upto_amt).toFixed(2)}`}</td>
                        </tr>
                    ))}
                    <tr key="end">
                        <td style={{borderRight: "none", fontWeight: "800"}}></td>
                        <td style={{borderLeft: "none", borderRight: "none"}}>Total Rs.:</td>
                        <td style={{borderLeft: "none", borderRight: "none"}}></td>
                        <td style={{borderLeft: "none", borderRight: "none"}}></td>
                        <td  style={{borderLeft: "none", borderRight: "none"}}></td>
                        <td>{`₹${calculateTotal().toFixed(2)}`}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    );
});

export default Invoice;
