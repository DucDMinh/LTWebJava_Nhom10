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
                      <a class="nav-link me-4 active" href="${pageContext.request.contextPath}/home#billboard">Home</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link me-4"
                        href="${pageContext.request.contextPath}/home#company-services">Services</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link me-4"
                        href="${pageContext.request.contextPath}/home#mobile-products">Products</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link me-4" href="${pageContext.request.contextPath}/home#smart-watches">Watches</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link me-4" href="${pageContext.request.contextPath}/home#yearly-sale">Sale</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link me-4" href="${pageContext.request.contextPath}/home#latest-blog">Blog</a>
                    </li>
                    <li class="nav-item dropdown">
                      <a class="nav-link me-4 dropdown-toggle link-dark" data-bs-toggle="dropdown" href="#"
                        role="button" aria-expanded="false">Pages</a>
                      <ul class="dropdown-menu">
                        <li>
                          <a href="${pageContext.request.contextPath}/about" class="dropdown-item">About</a>
                        </li>
                        <li>
                          <a href="${pageContext.request.contextPath}/blog" class="dropdown-item">Blog</a>
                        </li>
                        <li>
                          <a href="${pageContext.request.contextPath}/shop" class="dropdown-item">Shop</a>
                        </li>
                        <li>
                          <a href="${pageContext.request.contextPath}/cart" class="dropdown-item">Cart</a>
                        </li>
                        <li>
                          <a href="${pageContext.request.contextPath}/payment" class="dropdown-item">Checkout</a>
                        </li>
                        <li>
                          <a href="${pageContext.request.contextPath}/single-post" class="dropdown-item">Single Post</a>
                        </li>
                        <li>
                          <a href="${pageContext.request.contextPath}/product-detail" class="dropdown-item">Product
                            Detail</a>
                        </li>
                        <li>
                          <a href="${pageContext.request.contextPath}/contact" class="dropdown-item">Contact</a>
                        </li>
                      </ul>
                    </li>
                    <li class="nav-item">
                      <div class="user-items ps-5">
                        <ul class="d-flex justify-content-end list-unstyled">
                          <li class="search-item pe-3">
                            <a href="#" class="search-button">
                              <svg class="search">
                                <use xlink:href="#search"></use>
                              </svg>
                            </a>
                          </li>
                          <li class="pe-3">
                            <a href="#">
                              <svg class="user">
                                <use xlink:href="#user"></use>
                              </svg>
                            </a>
                          </li>
                          <li>
                            <a href="${pageContext.request.contextPath}/cart">
                              <svg class="cart">
                                <use xlink:href="#cart"></use>
                              </svg>
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
                setTimeout(function () {
                  if (toastEl) {
                    toastEl.classList.remove('show');
                    toastEl.classList.add('hide');
                  }
                }, 3000);
              });
            </script>
          </c:if>
        </header>