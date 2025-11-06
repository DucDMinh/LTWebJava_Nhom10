<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="" />
                    <meta name="author" content="" />
                    <title>Product</title>
                    <!--css-->
                    <jsp:include page="/WEB-INF/view/admin/layout/css.jsp"></jsp:include>
                    <style>
                        /* Header */
                        .header__search {
                            width: 372px;
                            height: 56px;
                            background-color: var(--bgr-search);
                            border-radius: 10px;
                            border: 1px solid black;
                        }

                        .header__search--input {
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
                            <main class="container mt-3">
                                <form:form method="post" action="/admin/product/delete" modelAttribute="delete">
                                    <h1>Are you sure you want to delete this Product: ${id}</h1>
                                    <div class="mb-3" style="display: none;">
                                        <label class="form-label">ID</label>
                                        <form:input value="${id}" type="text" path="id" class="form-control"
                                            readonly="true" />
                                    </div>
                                    <div class="alert alert-danger" role="alert">
                                        This action cannot be undone!
                                    </div>
                                    <button type="submit" class="btn btn-warning">Submit</button>
                                    <a href="/admin/product" type="submit" class="btn btn-success">Cancel</a>
                                </form:form>
                            </main>
                            <!--footer-->
                            <jsp:include page="/WEB-INF/view/admin/layout/footer.jsp"></jsp:include>
                        </div>
                    </div>
                    <!--js-->
                    <jsp:include page="/WEB-INF/view/admin/layout/js.jsp"></jsp:include>

                </body>

                </html>