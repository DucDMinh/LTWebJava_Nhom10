<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
			<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

				<!DOCTYPE html>
				<html>

				<head>
					<title>${product.name} - Product Detail</title>
					<meta charset="utf-8">
					<meta http-equiv="X-UA-Compatible" content="IE=edge">
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>
					<style>
						.variant-option {
							border: 1px solid #e1e1e1;
							padding: 10px;
							margin-bottom: 8px;
							border-radius: 8px;
							cursor: pointer;
							transition: all 0.2s;
						}

						.variant-option:hover {
							border-color: #0d6efd;
							background-color: #f8f9fa;
						}

						.variant-option input:checked+label {
							font-weight: bold;
							color: #0d6efd;
						}

						.variant-option.out-of-stock {
							opacity: 0.6;
							background-color: #f2f2f2;
							pointer-events: none;
						}
					</style>
				</head>

				<body>
					<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
						<symbol xmlns="http://www.w3.org/2000/svg" id="star-fill" viewBox="0 0 16 16">
							<path
								d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z" />
						</symbol>
					</svg>

					<jsp:include page="/WEB-INF/view/client/layout/header.jsp"></jsp:include>

					<section
						style="background: url(${pageContext.request.contextPath}/client/img/banner.jpg) center 15% / cover no-repeat; height: 350px;">
					</section>

					<div class="container padding-small no-padding-bottom">
						<nav aria-label="breadcrumb">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="/">Home</a></li>
								<li class="breadcrumb-item"><a href="/shop">Shop</a></li>
								<li class="breadcrumb-item active" aria-current="page">${product.name}</li>
							</ol>
						</nav>
					</div>

					<div class="container padding-xsmall">
						<div class="row">
							<div class="col-12 col-lg-6">
								<div id="productCarousel" class="carousel slide mb-3" data-bs-interval="false">
									<div class="carousel-inner">
										<div class="carousel-item active">
											<img src="/images/product/${product.image}" class="d-block w-100"
												alt="${product.name}">
										</div>
									</div>
								</div>
							</div>

							<div class="col-12 col-lg-6">
								<div class="product-info">
									<h2 class="fs-3 mb-2">${product.name}</h2>

									<div class="d-flex align-items-center mb-3">
										<div class="rating-stars d-flex text-warning">
											<svg width="20" height="20">
												<use xlink:href="#star-fill"></use>
											</svg>
											<svg width="20" height="20">
												<use xlink:href="#star-fill"></use>
											</svg>
											<svg width="20" height="20">
												<use xlink:href="#star-fill"></use>
											</svg>
											<svg width="20" height="20">
												<use xlink:href="#star-fill"></use>
											</svg>
											<svg width="20" height="20">
												<use xlink:href="#star-fill"></use>
											</svg>
										</div>
										<span class="ms-2 text-muted small">(Review feature coming soon)</span>
									</div>

									<div class="d-flex align-items-baseline mb-3">
										<p class="fs-4 fw-bold text-primary mb-0">
											Giá từ:
											<fmt:formatNumber type="number" value="${product.price}" /> $
										</p>
									</div>

									<div class="product-description mb-4 text-secondary">
										<p>${product.shortDesc}</p>
									</div>

									<form method="POST" action="/cart/add-to-cart">

										<div class="mb-4">
											<label class="form-label fw-bold">Chọn phiên bản (Màu sắc & RAM):</label>
											<div class="d-flex flex-column gap-2">
												<c:forEach items="${product.productVariants}" var="variant"
													varStatus="status">
													<div
														class="form-check variant-option ${variant.quantity <= 0 ? 'out-of-stock' : ''}">
														<input class="form-check-input" type="radio" name="variantId"
															id="variant_${variant.id}" value="${variant.id}"
															${status.first && variant.quantity> 0 ? 'checked' : ''}
														${variant.quantity <= 0 ? 'disabled' : '' }>

															<label
																class="form-check-label d-flex justify-content-between w-100"
																for="variant_${variant.id}">
																<span>
																	<strong>${variant.color}</strong> - ${variant.ram}GB
																	RAM
																</span>
																<span>
																	<strong class="text-danger">
																		<fmt:formatNumber value="${variant.price}" /> $
																	</strong>
																	<small class="text-muted ms-2">
																		(${variant.quantity > 0 ? 'Còn hàng' : 'Hết
																		hàng'})
																	</small>
																</span>
															</label>
													</div>
												</c:forEach>
											</div>
										</div>

										<div class="quantity-selector mb-4">
											<label for="quantityInput" class="form-label fw-bold">Quantity</label>
											<div class="input-group" style="width: 140px;">
												<button class="btn btn-outline-secondary" type="button"
													onclick="decreaseQty()">-</button>
												<input type="number" class="form-control text-center" value="1" min="1"
													id="quantityInput" name="quantity">
												<button class="btn btn-outline-secondary" type="button"
													onclick="increaseQty()">+</button>
											</div>
										</div>

										<div class="action-buttons d-grid gap-2 d-md-flex">
											<button class="btn btn-primary btn-lg flex-grow-1" type="submit">
												Add to Cart
											</button>
										</div>
									</form>
									<div class="product-meta border-top pt-3 mt-4 text-secondary">
										<div class="d-flex justify-content-between mb-1">
											<small class="text-uppercase fw-bold">Category:</small>
											<small>${product.category}</small>
										</div>
										<div class="d-flex justify-content-between">
											<small class="text-uppercase fw-bold">Factory:</small>
											<small>${product.factory}</small>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="accordion my-5" id="productDetailsAccordion">
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingDescription">
									<button class="accordion-button" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseDescription" aria-expanded="true">
										Detailed Description
									</button>
								</h2>
								<div id="collapseDescription" class="accordion-collapse collapse show"
									data-bs-parent="#productDetailsAccordion">
									<div class="accordion-body">
										<p>${product.detailDesc}</p>
									</div>
								</div>
							</div>

							<div class="accordion-item">
								<h2 class="accordion-header" id="headingSpecs">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseSpecs">
										Technical Specifications
									</button>
								</h2>
								<div id="collapseSpecs" class="accordion-collapse collapse"
									data-bs-parent="#productDetailsAccordion">
									<div class="accordion-body">
										<table class="table table-striped">
											<tbody>
												<tr>
													<th scope="row">Màn hình (Screen Type)</th>
													<td>${product.screenType}</td>
												</tr>
												<tr>
													<th scope="row">Kích thước (Size)</th>
													<td>${product.screenSize} inch</td>
												</tr>
												<tr>
													<th scope="row">Dung lượng Pin (Battery)</th>
													<td>${product.pin} mAh</td>
												</tr>
												<tr>
													<th scope="row">Hãng sản xuất</th>
													<td>${product.factory}</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>

					<jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>
					<jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>

					<script>
						function increaseQty() {
							var qtyInput = document.getElementById('quantityInput');
							qtyInput.value = parseInt(qtyInput.value) + 1;
						}
						function decreaseQty() {
							var qtyInput = document.getElementById('quantityInput');
							if (parseInt(qtyInput.value) > 1) {
								qtyInput.value = parseInt(qtyInput.value) - 1;
							}
						}
					</script>
				</body>

				</html>