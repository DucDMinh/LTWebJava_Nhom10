<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>User</title>
    <!--css-->
    <jsp:include page="/WEB-INF/view/admin/layout/css.jsp"></jsp:include>
    <style>
        /* Header */
        .header__search{
            width: 372px;
            height: 56px;
            background-color: var(--bgr-search);
            border-radius: 10px;
            border: 1px solid black;
        }
        .header__search--input{
            border: 0;
            outline: none;
            background-color: transparent;
        }
    </style>
</head>
<body class="sb-nav-fixed">
<!--header-->
<jsp:include page="/WEB-INF/view/admin/layout/header.jsp"></jsp:include>
<div id="layoutSidenav">
    <!--sibar-->
    <jsp:include page="/WEB-INF/view/admin/layout/sibar.jsp"></jsp:include>
    <div id="layoutSidenav_content">
        <main>

            <div class="container mt-5">
                <h1 class="mt-4">Manage Users</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Users</li>
                </ol>
                <div class="row">
                    <div class="col-12 mx-auto">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3>Table users</h3>
                            <div class=" header__search d-flex align-items-center gap-2">
                                <form action="/admin/users" method="get">
                                    <label for="search" class="p-2">
                                        <img src="${env}/client/images/home/Icon/Search.png" alt="logo">
                                    </label>
                                    <input type="text" placeholder="Search by Full Name" name="name" class="header__search--input" id="search" value="${nameSearch}">
                                </form>
                            </div>
                            <a href="/admin/users/creates" class="btn btn-primary">Create a user</a>
                        </div>

                        <hr />
                        <table class=" table table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Email</th>
                                <th>Username</th>
                                <th>Full Name</th>
                                <th>Role</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="user" items="${users}">

                                <tr>
                                    <th>${user.id}</th>
                                    <td>${user.email}</td>
                                    <td>${user.username}</td>
                                    <td>${user.fullName}</td>
                                    <td>${user.role}</td>
                                    <td>
                                        <a href="/admin/users/views/${user.id}" class="btn btn-success">View</a>
                                        <a href="/admin/users/updates/${user.id}"
                                           class="btn btn-warning  mx-2">Update</a>
                                        <a href="/admin/users/deletes/${user.id}"
                                           class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this item?');">Delete</a>
                                    </td>
                                </tr>

                            </c:forEach>

                            </tbody>
                        </table>
                        <c:if test="${totalPages > 0}">
                        <div class="paging d-flex justify-content-center align-items-center ">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination ">
                                    <li class="page-item">
                                        <a class="${1 eq currentPage ? 'd-none' : 'page-link'}" href="/admin/users?page=${currentPage -1}&name=${nameSearch}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <c:forEach begin="0" end="${totalPages -1}" varStatus="loop">
                                        <li class="page-item">
                                            <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                               href="/admin/users?page=${loop.index + 1}&name=${nameSearch}">
                                                    ${loop.index + 1}
                                            </a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item">
                                        <a class="${currentPage eq totalPages? 'd-none' : 'page-link'}" href="/admin/users?page=${currentPage +1}&name=${nameSearch}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                        </c:if>
                    </div>
                </div>

            </div>
        </main>
        <!--footer-->
        <jsp:include page="/WEB-INF/view/admin/layout/footer.jsp"></jsp:include>
    </div>
</div>
<!--js-->
<jsp:include page="/WEB-INF/view/admin/layout/js.jsp"></jsp:include>

</body>
</html>
