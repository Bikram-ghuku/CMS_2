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
        plugins: {
            legend: {
                labels: {
                    color: 'rgb(255, 255, 255)'
                }
            }
        }
    };

    const [data, _] = useState({
        labels: [
            'Open Complaints',
            'Closed Complaints',
        ],
        datasets: [{
            label: 'Available Complaints',
            data: [openComp, closeComp],
            backgroundColor: [
                '#0090df',
                '#4CAF50',
            ],
            hoverOffset: 4
        }]
    });
    
    return (
        <div className="chart-container" style={{width: "100%", height:"70%"}}>
            <h3 style={{ textAlign: "center" }}>Complaints</h3>
            <Pie
                data={data}
                options={options}
            />
        </div>
    );
}
export default PieChart;