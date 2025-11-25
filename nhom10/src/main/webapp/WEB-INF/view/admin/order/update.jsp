<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật đơn hàng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .update-container {
            max-width: 700px;
            margin: 50px auto;
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,.1);
        }
        .form-label {
            font-weight: 600;
        }
        .btn-custom {
            border-radius: 25px;
            padding: 10px 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="update-container">
        <h3 class="text-center mb-4">Cập nhật đơn hàng</h3>
        <form:form action="/admin/orders/update" method="post" modelAttribute="updateOrder">

            <!-- Order ID (readonly) -->
            <div class="mb-3">
                <label class="form-label">Mã đơn hàng</label>
                <form:input type="text" class="form-control" name="orderId" path="id" readonly="true" />
            </div>

            <!-- Customer Name -->
            <div class="mb-3">
                <label class="form-label">Khách hàng</label>
                <input type="text" class="form-control" value="${updateOrder.address.reciverName}" readonly>
            </div>

            <!-- Address -->
            <div class="mb-3">
                <label class="form-label">Địa chỉ giao hàng</label>
                <input type="text" class="form-control" value="${updateOrder.address.detailDesc}" readonly>
            </div>

            <!-- Total Price -->
            <div class="mb-3">
                <label class="form-label">Tổng tiền</label>
                <input type="text" class="form-control" value="${updateOrder.totalPrice}" readonly>
            </div>

            <!-- Order Status -->
            <div class="mb-3">
                <label class="form-label">Trạng thái</label>
                <form:select path="status" class="form-select">
                    <form:option value="PENDING">Chờ xử lý</form:option>
                    <form:option value="CONFIRMED">Đã xác nhận</form:option>
                    <form:option value="SHIPPING">Đang giao</form:option>
                    <form:option value="COMPLETED">Hoàn tất</form:option>
                    <form:option value="CANCELLED">Đã hủy</form:option>
                </form:select>
            </div>

            <!-- Buttons -->
            <div class="text-center">
                <button type="submit" class="btn btn-primary btn-custom">Cập nhật</button>
                <a href="/admin/orders" class="btn btn-secondary btn-custom">Quay lại</a>
            </div>
        </form:form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
