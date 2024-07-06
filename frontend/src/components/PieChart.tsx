import { useState } from "react";
import { Pie } from "react-chartjs-2";
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js';

ChartJS.register(ArcElement, Tooltip, Legend);
type Cprop = {
    openComp:number, 
    closeComp:number
}
function PieChart({ customProps }: { customProps: Cprop }) {
    const { openComp, closeComp } = customProps;

    const options = {
        responsive: true,
        maintainAspectRatio: false,
    };

    console.log(customProps)

    const [data, _] = useState({
        labels: [
            'Open',
            'Closed',
        ],
        datasets: [{
            label: 'Available Complaints',
            data: [openComp, closeComp],
            backgroundColor: [
                'rgb(255, 99, 132)',
                '#4CAF50',
            ],
            hoverOffset: 4
        }]
    });
    
    return (
        <div className="chart-container" style={{width: "100%", height:"100%"}}>
            <Pie
                data={data}
                options={options}
            />
        </div>
    );
}
export default PieChart;