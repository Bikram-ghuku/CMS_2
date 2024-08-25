import React from 'react';
import { Line } from 'react-chartjs-2';
import { Chart as ChartJS, CategoryScale, LinearScale, LineElement, PointElement, Title, Tooltip, Legend } from 'chart.js';

ChartJS.register(CategoryScale, LinearScale, LineElement, PointElement, Title, Tooltip, Legend);

interface ComplaintData {
  comp_data: string;
  comp_count: number;
}

const ChartComponent: React.FC<{data: ComplaintData[]}> = ({data}) => {
    const labels = data.map(item => new Date(item.comp_data).toLocaleDateString());
    const counts = data.map(item => item.comp_count);

    const chartData = {
        labels,
        datasets: [
            {
                label: 'Complaints Count',
                data: counts,
                borderColor: 'rgba(75,192,192,1)',
                backgroundColor: 'rgba(75,192,192,0.2)',
                fill: true,
            },
        ],
    };

    const options = {
        responsive: true,
        plugins: {
            legend: {
                position: 'top' as const,
            },
            tooltip: {
                callbacks: {
                    label: function(tooltipItem: any) {
                        return `Complaints Count: ${tooltipItem.raw}`;
                    },
                },
            },
        },
        scales: {
            x: {
                title: {
                    display: true,
                    text: 'Date',
                },
            },
            y: {
                title: {
                    display: true,
                    text: 'Number of Complaints',
                },
                beginAtZero: true,
            },
        },
    };

    return (
        <div className="chart-container" style={{width: "100%", height:"70%"}}>
            <h3 style={{ textAlign: "center" }}>Complaints Over Time</h3>
            <Line data={chartData} options={options} />
        </div>
    );
};

export default ChartComponent;
