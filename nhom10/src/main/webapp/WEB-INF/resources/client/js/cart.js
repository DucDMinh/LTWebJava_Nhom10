/**
 * CART QUANTITY LOGIC
 * File này chỉ xử lý việc tăng giảm số lượng sản phẩm trong giỏ hàng
 * và cập nhật giá tiền tương ứng.
 */

(function ($) {
    "use strict";

    // Hàm định dạng tiền tệ Việt Nam (Ví dụ: 1200000 => 1.200.000 ₫)
    function formatCurrency(value) {
        return new Intl.NumberFormat('vi-VN').format(value) + " ₫";
    }

    // Hàm tính tổng tiền cả giỏ hàng (Subtotal & Total)
    function updateCartTotal() {
        var total = 0;

        // Duyệt qua tất cả các ô input số lượng đang có trên bảng
        $('.quantity input').each(function () {
            var qty = parseFloat($(this).val()) || 0;
            // Lấy giá đơn vị từ thuộc tính data
            var price = parseFloat($(this).attr("data-cart-detail-price")) || 0;
            total += (qty * price);
        });

        // Cập nhật text hiển thị tổng tiền
        var formattedTotal = formatCurrency(total);
        $("#cart-subtotal").text(formattedTotal);
        $("#cart-total").text(formattedTotal);
    }

    // Hàm chính: Xử lý sự kiện click
    function initCartButtons() {
        // Gán sự kiện click cho các nút bên trong div .quantity
        // Dùng .off() để đảm bảo không bị gán trùng lặp nếu gọi hàm nhiều lần
        $('.quantity button').off('click').on('click', function (e) {
            e.preventDefault(); // Chặn hành vi submit mặc định của button

            var button = $(this);
            // Tìm ô input hiển thị nằm cùng nhóm với nút bấm
            var inputVisible = button.closest('.quantity').find('input');

            // Lấy giá trị hiện tại
            var oldValue = parseFloat(inputVisible.val()) || 0;
            var newVal = oldValue;

            // --- 1. XÁC ĐỊNH TĂNG HAY GIẢM ---
            // Kiểm tra class 'btn-plus' hoặc icon 'fa-plus'
            if (button.hasClass('btn-plus') || button.find('.fa-plus').length > 0) {
                newVal = oldValue + 1;
            } else {
                // Nếu là nút giảm
                if (oldValue > 1) {
                    newVal = oldValue - 1;
                } else {
                    newVal = 1; // Không cho giảm dưới 1
                }
            }

            // --- 2. CẬP NHẬT GIAO DIỆN ---
            // Cập nhật số mới vào ô input hiển thị
            inputVisible.val(newVal);

            // --- 3. ĐỒNG BỘ DỮ LIỆU ĐỂ GỬI VỀ SERVER ---
            // Lấy index từ thuộc tính data (ví dụ: 0, 1, 2...)
            var index = inputVisible.attr("data-cart-detail-index");

            // Tìm input ẩn tương ứng (id="hidden-qty-0", "hidden-qty-1"...) và cập nhật
            if (index !== undefined) {
                $('#hidden-qty-' + index).val(newVal);
            }

            // --- 4. TÍNH TOÁN LẠI GIÁ TIỀN ---
            var price = parseFloat(inputVisible.attr("data-cart-detail-price")) || 0;
            var id = inputVisible.attr("data-cart-detail-id");

            // Tính thành tiền của dòng sản phẩm này
            var newRowTotal = price * newVal;

            // Tìm thẻ hiển thị tiền của dòng (dựa vào data-total-price-id) và cập nhật
            $('p[data-total-price-id="' + id + '"]').text(formatCurrency(newRowTotal));

            // Tính lại tổng tiền cả giỏ hàng
            updateCartTotal();
        });
    }

    // Tự động chạy khi trang web tải xong
    $(document).ready(function () {
        initCartButtons();
    });

})(jQuery);