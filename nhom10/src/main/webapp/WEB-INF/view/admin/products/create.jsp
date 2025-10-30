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
    <title>Create a Product</title>
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

            // Image preview
            const imageFile = $("#imageFile");
            imageFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#imagePreview").attr("src", imgURL);
                $("#imagePreview").css({ "display": "block" });
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
                <h1 class="mt-4">Products</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Product</li>
                </ol>
                <div class="mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Create a product</h3>
                            <hr />
                            <form:form method="post" action="/admin/products/create" class="row"
                                       enctype="multipart/form-data" modelAttribute="newProduct">
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="nameError">
                                        <form:errors path="name" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label">Name:</label>
                                    <form:input type="text" class="form-control ${not empty nameError?'is-invalid':''}" path="name" />
                                    ${nameError}
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="priceError">
                                        <form:errors path="price" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label">Price:</label>
                                    <form:input type="number" class="form-control ${not empty priceError?'is-invalid':''}" path="price" />
                                    ${priceError}
                                </div>
                                <div class="mb-3 col-12">
                                    <c:set var="detailError">
                                        <form:errors path="detailDesc" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label">Detail description:</label>
                                    <form:textarea type="text" class="form-control ${not empty detailError?'is-invalid':''}" path="detailDesc" />
                                    ${detailError}
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="shortError">
                                        <form:errors path="shortDesc" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label">Short description:</label>
                                    <form:input type="text" class="form-control ${not empty shortError?'is-invalid':''}" path="shortDesc" />
                                    ${shortError}
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                     <c:set var="quantityError">
                                         <form:errors path="quantity" cssClass="invalid-feedback"/>
                                     </c:set>
                                    <label class="form-label">Quantity:</label>
                                    <form:input type="number" class="form-control ${not empty quantityError?'is-invalid':''}" path="quantity" />
                                    ${quantityError}
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Category:</label>
                                    <form:select class="form-select" path="categoryId">
                                        <form:option value="1">Apple</form:option>
                                        <form:option value="2">SamSung</form:option>
                                    </form:select>
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Sản phẩm nổi bật:</label>
                                    <form:select class="form-select" path="featured">
                                        <form:option value="1">Có</form:option>
                                        <form:option value="0">Không</form:option>
                                    </form:select>
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Sản phẩm giảm giá:</label>
                                    <form:select class="form-select" path="discount">
                                        <form:option value="1">Có</form:option>
                                        <form:option value="0">Không</form:option>
                                    </form:select>
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="colorError">
                                        <form:errors path="color" cssClass="invalid-feedback"/>
                                    </c:set>
                                    <label class="form-label">Color:</label>
                                    <form:input type="text" class="form-control ${not empty colorError?'is-invalid':''}" path="color" />
                                    ${colorError}
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Pin:</label>
                                    <form:select class="form-select" path="pin">
                                        <form:option value="3000">3000mAh</form:option>
                                        <form:option value="4000">4000mAh</form:option>
                                        <form:option value="5000">5000mAh</form:option>
                                    </form:select>
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Screen type:</label>
                                    <form:select class="form-select" path="screenType">
                                        <form:option value="AMOLED">AMOLED</form:option>
                                        <form:option value="IPS Quantum">IPS Quantum</form:option>
                                        <form:option value="Super LCD">Super LCD</form:option>
                                        <form:option value="LED-backlit IPS LCD">LED-backlit IPS LCD</form:option>
                                        <form:option value="ClearBlack">ClearBlack</form:option>
                                    </form:select>
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Screen size:</label>
                                    <form:select class="form-select" path="screenSize">
                                        <form:option value="6.1">6.1inch</form:option>
                                        <form:option value="6.7">6.7inch</form:option>
                                        <form:option value="5.8">Dưới 5.8inch</form:option>
                                    </form:select>
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Protection:</label>
                                    <form:select class="form-select" path="protection">
                                        <form:option value="IP67">IP67</form:option>
                                        <form:option value="IP68">IP68</form:option>
                                    </form:select>
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Rom:</label>
                                    <form:select class="form-select" path="ram">
                                        <form:option value="64">64GB</form:option>
                                        <form:option value="128">128GB</form:option>
                                        <form:option value="256">256GB</form:option>
                                        <form:option value="512">512GB</form:option>
                                        <form:option value="1000">1TB</form:option>
                                    </form:select>
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label for="avatarFile" class="form-label">Avatar:</label>
                                    <input class="form-control" type="file" id="avatarFile"
                                           accept=".png, .jpg, .jpeg" name="nhatminhFile" />
                                </div>
                                <div class="col-12 mb-3">
                                    <img style="max-height: 250px; display: none;" alt="avatar preview"
                                         id="avatarPreview" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label for="imageFile" class="form-label">Image:</label>
                                    <input class="form-control" type="file" id="imageFile"
                                           accept=".png, .jpg, .jpeg" name="nhatminhImgFile" />
                                </div>
                                <div class="col-12 mb-3">
                                    <img style="max-height: 250px; display: none;" alt="avatar preview"
                                         id="imagePreview" />
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
