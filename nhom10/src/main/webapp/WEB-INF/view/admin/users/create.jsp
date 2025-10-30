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
    <title>Create a User</title>
    <!--css-->
    <jsp:include page="/WEB-INF/view/admin/layout/css.jsp"></jsp:include>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#avatarPreview").attr("src", imgURL);
                $("#avatarPreview").css({ "display": "block" });
            });
        });
    </script>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
<!--header-->
<jsp:include page="/WEB-INF/view/admin/layout/header.jsp"></jsp:include>
<div id="layoutSidenav">
    <!--sibar-->
    <jsp:include page="/WEB-INF/view/admin/layout/sibar.jsp"></jsp:include>
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Manage Users</h1>
                <ol class="breadcrumb mb-1">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Users</li>
                </ol>
                <div class="mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Create a user</h3>
                            <hr />
                            <form:form method="post" action="/admin/users/create"
                                       modelAttribute="newUser" class="row" enctype="multipart/form-data">
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="usernameError">
                                        <form:errors path="username" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label">Username:</label>
                                    <form:input type="text" class="form-control ${not empty usernameError?'is-invalid':''}" path="username" />
                                    ${usernameError}
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="emailError">
                                        <form:errors path="email" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label">Email:</label>
                                    <form:input type="email" class="form-control ${not empty emailError?'is-invalid':''}" path="email" />
                                    ${emailError}
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="errorPassword">
                                        <form:errors path="password" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label">Password:</label>
                                    <form:input type="password" class="form-control ${not empty errorPassword?'is-invalid':''}" path="password" />
                                    ${errorPassword}
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="phoneError">
                                        <form:errors path="phone" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label">Phone number:</label>
                                    <form:input type="text" class="form-control ${not empty phoneError?'is-invalid':''}" path="phone" />
                                    ${phoneError}
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="fullError">
                                        <form:errors path="fullName" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label">Full Name:</label>
                                    <form:input type="text" class="form-control ${not empty fullError?'is-invalid':''}" path="fullName" />
                                    ${fullError}
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Address:</label>
                                    <form:input type="text" class="form-control" path="address" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Role:</label>
                                    <form:select class="form-select" path="roleId">
                                        <form:option value="1">ADMIN</form:option>
                                        <form:option value="2">STAFF</form:option>
                                        <form:option value="3">USER</form:option>
                                    </form:select>
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label for="avatarFile" class="form-label">Avatar:</label>
                                    <input class="form-control" type="file" id="avatarFile"
                                           accept=".png, .jpg, .jpeg" name="nhatminhFile">
                                </div>
                                <div class="col-12 mb-3">
                                    <img style="max-height: 250px; display: none;" alt="avatar preview"
                                         id="avatarPreview" />
                                </div>
                                <div class="col-12 mb-5">
                                    <button type="submit" class="btn btn-primary">Create</button>
                                </div>
                            </form:form>

                        </div>

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
