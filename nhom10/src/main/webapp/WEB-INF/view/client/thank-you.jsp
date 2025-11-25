<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <title>Cảm ơn | CellWorld</title>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>
        </head>

        <body>

            <jsp:include page="/WEB-INF/view/client/layout/header.jsp"></jsp:include>

            <section style="background: url(/client/img/banner.jpg) center 15%/cover no-repeat; height: 300px;">
                <div aria-label="breadcrumb" class="container"></div>
            </section>

            <section class="py-5" style="min-height: 500px; display: flex; align-items: center;">
                <div class="container text-center">

                    <div class="mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor"
                            class="bi bi-check-circle-fill text-success" viewBox="0 0 16 16">
                            <path
                                d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z" />
                        </svg>
                    </div>

                    <h1 class="fw-bold mb-3" style="font-size: 2.5rem;">Đặt hàng thành công!</h1>

                    <p class="text-muted mb-5 fs-5">
                        Cảm ơn bạn đã mua sắm tại <strong>CellWorld</strong>.<br>
                        Đơn hàng của bạn đang được hệ thống xử lý và sẽ sớm được giao đến bạn.
                    </p>

                    <div class="d-flex justify-content-center">
                        <a href="/home" class="btn btn-dark btn-lg px-5 py-3 text-uppercase fw-bold shadow-sm"
                            style="border-radius: 4px;">
                            Tiếp tục mua sắm
                        </a>
                    </div>

                </div>
            </section>

            <jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>
            <jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>

        </body>

        </html>