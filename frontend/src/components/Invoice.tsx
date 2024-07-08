import React from 'react';
import "../styles/Invoice.scss";
import logo from '../assets/logo.png'
import { sampleData } from '../pages/InvoicePage';

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
    comp_id: string;
    comp_nos: string;
    comp_loc: string;
    comp_des: string;
    comp_stat: string;
    comp_date: string;
};

type InvoiceProps = {
    selectedItems: InvenUsed[];
};


const Invoice = React.forwardRef<HTMLDivElement, InvoiceProps>(({ selectedItems }, ref) => {
    const calculateTotal = () => {
        return selectedItems.reduce((acc, item) => acc + item.item_used * item.item_price, 0);
    };

    return (
        <div ref={ref} className='invoice-main'>
            <div className="invoice-header">
                <img src={logo} alt="Logo" className="invoice-logo" />
                <h1>Sanitary Section, IIT Kharagpur</h1>
            </div>
            <h2>Invoice</h2>
            <table>
                <thead>
                    <tr>
                        <th>Item Name</th>
                        <th>Item Description</th>
                        <th>Quantity Used</th>
                        <th>Complaint Number</th>
                        <th>Price per Item</th>
                        <th>Total Price</th>
                    </tr>
                </thead>
                <tbody>
                    {sampleData.map((item, idx) => (
                        <tr key={idx}>
                            <td>{item.item_name}</td>
                            <td>{item.item_desc}</td>
                            <td>{item.item_used}</td>
                            <td>{item.comp_loc}</td>
                            <td>{'₹' + item.item_price}</td>
                            <td>{'₹' + item.item_used * item.item_price}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
            <h3>Total: {'₹' + calculateTotal()}</h3>
        </div>
    );
});

export default Invoice;
