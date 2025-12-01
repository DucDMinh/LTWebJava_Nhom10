<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <title>Sign In</title>
                <meta charset="utf-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>

                <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>

                <style>
                    /* CSS tạo hiệu ứng góc tam giác cho nút chuyển đổi QR */
                    .qr-toggle-corner {
                        position: absolute;
                        top: 0;
                        right: 0;
                        cursor: pointer;
                        width: 60px;
                        height: 60px;
                        z-index: 10;
                    }

                    /* Hình tam giác góc */
                    .qr-toggle-bg {
                        width: 0;
                        height: 0;
                        border-style: solid;
                        border-width: 0 60px 60px 0;
                        border-color: transparent #0d6efd transparent transparent;
                        /* Màu xanh bootstrap */
                        position: absolute;
                        top: 0;
                        right: 0;
                    }

                    /* Icon QR nằm đè lên tam giác */
                    .qr-icon {
                        position: absolute;
                        top: 5px;
                        right: 5px;
                        width: 30px;
                        height: 30px;
                        color: white;
                        /* Dùng icon ảnh hoặc SVG */
                        background-image: url("https://img.icons8.com/ios-filled/50/ffffff/qr-code-scan.png");
                        background-size: cover;
                    }

                    /* Tooltip khi di chuột */
                    .qr-toggle-corner:hover .qr-toggle-bg {
                        border-color: transparent #0b5ed7 transparent transparent;
                        /* Màu đậm hơn khi hover */
                    }
                </style>
            </head>

            <body>
                <div class="signin border position-relative" style="overflow: hidden;">

                    <div id="btn-switch-qr" class="qr-toggle-corner" title="Đăng nhập bằng mã QR">
                        <div class="qr-toggle-bg"></div>
                        <div class="qr-icon"></div>
                    </div>

                    <div class="signin__title fs-4 fw-bold text-center">Đăng nhập</div>

                    <div class="signin__content">

                        <div id="login-form-container">
                            <form action="/home/signin" method="post">
                                <div class="it1 signin__content--item border d-flex align-items-center gap-4">
                                    <div class="signin__content--left"></div>
                                    <div class="item__icon">
                                        <img src="${env}/client/img/sign_in/email.png" alt="logo">
                                    </div>
                                    <div class="gach border-start "></div>
                                    <div class="input">
                                        <input type="text" name="username" placeholder="Nhập tên đăng nhập hoặc Email"
                                            class="input__email">
                                    </div>
                                </div>
                                <div class="it2 signin__content--item border d-flex align-items-center gap-4">
                                    <div class="signin__content--left"></div>
                                    <div class="item__icon">
                                        <img src="${env}/client/img/sign_in/key.png" alt="logo">
                                    </div>
                                    <div class="gach border-start "></div>
                                    <div class="input">
                                        <input type="password" name="password" placeholder="Nhập mật khẩu"
                                            class="input__email">
                                    </div>
                                    <div>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </div>
                                </div>

                                <div class="remember-forgot d-flex justify-content-between align-items-center ">
                                    <div class="remember">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="remember-me"
                                                id="flexCheckChecked">
                                            <label class="form-check-label " for="flexCheckChecked">Ghi nhớ đăng
                                                nhập</label>
                                        </div>
                                    </div>
                                    <div class="forgot">
                                        <a href="" class="text-dark">Quên mật khẩu?</a>
                                    </div>
                                </div>

                                <div class="signup">
                                    <span>Chưa có tài khoản?</span>
                                    <a href="/home/signup" style="color: blue;">Đăng ký ngay!</a>
                                </div>

                                <button type="submit"
                                    class="btn btn-primary but d-flex justify-content-center align-items-center gap-2 m-auto">
                                    <img src="${env}/client/img/sign_in/login.png" alt="logo">
                                    <span>Đăng nhập</span>
                                </button>
                            </form>

                            <div class="mt-2">
                                <div style="text-align: center"><span>Hoặc sử dụng</span></div>
                                <div class="d-flex justify-content-center align-items-center my-3" style="gap: 20px">
                                    <a href="/oauth2/authorization/google">
                                        <img height="40" width="40"
                                            src="${env}/client/img/provider/default-google.png" />
                                    </a>
                                    <a href="/oauth2/authorization/github">
                                        <img height="40" width="40"
                                            src="${env}/client/img/provider/default-github.png" />
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div id="qr-login-container" class="d-none text-center py-4">
                            <h5 class="fw-bold mb-3 text-primary">Quét mã QR bằng Mobile</h5>

                            <div class="d-flex justify-content-center mb-3">
                                <div id="qrcode" class="border p-2 bg-white rounded"></div>
                            </div>

                            <p id="qr-status" class="text-muted fst-italic mb-4">Đang kết nối tới máy chủ...</p>

                            <button id="btn-back-login"
                                class="btn btn-outline-secondary d-flex align-items-center gap-2 m-auto">
                                <i class="fa fa-arrow-left"></i>
                                <span>Quay lại đăng nhập mật khẩu</span>
                            </button>
                        </div>
                    </div>
                </div>

                <jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>

                <script>
                    $(document).ready(function () {
                        let qrId = "";
                        let checkInterval = null; // Biến lưu vòng lặp kiểm tra

                        // 1. SỰ KIỆN: Bấm vào icon góc để chuyển sang QR Mode
                        $("#btn-switch-qr").click(function () {
                            // Ẩn form thường, hiện form QR, ẩn nút góc
                            $("#login-form-container").addClass("d-none");
                            $("#qr-login-container").removeClass("d-none");
                            $(this).addClass("d-none");

                            // GỌI API TẠO MÃ NGAY LÚC NÀY
                            generateQRCode();
                        });

                        // 2. SỰ KIỆN: Bấm nút "Quay lại"
                        $("#btn-back-login").click(function () {
                            // Hiện form thường, ẩn form QR, hiện nút góc
                            $("#login-form-container").removeClass("d-none");
                            $("#qr-login-container").addClass("d-none");
                            $("#btn-switch-qr").removeClass("d-none");

                            // DỪNG vòng lặp kiểm tra để đỡ tốn tài nguyên server
                            stopPolling();
                        });

                        // Hàm sinh mã QR
                        function generateQRCode() {
                            $("#qrcode").empty(); // Xóa mã cũ
                            $("#qr-status").text("Đang tạo mã QR...");
                            $("#qr-status").removeClass("text-danger text-success");

                            $.get("/api/qr/generate", function (data) {
                                qrId = data.qrId;

                                // Tạo link quét (Domain hiện tại + API accept)
                                const currentDomain = window.location.origin;
                                const scanUrl = currentDomain + "/user/qr/accept?qrId=" + qrId;

                                // Vẽ QR
                                new QRCode(document.getElementById("qrcode"), {
                                    text: scanUrl,
                                    width: 300,
                                    height: 300,
                                    colorDark: "#000000",
                                    colorLight: "#ffffff",
                                    correctLevel: QRCode.CorrectLevel.H
                                });

                                $("#qr-status").text("Mở App Mobile và quét mã này");

                                // Bắt đầu vòng lặp kiểm tra
                                startPolling();

                            }).fail(function () {
                                $("#qr-status").text("Lỗi kết nối Server! Vui lòng thử lại.");
                                $("#qr-status").addClass("text-danger");
                            });
                        }

                        // Hàm bắt đầu vòng lặp hỏi server
                        function startPolling() {
                            // Xóa interval cũ nếu có
                            if (checkInterval) clearInterval(checkInterval);

                            checkInterval = setInterval(function () {
                                if (!qrId) return;

                                $.get("/api/qr/check/" + qrId, function (res) {
                                    if (res.status === "SUCCESS") {
                                        $("#qr-status").text("Đăng nhập thành công! Đang chuyển hướng...");
                                        $("#qr-status").addClass("text-success fw-bold");

                                        stopPolling(); // Dừng hỏi

                                        // Chuyển hướng theo role (Backend trả về redirectUrl)
                                        setTimeout(function () {
                                            window.location.href = res.redirectUrl || "/home";
                                        }, 1000);
                                    }
                                });
                            }, 2000); // 2 giây hỏi 1 lần
                        }

                        // Hàm dừng vòng lặp
                        function stopPolling() {
                            if (checkInterval) {
                                clearInterval(checkInterval);
                                checkInterval = null;
                            }
                        }
                    });
                </script>
            </body>

            </html>