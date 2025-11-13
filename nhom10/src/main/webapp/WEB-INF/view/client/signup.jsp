<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <title>Sign Up</title>
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
                <div class="singup border">
                    <div class="signup__title fs-4 text-center fw-bold ">
                        Đăng ký tài khoản
                    </div>
                    <form:form method="post" action="/home/signup-create" modelAttribute="signUp">
                        <div class="signup__content">
                            <div class="it1 signup__content--item border d-flex align-items-center gap-4">
                                <div class="signup__content--left"></div>
                                <div class="item__icon">
                                    <img src="${env}/client/img/sign_in/User.png" alt="logo">
                                </div>
                                <div class="gach border-start "></div>
                                <div class="input">
                                    <c:set var="usernameError">
                                        <form:errors path="username" cssClass="invalid-feedback" />
                                    </c:set>
                                    <form:input type="text" placeholder="Nhập tên đăng nhập "
                                        class="input__email ${not empty usernameError?'is-invalid':''}" name="username"
                                        path="username" />
                                    ${usernameError}
                                </div>
                            </div>
                        </div>
                        <div class="signup__content">
                            <div class="it1 signup__content--item border d-flex align-items-center gap-4">
                                <div class="signup__content--left"></div>
                                <div class="item__icon">
                                    <img src="${env}/client/img/sign_in/email.png" alt="logo">
                                </div>
                                <div class="gach border-start "></div>
                                <div class="input">
                                    <c:set var="emailError">
                                        <form:errors path="email" cssClass="invalid-feedback" />
                                    </c:set>
                                    <form:input type="email" name="email" path="email" placeholder="Nhập  Email"
                                        class="input__email ${not empty emailError?'is-invalid':''}" />
                                    ${emailError}
                                </div>
                            </div>
                        </div>
                        <div class="signup__content">
                            <div class="it1 signup__content--item border d-flex align-items-center gap-4">
                                <div class="signup__content--left"></div>
                                <div class="item__icon">
                                    <img src="${env}/client/img/sign_in/User.png" alt="logo">
                                </div>
                                <div class="gach border-start "></div>
                                <div class="input">
                                    <form:input type="text" name="fullName" path="fullName" placeholder="Nhập  fullName"
                                        class="input__email" />
                                </div>
                            </div>
                        </div>
                        <div class="signup__content">
                            <div class="it1 signup__content--item border d-flex align-items-center gap-4">
                                <div class="signup__content--left"></div>
                                <div class="item__icon">
                                    <img src="${env}/client/img/sign_in/key.png" alt="logo">
                                </div>
                                <div class="gach border-start "></div>
                                <div class="input">
                                    <c:set var="passError">
                                        <form:errors path="password" cssClass="invalid-feedback" />
                                    </c:set>
                                    <form:input type="password" name="password" path="password"
                                        placeholder="Nhập mật khẩu"
                                        class="input__email ${not empty passError?'is-invalid':''}" />
                                    ${passError}
                                </div>
                            </div>
                        </div>
                        <div class="signup__content">
                            <div class="it1 signup__content--item border d-flex align-items-center gap-4">
                                <div class="signup__content--left"></div>
                                <div class="item__icon">
                                    <img src="${env}/client/img/sign_in/key.png" alt="logo">
                                </div>
                                <div class="gach border-start "></div>
                                <div class="input">
                                    <c:set var="passwordError">
                                        <form:errors path="confirmPassword" cssClass="invalid-feedback" />
                                    </c:set>
                                    <form:input type="password" name="confirmPassword" path="confirmPassword"
                                        placeholder="Nhập lại mật khẩu"
                                        class="input__email ${not empty passwordError?'is-invalid':''}" />
                                    ${passwordError}
                                </div>
                            </div>
                        </div>
                        <div class="signup__content">
                            <div class="it1 signup__content--item border d-flex align-items-center gap-4">
                                <div class="signup__content--left"></div>
                                <div class="item__icon">
                                    <img src="${env}/client/img/sign_in/address.png" alt="logo">
                                </div>
                                <div class="gach border-start "></div>
                                <div class="input">
                                    <form:input type="text" name="address" path="address" placeholder="Nhập  address"
                                        class="input__email" />
                                </div>
                            </div>
                        </div>
                        <div class="signup__content">
                            <div class="it1 signup__content--item border d-flex align-items-center gap-4">
                                <div class="signup__content--left"></div>
                                <div class="item__icon">
                                    <img src="${env}/client/img/sign_in/telephone.png" alt="logo">
                                </div>
                                <div class="gach border-start "></div>
                                <div class="input">
                                    <form:input type="text" name="phone" path="phone" placeholder="Nhập  phone"
                                        class="input__email" />
                                </div>
                            </div>
                        </div>
                        <div class="signup__content">
                            <div class="already">
                                <span>Bạn đã có tài khoản?</span>
                                <a href="/home/signin">Đăng nhập ngay!</a>
                            </div>
                            <button type="submit"
                                class="btn btn-primary but d-flex justify-content-center align-items-center gap-2 m-auto">
                                <img src="${env}/client/img/sign_in/login.png" alt="logo">
                                <span>Đăng ký</span>
                            </button>
                        </div>
                    </form:form>

                </div>
                <jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>
            </body>

            </html>