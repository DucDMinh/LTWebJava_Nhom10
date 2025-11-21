<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <title>Update Product</title>
                    <jsp:include page="/WEB-INF/view/admin/layout/css.jsp"></jsp:include>

                    <style>
                        .form-section-title {
                            margin-top: 25px;
                            margin-bottom: 15px;
                            font-weight: bold;
                            color: #4e73df;
                            border-bottom: 2px solid #e3e6f0;
                            padding-bottom: 5px;
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                        }

                        .variant-card {
                            background-color: #f8f9fa;
                            border-left: 4px solid #4e73df;
                            margin-bottom: 10px;
                            transition: all 0.2s;
                        }

                        .variant-card:hover {
                            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                        }

                        .variant-card.new-row {
                            border-left-color: #1cc88a;
                            /* Màu xanh lá cho dòng mới thêm */
                        }
                    </style>

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
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="/WEB-INF/view/admin/layout/header.jsp"></jsp:include>
                    <div id="layoutSidenav">
                        <jsp:include page="/WEB-INF/view/admin/layout/sibar.jsp"></jsp:include>
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container mt-3">
                                    <div class="row">
                                        <div class="col-12">
                                            <a href="/admin/product" class="btn btn-secondary mb-3">&laquo; Back
                                                List</a>
                                        </div>
                                        <div class="col-md-10 col-12 mx-auto">
                                            <div class="card shadow-sm">
                                                <div class="card-header bg-primary text-white">
                                                    <h4 class="mb-0">Update Product: ${newProduct.name}</h4>
                                                </div>
                                                <div class="card-body">
                                                    <form:form method="post" action="/admin/product/update"
                                                        modelAttribute="newProduct" enctype="multipart/form-data">

                                                        <form:hidden path="id" />
                                                        <form:hidden path="image" />

                                                        <div class="form-section-title">General Information</div>
                                                        <div class="row">
                                                            <div class="col-md-6 mb-3">
                                                                <label class="form-label">Name</label>
                                                                <form:input path="name" class="form-control" />
                                                                <form:errors path="name" cssClass="text-danger small" />
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label class="form-label">Base Price ($)</label>
                                                                <form:input type="number" step="0.01" path="price"
                                                                    class="form-control" />
                                                                <form:errors path="price"
                                                                    cssClass="text-danger small" />
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6 mb-3">
                                                                <label class="form-label">Factory</label>
                                                                <form:select class="form-select" path="factory">
                                                                    <form:option value="Apple">Apple</form:option>
                                                                    <form:option value="Dell">Dell</form:option>
                                                                    <form:option value="Asus">Asus</form:option>
                                                                    <form:option value="HP">HP</form:option>
                                                                </form:select>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label class="form-label">Category</label>
                                                                <form:select class="form-select" path="category">
                                                                    <form:option value="Máy Tính">Máy Tính</form:option>
                                                                    <form:option value="Điện Thoại">Điện Thoại
                                                                    </form:option>
                                                                    <form:option value="Đồng Hồ">Đồng Hồ</form:option>
                                                                </form:select>
                                                            </div>
                                                        </div>

                                                        <div class="form-section-title">Fixed Specifications</div>
                                                        <div class="row">
                                                            <div class="col-md-4 mb-3">
                                                                <label class="form-label">Screen Type</label>
                                                                <form:input path="screenType" class="form-control"
                                                                    placeholder="e.g. IPS LCD" />
                                                            </div>
                                                            <div class="col-md-4 mb-3">
                                                                <label class="form-label">Size (inch)</label>
                                                                <form:input type="number" step="0.1" path="screenSize"
                                                                    class="form-control" />
                                                            </div>
                                                            <div class="col-md-4 mb-3">
                                                                <label class="form-label">Battery (mAh)</label>
                                                                <form:input type="number" path="pin"
                                                                    class="form-control" />
                                                            </div>
                                                        </div>

                                                        <div class="form-section-title">
                                                            <span>Product Variants (Color & RAM)</span>
                                                            <button type="button" class="btn btn-success btn-sm"
                                                                onclick="addVariantRow()">
                                                                <i class="fas fa-plus"></i> Add Variant
                                                            </button>
                                                        </div>

                                                        <div id="variantContainer">
                                                            <c:forEach items="${newProduct.productVariants}"
                                                                var="variant" varStatus="status">
                                                                <div class="card variant-card" id="row-${status.index}">
                                                                    <div class="card-body p-2">
                                                                        <div class="row align-items-end">
                                                                            <form:hidden
                                                                                path="productVariants[${status.index}].id" />

                                                                            <div class="col-md-3">
                                                                                <label
                                                                                    class="small text-muted">Color</label>
                                                                                <form:input
                                                                                    path="productVariants[${status.index}].color"
                                                                                    class="form-control form-control-sm"
                                                                                    required="true" />
                                                                            </div>
                                                                            <div class="col-md-2">
                                                                                <label class="small text-muted">RAM
                                                                                    (GB)</label>
                                                                                <form:input type="number"
                                                                                    path="productVariants[${status.index}].ram"
                                                                                    class="form-control form-control-sm"
                                                                                    required="true" />
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <label class="small text-muted">Price
                                                                                    ($)</label>
                                                                                <form:input type="number" step="0.01"
                                                                                    path="productVariants[${status.index}].price"
                                                                                    class="form-control form-control-sm"
                                                                                    required="true" />
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <label
                                                                                    class="small text-muted">Stock</label>
                                                                                <form:input type="number"
                                                                                    path="productVariants[${status.index}].quantity"
                                                                                    class="form-control form-control-sm"
                                                                                    required="true" />
                                                                            </div>
                                                                            <div class="col-md-1">
                                                                                <button type="button"
                                                                                    class="btn btn-danger btn-sm w-100"
                                                                                    onclick="removeVariantRow('row-${status.index}')">X</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </div>

                                                        <div class="form-section-title">Details</div>
                                                        <div class="mb-3">
                                                            <label class="form-label">Short Description</label>
                                                            <form:input path="shortDesc" class="form-control" />
                                                        </div>
                                                        <div class="mb-3">
                                                            <label class="form-label">Detail Description</label>
                                                            <form:textarea path="detailDesc" rows="3"
                                                                class="form-control" />
                                                        </div>

                                                        <div class="row align-items-center">
                                                            <div class="col-md-6">
                                                                <label class="form-label">Upload New Image</label>
                                                                <input class="form-control" type="file" id="avatarFile"
                                                                    accept="image/*" name="daominhducFile" />
                                                            </div>
                                                            <div class="col-md-6 text-center mt-2">
                                                                <img src="/images/product/${newProduct.image}"
                                                                    id="avatarPreview"
                                                                    style="max-height: 150px; border: 1px solid #ddd; padding: 5px; border-radius: 5px;">
                                                            </div>
                                                        </div>

                                                        <div class="mt-4 d-grid">
                                                            <button type="submit" class="btn btn-warning btn-lg">Update
                                                                Product</button>
                                                        </div>
                                                    </form:form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </main>
                            <jsp:include page="/WEB-INF/view/admin/layout/js.jsp"></jsp:include>
                        </div>
                    </div>

                    <script>
                        // Lấy số lượng variant hiện tại để làm index bắt đầu
                        let variantIndex = Number("${fn:length(newProduct.productVariants)}");

                        function addVariantRow() {
                            const container = document.getElementById("variantContainer");

                            // Tạo chuỗi HTML cho dòng mới.
                            // Lưu ý: Không thêm input hidden ID vì đây là dòng mới (Insert)
                            const html = `
                <div class="card variant-card new-row" id="row-new-\${variantIndex}">
                    <div class="card-body p-2">
                        <div class="row align-items-end">
                            <div class="col-md-3">
                                <label class="small text-muted">Color</label>
                                <input type="text" name="productVariants[\${variantIndex}].color" class="form-control form-control-sm" placeholder="Màu..." required />
                            </div>
                            <div class="col-md-2">
                                <label class="small text-muted">RAM</label>
                                <input type="number" name="productVariants[\${variantIndex}].ram" class="form-control form-control-sm" value="8" required />
                            </div>
                            <div class="col-md-3">
                                <label class="small text-muted">Price</label>
                                <input type="number" step="0.01" name="productVariants[\${variantIndex}].price" class="form-control form-control-sm" value="0" required />
                            </div>
                            <div class="col-md-3">
                                <label class="small text-muted">Stock</label>
                                <input type="number" name="productVariants[\${variantIndex}].quantity" class="form-control form-control-sm" value="0" required />
                            </div>
                            <div class="col-md-1">
                                <button type="button" class="btn btn-danger btn-sm w-100" onclick="removeVariantRow('row-new-\${variantIndex}')">X</button>
                            </div>
                        </div>
                    </div>
                </div>
            `;

                            container.insertAdjacentHTML('beforeend', html);
                            variantIndex++; // Tăng index để lần sau không bị trùng
                        }

                        function removeVariantRow(elementId) {
                            const row = document.getElementById(elementId);
                            if (row) {
                                row.remove();
                            }
                            // Khi xóa element HTML, Spring sẽ không nhận được dữ liệu của dòng đó.
                            // Nếu là dòng cũ (có ID), Hibernate sẽ tự delete trong DB (nhờ orphanRemoval=true).
                            // Nếu là dòng mới (chưa có ID), nó chỉ đơn giản là không được insert.
                        }
                    </script>
                </body>

                </html>