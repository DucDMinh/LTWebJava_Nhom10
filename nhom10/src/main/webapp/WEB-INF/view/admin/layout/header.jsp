<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
    <!-- Navbar Brand-->
    <a class="navbar-brand ps-3" href="/admin">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
             viewBox="0 0 24 24" fill="none" stroke="currentColor"
             stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
             class="feather feather-box align-middle">
            <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
            <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
            <line x1="12" y1="22.08" x2="12" y2="12"></line>
        </svg>
        <span class="align-middle">MinhKZ</span>
    </a>

    <!-- Sidebar Toggle -->
    <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0"
            id="sidebarToggle" href="#!">
        <i class="fas fa-bars"></i>
    </button>
    <!-- Spacer để căn giữa -->
    <div class="flex-grow-1"></div>
    <!-- Navbar -->
    <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle d-none d-sm-inline-block"
               href="#" role="button" data-bs-toggle="dropdown"
               aria-expanded="false">
                <img src="${env}/admin/images/user/${sessionScope.avatar}"
                     class="avatar img-fluid rounded-circle me-1"
                     alt="avatar" width="40" height="40">
                <span class="text-light">${sessionScope.fullName}</span>
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="pages-profile.html">
                    <i class="align-middle me-1" data-feather="user"></i> Profile
                </a></li>
                <li><a class="dropdown-item" href="#">
                    <i class="align-middle me-1" data-feather="pie-chart"></i> Analytics
                </a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="pages-settings.html">Settings & Privacy</a></li>
                <li><a class="dropdown-item" href="#">Help</a></li>
                <li>
                    <form action="/logout" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <button  class="dropdown-item">Sign out</button>
                    </form>
                </li>
            </ul>
        </li>
    </ul>
</nav>