<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>403 - Access Denied</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        }
        .error-card {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            padding: 40px;
            text-align: center;
            max-width: 500px;
            animation: fadeIn 0.8s ease-in-out;
        }
        .error-icon {
            font-size: 80px;
            color: #dc3545;
            margin-bottom: 20px;
        }
        h1 {
            font-weight: 700;
            margin-bottom: 15px;
        }
        p {
            color: #6c757d;
            margin-bottom: 25px;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body>
<div class="error-card">
    <div class="error-icon">
        <i class="fas fa-ban"></i>
    </div>
    <h1 class="text-danger">Không đủ quyền hạn</h1>
    <p>Xin lỗi, bạn không có quyền truy cập vào trang này.<br>Vui lòng liên hệ quản trị viên nếu bạn nghĩ đây là lỗi.</p>
    <a href="/admin" class="btn btn-dark" style="text-decoration: none">
        <i class="fas fa-home"></i> Về trang chủ
    </a>
</div>
</body>
</html>
