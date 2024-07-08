import React from 'react';
import "../styles/Invoice.scss"

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
            <h2>Invoice</h2>
            <table>
                <thead>
                    <tr>
                        <th>Item Name</th>
                        <th>Item Description</th>
                        <th>Quantity Used</th>
                        <th>Price per Item</th>
                        <th>Total Price</th>
                    </tr>
                </thead>
                <tbody>
                    {selectedItems.map((item) => (
                        <tr key={item.id}>
                            <td>{item.item_name}</td>
                            <td>{item.item_desc}</td>
                            <td>{item.item_used}</td>
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