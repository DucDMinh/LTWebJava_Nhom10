<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .success-container {
            min-height: 100vh;
        }
        .success-card {
            max-width: 600px;
            border-radius: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .success-icon {
            font-size: 64px;
            color: #28a745;
        }
    </style>
</head>
<body>
<div class="container d-flex justify-content-center align-items-center success-container">
    <div class="card text-center p-5 success-card">
        <div class="mb-4">
            <i class="bi bi-check-circle-fill success-icon"></i>
        </div>
        <h2 class="mb-3 text-success">Đặt hàng thành công!</h2>
        <p class="mb-4">Cảm ơn bạn đã mua hàng. Đơn hàng của bạn đang được xử lý và sẽ sớm được giao tới.</p>

        <div class="d-flex justify-content-center gap-3">
            <a href="/client/carts" class="btn btn-outline-dark px-4 py-2">Quay lại giỏ hàng</a>
            <a href="/client/homes" class="btn btn-dark px-4 py-2">Tiếp tục mua sắm</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS + Icons -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</body>
</html>
