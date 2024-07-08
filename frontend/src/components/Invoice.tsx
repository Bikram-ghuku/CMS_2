import { forwardRef } from 'react';

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

const Invoice = forwardRef<HTMLDivElement, InvoiceProps>(({ selectedItems }, ref) => (
    <div ref={ref}>
        <h1>Invoice</h1>
        <table>
            <thead>
                <tr>
                    <th>Item Name</th>
                    <th>Item Description</th>
                    <th>Quantity Used</th>
                    <th>Item Price</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                {selectedItems.map((item) => (
                    <tr key={item.id}>
                        <td>{item.item_name}</td>
                        <td>{item.item_desc}</td>
                        <td>{item.item_used}</td>
                        <td>{item.item_price}</td>
                        <td>{item.item_used * item.item_price}</td>
                    </tr>
                ))}
            </tbody>
        </table>
        <h2>
            Total: {selectedItems.reduce((total, item) => total + item.item_used * item.item_price, 0)}
        </h2>
    </div>
));

export default Invoice;