import React from 'react';
import '../styles/Invoice.scss';
import logo from '../assets/logo.png';
import { ToWords } from 'to-words';


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
    selectedItems: InvenUsed[];
};

const Invoice = React.forwardRef<HTMLDivElement, InvoiceProps>(({ selectedItems }, ref) => {
    const calculateTotal = () => {
        return selectedItems.reduce((acc, item) => acc + item.item_used * item.item_price, 0);
    };

    const toWords = new ToWords({
        localeCode: 'en-IN',
        converterOptions: {
            currency: true,
            ignoreDecimal: false,
            ignoreZeroCurrency: false,
            doNotAddOnly: false,
            currencyOptions: {
                name: 'Rupee',
                plural: 'Rupees',
                symbol: '₹',
                fractionalUnit: {
                    name: 'Paisa',
                    plural: 'Paise',
                    symbol: '',
                },
            },
        },
    });

    return (
        <div ref={ref} className="invoice-main">
            <div className="invoice-header">
                <img src={logo} alt="Logo" className="invoice-logo" />
                <h2>Institute Works <br/> Sanitary Section <br/> IIT Kharagpur</h2>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Sl. No</th>
                        <th>Name of Item</th>
                        <th>Description of Item</th>
                        <th>Unit</th>
                        <th>Quantity</th>
                        <th>Rate</th>
                        <th>Amount (Rs.)</th>
                    </tr>
                </thead>
                <tbody>
                    {selectedItems.map((item, idx) => (
                        <tr key={idx}>
                            <td>{idx + 1}</td>
                            <td>{item.item_name}</td>
                            <td>{item.item_desc}</td>
                            <td>{item.item_unit}</td>
                            <td>{item.item_used}</td>
                            <td>{`₹${item.item_price.toFixed(2)}`}</td>
                            <td>{`₹${(item.item_used * item.item_price).toFixed(2)}`}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
            <h3>Total Rs.: {`₹${calculateTotal().toFixed(2)}`}</h3>
            <h5>{toWords.convert(calculateTotal()) + " (Inclusive of all Taxes)"}</h5>
        </div>
    );
});

export default Invoice;
