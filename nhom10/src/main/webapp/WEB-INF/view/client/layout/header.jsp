<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
      <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


        <header id="header" class="site-header header-scrolled position-fixed text-black bg-light">
          <nav id="header-nav" class="navbar navbar-expand-lg px-3 mb-3">
            <div class="container-fluid">
              <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <img src="${pageContext.request.contextPath}/client/img/logo.png" class="logo">
              </a>
              <button class="navbar-toggler d-flex d-lg-none order-3 p-2" type="button" data-bs-toggle="offcanvas"
                data-bs-target="#bdNavbar" aria-controls="bdNavbar" aria-expanded="false"
                aria-label="Toggle navigation">
                <svg class="navbar-icon">
                  <use xlink:href="#navbar-icon"></use>
                </svg>
              </button>
              <div class="offcanvas offcanvas-end" tabindex="-1" id="bdNavbar" aria-labelledby="bdNavbarOffcanvasLabel">
                <div class="offcanvas-header px-4 pb-0">
                  <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                    <img src="${pageContext.request.contextPath}/client/img/logo.png" class="logo">
                  </a>
                  <button type="button" class="btn-close btn-close-black" data-bs-dismiss="offcanvas" aria-label="Close"
                    data-bs-target="#bdNavbar"></button>
                </div>
                <div class="offcanvas-body">
                  <ul id="navbar"
                    class="navbar-nav text-uppercase justify-content-end align-items-center flex-grow-1 pe-3">
                    <li class="nav-item">
                      <a class="nav-link me-4 active" href="${pageContext.request.contextPath}/home#billboard">Trang
                        Chủ</a>
                    </li>

                    <li class="nav-item">
                      <a class="nav-link me-4" href="${pageContext.request.contextPath}/products">Sản Phẩm</a>
                    </li>

                    <li class="nav-item">
                      <a class="nav-link me-4" href="${pageContext.request.contextPath}/home#latest-blog">Tin Tức</a>
                    </li>

                    <li class="nav-item">
                      <div class="user-items ps-5">
                        <ul class="d-flex align-items-center justify-content-end list-unstyled m-0">


                          <li class="pe-3">
                            <a href="/wishlist" class="search-button">
                              <i class="fa-regular fa-heart fa-lg"></i>
                            </a>
                          </li>


                          <li class="pe-3 dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button"
                              data-bs-toggle="dropdown" aria-expanded="false">
                              <i class="fa-solid fa-user fa-lg me-1 text-dark"></i>
                              <span class="text-dark">${sessionScope.fullName}</span>
                            </a>

                            <ul class="dropdown-menu dropdown-menu-end">

                              <li>
                                <a class="dropdown-item" href="/profile">
                                  <i class="align-middle me-1" data-feather="shopping-bag"></i> Hồ Sơ
                                </a>
                              </li>

                              <li>
                                <a class="dropdown-item" href="/home/order/history">
                                  <i class="align-middle me-1" data-feather="shopping-bag"></i> Lịch sử mua hàng
                                </a>
                              </li>

                              <li>
                                <hr class="dropdown-divider">
                              </li>


                              <li>
                                <form action="/logout" method="post">
                                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                  <button class="dropdown-item">Đăng xuất</button>
                                </form>
                              </li>

                            </ul>
                          </li>

                          <!-- Cart -->
                          <li>
                            <a href="/cart">
                              <i class="fa-solid fa-cart-shopping"></i>
                            </a>
                          </li>

                        </ul>
                      </div>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </nav>
        </header>
        <c:if test="${not empty successMessage}">
          <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
            <div id="liveToast" class="toast show align-items-center text-white bg-success border-0" role="alert"
              aria-live="assertive" aria-atomic="true">
              <div class="d-flex">
                <div class="toast-body">
                  <i class="fas fa-check-circle me-2"></i> ${successMessage}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                  aria-label="Close"></button>
              </div>
            </div>
          </div>

          <script>
            document.addEventListener("DOMContentLoaded", function () {
              var toastEl = document.getElementById('liveToast');
              // Dùng Bootstrap Toast API nếu có, hoặc set timeout ẩn thủ công
              setTimeout(function () {
                if (toastEl) {
                  toastEl.classList.remove('show'); // Ẩn bằng CSS
                  toastEl.classList.add('hide');
                }
              }, 3000); // 3000ms = 3 giây
            });
          </script>
        </c:if>