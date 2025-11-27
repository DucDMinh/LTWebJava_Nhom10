<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Create Product</title>
                <jsp:include page="/WEB-INF/view/admin/layout/css.jsp"></jsp:include>
                <style>
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

                    /* Thêm style để phân biệt các section */
                    .form-section-title {
                        margin-top: 20px;
                        margin-bottom: 10px;
                        font-weight: bold;
                        color: #4e73df;
                        border-bottom: 1px solid #e3e6f0;
                        padding-bottom: 5px;
                    }
                </style>

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
            </head>

            <body>
                <jsp:include page="/WEB-INF/view/admin/layout/header.jsp"></jsp:include>
                <div id="layoutSidenav">
                    <jsp:include page="/WEB-INF/view/admin/layout/sibar.jsp"></jsp:include>
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container mt-2">
                                <div class="row">
                                    <div class="col-md-8 col-12 mx-auto">
                                        <h3>Add new product</h3>
                                        <form:form method="post" action="/admin/product/create"
                                            modelAttribute="newProduct" enctype="multipart/form-data">
                                            <hr>

                                            <div class="form-section-title">General Information</div>

                                            <div class="row mt-2">
                                                <div class="col-md-6">
                                                    <c:set var="errorName">
                                                        <form:errors path="name" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label class="form-label">Name</label>
                                                    <form:input type="text" path="name"
                                                        class="form-control ${not empty errorName ? 'is-invalid' : ''}" />
                                                    ${errorName}
                                                </div>
                                                <div class="col-md-6">
                                                    <c:set var="errorPrice">
                                                        <form:errors path="price" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label class="form-label">Base Price ($)</label>
                                                    <form:input type="number" min="0" step="0.01" path="price"
                                                        class="form-control ${not empty errorPrice ? 'is-invalid' : ''}" />
                                                    ${errorPrice}
                                                </div>
                                            </div>

                                            <div class="row mt-2">
                                                <div class="col-md-6">
                                                    <label class="form-label">Factory</label>
                                                    <form:select class="form-select" path="factory">
                                                        <form:option value="Apple (Macbook)">Apple (Macbook)
                                                        </form:option>
                                                        <form:option value="Asus">Asus</form:option>
                                                        <form:option value="Lenovo">Lenovo</form:option>
                                                        <form:option value="HP">HP</form:option>
                                                        <form:option value="Dell">Dell</form:option>
                                                    </form:select>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label">Category</label>
                                                    <form:select class="form-select" path="category">
                                                        <form:option value="Máy Tính">Máy Tính</form:option>
                                                        <form:option value="Điện Thoại">Điện Thoại</form:option>
                                                        <form:option value="Đồng Hồ">Đồng Hồ</form:option>
                                                    </form:select>
                                                </div>
                                            </div>

                                            <div class="form-section-title">Technical Specifications (Fixed)</div>

                                            <div class="row mt-2">
                                                <div class="col-md-4">
                                                    <label class="form-label">Screen Type</label>
                                                    <form:input type="text" path="screenType" class="form-control"
                                                        placeholder="e.g. IPS LCD" />
                                                </div>
                                                <div class="col-md-4">
                                                    <label class="form-label">Screen Size (inch)</label>
                                                    <form:input type="number" step="0.1" path="screenSize"
                                                        class="form-control" />
                                                </div>
                                                <div class="col-md-4">
                                                    <label class="form-label">Battery (Pin - mAh)</label>
                                                    <form:input type="number" path="pin" class="form-control" />
                                                </div>
                                            </div>

                                            <div class="row mt-2">
                                                <div class="col-md-4">
                                                    <label class="form-label">Operating System</label>
                                                    <form:select path="operatingSystem" class="form-control">
                                                        <form:option value="">Select OS</form:option>
                                                        <form:option value="Windows">Windows</form:option>
                                                        <form:option value="Android">Android</form:option>
                                                        <form:option value="iOS">iOS</form:option>
                                                    </form:select>
                                                </div>
                                            </div>

                                            <div class="form-section-title">Initial Configuration (Variant)</div>
                                            <div class="alert alert-info" role="alert">
                                                Đây là cấu hình mặc định đầu tiên. Bạn có thể thêm nhiều màu
                                                sắc/RAM/storage
                                                khác sau khi tạo xong.
                                            </div>

                                            <div class="row mt-2">
                                                <div class="col-md-4">
                                                    <label class="form-label">Color</label>
                                                    <form:input type="text" path="productVariants[0].color"
                                                        class="form-control" placeholder="e.g. Black" />
                                                </div>
                                                <div class="col-md-4">
                                                    <label class="form-label">RAM (GB)</label>
                                                    <form:input type="number" path="productVariants[0].ram"
                                                        class="form-control" />
                                                </div>
                                                <div class="col-md-4">
                                                    <label class="form-label">Storage (GB)</label>
                                                    <form:input type="number" path="productVariants[0].storage"
                                                        class="form-control" />
                                                </div>
                                            </div>

                                            <div class="row mt-2">
                                                <div class="col-md-6">
                                                    <label class="form-label">Quantity (Stock)</label>
                                                    <form:input type="number" min="0" path="productVariants[0].quantity"
                                                        class="form-control" />
                                                </div>
                                            </div>

                                            <div class="form-section-title">Description & Image</div>

                                            <div class="row mt-2">
                                                <div class="col-12">
                                                    <c:set var="errorShortDesc">
                                                        <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label class="form-label">Short Description</label>
                                                    <form:input type="text" path="shortDesc"
                                                        class="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}" />
                                                    ${errorShortDesc}
                                                </div>
                                            </div>

                                            <div class="row mt-2">
                                                <div class="col-12">
                                                    <c:set var="errorDetailDesc">
                                                        <form:errors path="detailDesc" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label class="form-label">Detail Description</label>
                                                    <form:textarea rows="3" path="detailDesc"
                                                        class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}" />
                                                    ${errorDetailDesc}
                                                </div>
                                            </div>

                                            <div class="row mt-2">
                                                <div class="col-12">
                                                    <label for="avatarFile" class="form-label">Product Image</label>
                                                    <input class="form-control" type="file" id="avatarFile"
                                                        accept=".png, .jpg, .jpeg" name="daominhducFile" />
                                                </div>
                                            </div>
                                            <div class="col-12 mb-3 mt-2">
                                                <img style="max-height: 250px; display: none;" alt="avatar preview"
                                                    id="avatarPreview">
                                            </div>

                                            <button type="submit" class="btn btn-primary mt-3">Create Product</button>
                                        </form:form>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <jsp:include page="/WEB-INF/view/admin/layout/js.jsp"></jsp:include>
                    </div>
                </div>
            </body>

            </html>