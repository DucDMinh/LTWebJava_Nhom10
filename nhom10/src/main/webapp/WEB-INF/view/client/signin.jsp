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
                <meta name="format-detection" content="telephone=no">
                <meta name="apple-mobile-web-app-capable" content="yes">
                <meta name="author" content="">
                <meta name="keywords" content="">
                <meta name="description" content="">
                <jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>

            </head>

            <body>
                <div class="signin border">
                    <div class="signin__title fs-4 fw-bold text-center">Đăng nhập</div>
                    <div class="signin__content">
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
                                    <input type="password" name="password" placeholder="Nhập mật khẩu của bạn"
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
                                        <label class="form-check-label " for="flexCheckChecked">
                                            Ghi nhớ đăng nhập
                                        </label>
                                    </div>
                                </div>
                                <div class="forgot">
                                    <a href="" class="text-dark">
                                        Quên mật khẩu?
                                    </a>
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
                                <a href="/oauth2/authorization/google" title="Đăng nhập với Google">
                                    <img height="40" width="40" src="${env}/client/img/provider/default-google.png" />
                                </a>
                                <a href="/oauth2/authorization/github" title="Đăng nhập với Github">
                                    <img height="40" width="40" src="${env}/client/img/provider/default-github.png" />
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>
            </body>

            </html>