import React from 'react';
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
    serial_no: number;
};

type InvoiceProps = {
    selectedItems: InvenUsed[];
};

const MeasureMent = React.forwardRef<HTMLDivElement, InvoiceProps>(({ selectedItems}, ref) => {

    return (
        <div ref={ref} className="invoice-main">
            <div className="invoice-header">
                <div className='invoice-header-title'>Measurement of 2<sup>nd</sup> R/A Bill</div>
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
                        <th style={{maxWidth: '20px'}}>BOQ No.</th>
                        <th style={{maxWidth: '65px'}}>Description of Item</th>
                        <th style={{maxWidth: '15px'}}>Comp No.</th>
                        <th style={{maxWidth: '30px'}}>Comp. Loc.</th>
                        <th style={{maxWidth: '10px'}}>Unit</th>
                        <th style={{maxWidth: '25px'}}>L</th>
                        <th style={{maxWidth: '25px'}}>B</th>
                        <th style={{maxWidth: '25px'}}>H</th>
                        <th style={{maxWidth: 'fit-content'}}>Qty</th>
                    </tr>
                </thead>
                <tbody>
                    {selectedItems.map((item, idx) => (
                        <tr key={idx}>
                            <td>{idx + 1}</td>
                            <td>{item.serial_no}</td>
                            <td style={{textAlign: "left"}}>{item.item_desc}</td>
                            <td>{item.comp_nos}</td>
                            <td style={{wordBreak: 'break-word', whiteSpace:'break-spaces'}}>{item.comp_loc}</td>
                            <td>{item.item_unit}</td>
                            <td>{item.item_l}</td>
                            <td>{item.item_b}</td>
                            <td>{item.item_h}</td>
                            <td>{item.item_used}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
});

export default MeasureMent;
