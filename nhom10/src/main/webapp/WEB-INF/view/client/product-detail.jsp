<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
			<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

				<!DOCTYPE html>
				<html lang="en">

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
						<symbol xmlns="http://www.w3.org/2000/svg" id="star-empty" viewBox="0 0 16 16">
							<path
								d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.565.565 0 0 0-.163-.505L1.71 6.745l4.052-.576a.525.525 0 0 0 .393-.288L8 2.223l1.847 3.658a.525.525 0 0 0 .393.288l4.052.575-2.906 2.77a.565.565 0 0 0-.163.506l.694 3.957-3.686-1.894a.503.503 0 0 0-.461 0z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="star-half" viewBox="0 0 16 16">
							<path
								d="M5.354 5.119 7.538.792A.516.516 0 0 1 8 .5c.183 0 .366.097.465.292l2.184 4.327 4.898.696A.537.537 0 0 1 16 6.32a.548.548 0 0 1-.17.445l-3.523 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256a.52.52 0 0 1-.146.05c-.342.06-.668-.254-.6-.642l.83-4.73L.173 6.765a.55.55 0 0 1-.172-.403.58.58 0 0 1 .085-.302.513.513 0 0 1 .37-.245l4.898-.696zM8 12.027a.5.5 0 0 1 .232.056l3.686 1.894-.694-3.957a.565.565 0 0 1 .162-.505l2.907-2.77-4.052-.576a.525.525 0 0 1-.393-.288L8.001 2.223 8 2.226v9.8z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="hand-thumbs-up" viewBox="0 0 16 16">
							<path
								d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="hand-thumbs-up-fill" viewBox="0 0 16 16">
							<path
								d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a9.84 9.84 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733.058.119.103.242.138.363.077.27.113.567.113.856 0 .289-.036.586-.113.856-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.163 3.163 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.82 4.82 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z" />
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
										<span class="ms-2 text-muted small">(120 đánh giá)</span>
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

									<form method="POST" action="${pageContext.request.contextPath}/add-to-cart">
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
											<label for="quantityInput" class="form-label fw-bold">Số lượng</label>
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
												Thêm vào giỏ hàng
											</button>
										</div>
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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
										Mô tả chi tiết sản phẩm
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
										Thông số kỹ thuật
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

						<jsp:include page="/WEB-INF/view/client/components/rating-summary.jsp"></jsp:include>
						<jsp:include page="/WEB-INF/view/client/components/comments-section.jsp"></jsp:include>
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