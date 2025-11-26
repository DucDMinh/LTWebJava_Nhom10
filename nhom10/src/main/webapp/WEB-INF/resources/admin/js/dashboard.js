
let currentChart = null;

/**
 * Hàm khởi tạo và vẽ biểu đồ
 * @param {string} type - Loại biểu đồ ('revenue', 'orders', 'sold')
 * @param {Array} labels - Mảng ngày tháng (Trục X)
 * @param {Array} data - Mảng dữ liệu tương ứng (Trục Y)
 */
function renderChart(type, labels, data) {
    const ctx = document.getElementById("myChart");
    if (!ctx) return;

    if (currentChart) {
        currentChart.destroy();
    }

    let config = {
        type: 'line',
        label: 'Dữ liệu',
        isCurrency: false,
        colors: ['#4e73df']
    };
    if (type === 'revenue') {
        config.type = 'line';
        config.label = 'Doanh Thu';
        config.colors = ['#4e73df'];
        config.isCurrency = true;
        document.getElementById('chartTitle').innerText = "Biểu Đồ Doanh Thu (Thực Tế)";
        document.getElementById('chartTitle').className = "m-0 font-weight-bold text-primary";
    }
    else if (type === 'orders') {
        config.type = 'bar';
        config.label = 'Số Lượng Đơn Hàng';
        config.colors = ['#1cc88a'];
        document.getElementById('chartTitle').innerText = "Thống Kê Số Lượng Đơn Hàng";
        document.getElementById('chartTitle').className = "m-0 font-weight-bold text-success";
    }
    else if (type === 'sold') {
        config.type = 'bar';
        config.label = 'Sản Phẩm Đã Bán';
        config.colors = ['#36b9cc'];
        document.getElementById('chartTitle').innerText = "Thống Kê Số Lượng Sản Phẩm Bán Ra";
        document.getElementById('chartTitle').className = "m-0 font-weight-bold text-info";
    }
    else if (type === 'best_seller') {
        config.type = 'doughnut';
        config.label = 'Số lượng bán';
        config.colors = ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b'];
        document.getElementById('chartTitle').innerText = "Top 5 Sản Phẩm Bán Chạy Nhất";
        document.getElementById('chartTitle').className = "m-0 font-weight-bold text-warning";
    }

    let dataset = {
        label: config.label,
        data: data,
        backgroundColor: config.type === 'doughnut' ? config.colors : config.colors[0],
        borderColor: config.type === 'doughnut' ? '#fff' : config.colors[0],
        borderWidth: 2
    };
    if (config.type !== 'doughnut') {
        dataset.backgroundColor = config.type === 'line' ? config.colors[0] + '10' : config.colors[0];
        dataset.tension = 0.3;
        dataset.fill = true;
    }

    currentChart = new Chart(ctx, {
        type: config.type,
        data: {
            labels: labels,
            datasets: [dataset],
        },
        options: {
            maintainAspectRatio: false,
            layout: { padding: { left: 10, right: 25, top: 25, bottom: 0 } },
            plugins: {
                legend: {
                    display: config.type === 'doughnut',
                    position: 'bottom'
                },
                tooltip: {
                    callbacks: {
                        label: function (context) {
                            let label = context.dataset.label || '';
                            if (config.type === 'doughnut') {
                                label = context.label || '';
                            }

                            if (label) label += ': ';
                            if (context.parsed.y !== null) {
                                if (config.isCurrency) label += new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(context.parsed.y);
                                else label += context.parsed.y;
                            } else if (context.parsed !== null) {
                                label += context.parsed;
                            }
                            return label;
                        }
                    }
                }
            },
            scales: config.type === 'doughnut' ? {} : {
                x: { grid: { display: false, drawBorder: false }, ticks: { maxTicksLimit: 7 } },
                y: {
                    ticks: {
                        maxTicksLimit: 5,
                        padding: 10,
                        callback: function (value) {
                            if (config.isCurrency) return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
                            return value;
                        }
                    },
                    grid: { color: "rgb(234, 236, 244)", borderDash: [2], drawBorder: false }
                }
            }
        }
    });
}

/**
 * @param {string} type - Loại biểu đồ cần chuyển ('revenue', 'orders', 'sold')
 */
function switchChart(type) {
    document.querySelectorAll('.card-clickable').forEach(el => el.classList.remove('card-active'));

    const activeCard = document.getElementById(type === 'best_seller' ? 'card-best-seller' : 'card-' + type);
    if (activeCard) activeCard.classList.add('card-active');

    let dataLabels = labels;
    let dataToShow = [];

    if (type === 'revenue') dataToShow = dataRevenue;
    else if (type === 'orders') dataToShow = dataOrders;
    else if (type === 'sold') dataToShow = dataSold;
    else if (type === 'best_seller') {
        dataLabels = labelsBestSeller;
        dataToShow = dataBestSeller;
    }

    renderChart(type, dataLabels, dataToShow);
}