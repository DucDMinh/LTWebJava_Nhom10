// Biến toàn cục lưu trữ instance của biểu đồ hiện tại
let currentChart = null;

/**
 * Hàm khởi tạo và vẽ biểu đồ
 * @param {string} type - Loại biểu đồ ('revenue', 'orders', 'sold')
 * @param {Array} labels - Mảng ngày tháng (Trục X)
 * @param {Array} data - Mảng dữ liệu tương ứng (Trục Y)
 */
function renderChart(type, labels, data) {
    const ctx = document.getElementById("myChart");

    // Nếu không tìm thấy thẻ canvas thì dừng
    if (!ctx) return;

    // Nếu đã có biểu đồ cũ thì hủy bỏ để vẽ cái mới
    if (currentChart) {
        currentChart.destroy();
    }

    // Cấu hình riêng cho từng loại biểu đồ
    let config = {
        type: 'line', // Mặc định
        label: 'Dữ liệu',
        color: '#4e73df', // Mặc định xanh dương
        bgColor: 'rgba(78, 115, 223, 0.05)',
        isCurrency: false
    };

    if (type === 'revenue') {
        config.type = 'line';
        config.label = 'Doanh Thu';
        config.color = '#4e73df'; // Primary Blue
        config.bgColor = 'rgba(78, 115, 223, 0.05)';
        config.isCurrency = true;

        // Cập nhật tiêu đề Card
        document.getElementById('chartTitle').innerText = "Biểu Đồ Doanh Thu (Thực Tế)";
        document.getElementById('chartTitle').className = "m-0 font-weight-bold text-primary";
    }
    else if (type === 'orders') {
        config.type = 'bar';
        config.label = 'Số Lượng Đơn Hàng';
        config.color = '#1cc88a'; // Success Green
        config.bgColor = '#1cc88a'; // Bar chart cần màu đậm hơn chút
        config.isCurrency = false;

        document.getElementById('chartTitle').innerText = "Thống Kê Số Lượng Đơn Hàng";
        document.getElementById('chartTitle').className = "m-0 font-weight-bold text-success";
    }
    else if (type === 'sold') {
        config.type = 'bar';
        config.label = 'Sản Phẩm Đã Bán';
        config.color = '#36b9cc'; // Info Cyan
        config.bgColor = '#36b9cc';
        config.isCurrency = false;

        document.getElementById('chartTitle').innerText = "Thống Kê Số Lượng Sản Phẩm Bán Ra";
        document.getElementById('chartTitle').className = "m-0 font-weight-bold text-info";
    }

    // Khởi tạo biểu đồ mới
    currentChart = new Chart(ctx, {
        type: config.type,
        data: {
            labels: labels,
            datasets: [{
                label: config.label,
                data: data,
                // Style chung
                backgroundColor: config.type === 'line' ? config.bgColor : config.color, // Line thì mờ, Bar thì đậm
                borderColor: config.color,
                borderWidth: 2,

                // Style cho Line Chart
                tension: 0.3,
                pointRadius: 4,
                pointBackgroundColor: config.color,
                pointBorderColor: "#fff",
                pointHoverRadius: 6,
                fill: true,

                // Style cho Bar Chart
                barPercentage: 0.5, // Độ rộng cột
                borderRadius: 4     // Bo góc cột
            }],
        },
        options: {
            maintainAspectRatio: false,
            layout: {
                padding: { left: 10, right: 25, top: 25, bottom: 0 }
            },
            scales: {
                x: {
                    grid: { display: false, drawBorder: false },
                    ticks: { maxTicksLimit: 7 }
                },
                y: {
                    ticks: {
                        maxTicksLimit: 5,
                        padding: 10,
                        callback: function (value) {
                            if (config.isCurrency) {
                                return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
                            }
                            return value; // Số lượng thì giữ nguyên
                        }
                    },
                    grid: {
                        color: "rgb(234, 236, 244)",
                        zeroLineColor: "rgb(234, 236, 244)",
                        drawBorder: false,
                        borderDash: [2],
                        zeroLineBorderDash: [2]
                    }
                }
            },
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: "rgb(255,255,255)",
                    bodyColor: "#858796",
                    titleMarginBottom: 10,
                    titleColor: '#6e707e',
                    titleFont: { size: 14 },
                    borderColor: '#dddfeb',
                    borderWidth: 1,
                    xPadding: 15,
                    yPadding: 15,
                    displayColors: false,
                    intersect: false,
                    mode: 'index',
                    caretPadding: 10,
                    callbacks: {
                        label: function (context) {
                            let label = context.dataset.label || '';
                            if (label) label += ': ';
                            if (context.parsed.y !== null) {
                                if (config.isCurrency) {
                                    label += new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(context.parsed.y);
                                } else {
                                    label += context.parsed.y;
                                }
                            }
                            return label;
                        }
                    }
                }
            }
        }
    });
}

/**
 * Hàm xử lý sự kiện click vào Card để chuyển biểu đồ
 * @param {string} type - Loại biểu đồ cần chuyển ('revenue', 'orders', 'sold')
 */
function switchChart(type) {
    // 1. Xóa class active cũ
    document.querySelectorAll('.card-clickable').forEach(el => el.classList.remove('card-active'));

    // 2. Thêm class active cho card được click
    const activeCard = document.getElementById('card-' + type);
    if (activeCard) {
        activeCard.classList.add('card-active');
    }

    // 3. Lấy dữ liệu toàn cục (được khai báo ở index.jsp) và vẽ lại
    // Lưu ý: Các biến labels, dataRevenue, dataOrders, dataSold phải được định nghĩa ở index.jsp trước khi file này chạy
    let dataToShow = [];
    if (type === 'revenue') dataToShow = dataRevenue;
    else if (type === 'orders') dataToShow = dataOrders;
    else if (type === 'sold') dataToShow = dataSold;

    renderChart(type, labels, dataToShow);
}