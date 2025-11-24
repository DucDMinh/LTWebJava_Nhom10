<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
			<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

				<!DOCTYPE html>
				<html>

				<head>
					<title>Checkout | CellWorld</title>
					<meta charset="utf-8">
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>
				</head>

				<body data-bs-spy="scroll" data-bs-target="#navbar" data-bs-root-margin="0px 0px -40%"
					data-bs-smooth-scroll="true" tabindex="0">

					<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
						<symbol id="search" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
							<path fill="currentColor"
								d="M19 3C13.488 3 9 7.488 9 13c0 2.395.84 4.59 2.25 6.313L3.281 27.28l1.439 1.44l7.968-7.969A9.922 9.922 0 0 0 19 23c5.512 0 10-4.488 10-10S24.512 3 19 3zm0 2c4.43 0 8 3.57 8 8s-3.57 8-8 8s-8-3.57-8-8s3.57-8 8-8z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="instagram" viewBox="0 0 256 256">
							<path fill="currentColor"
								d="M128 80a48 48 0 1 0 48 48a48.05 48.05 0 0 0-48-48Zm0 80a32 32 0 1 1 32-32a32 32 0 0 1-32 32Zm48-136H80a56.06 56.06 0 0 0-56 56v96a56.06 56.06 0 0 0 56 56h96a56.06 56.06 0 0 0 56-56V80a56.06 56.06 0 0 0-56-56Zm40 152a40 40 0 0 1-40 40H80a40 40 0 0 1-40-40V80a40 40 0 0 1 40-40h96a40 40 0 0 1 40 40ZM192 76a12 12 0 1 1-12-12a12 12 0 0 1 12 12Z" />
						</symbol>
					</svg>

					<jsp:include page="/WEB-INF/view/client/layout/header.jsp"></jsp:include>

					<section style="background: url(client/img/banner.jpg) center 15%/cover no-repeat; height: 300px;">
						<div aria-label="breadcrumb" class="container"></div>
					</section>

					<section id="checkout" style="margin-bottom: 10%;">
						<div class="container">
							<h2 class="section-title" style="margin-top: 5%; margin-bottom: 5%;">Checkout</h2>

							<form:form action="/place-order" method="post" modelAttribute="cart" id="checkoutForm">

								<div class="row g-4 mx-auto" style="width: 100%;">

									<div class="col-lg-7">
										<div class="checkout-section">
											<h5 class="mb-4">Billing Information</h5>

											<div class="row g-3">
												<div class="col-md-6">
													<label class="form-label">Họ và Tên</label>
													<input type="text" class="form-control" value="${user.fullName}"
														readonly />
												</div>
												<div class="col-md-6">
													<label class="form-label">Số điện thoại</label>
													<input type="text" class="form-control" value="${user.phone}"
														readonly />
												</div>
												<div class="col-12">
													<label class="form-label">Địa chỉ nhận hàng</label>
													<input type="text" class="form-control" value="${user.address}"
														readonly />
												</div>

												<div class="col-12 mt-3">
													<label class="form-label fw-bold">Phương thức vận chuyển</label>
													<select class="form-select" id="shippingMethod"
														name="shippingMethod">
														<option value="STANDARD" data-price="11000" selected>Tiêu chuẩn
															(11.000₫)</option>
														<option value="FAST" data-price="22000">Nhanh (22.000₫)</option>
														<option value="EXPRESS" data-price="33000">Siêu tốc (33.000₫)
														</option>
													</select>
												</div>

												<div class="col-12 mt-4">
													<label class="form-label fw-bold">Sản phẩm đã chọn</label>
													<div class="table-responsive">
														<table class="table table-borderless align-middle">
															<thead style="border-bottom: 1px solid #eee;">
																<tr class="text-uppercase text-secondary"
																	style="font-size: 12px;">
																	<th style="width: 50%;">Product</th>
																	<th class="text-center">Price</th>
																	<th class="text-center">Qty</th>
																	<th class="text-end">Total</th>
																</tr>
															</thead>
															<tbody>
																<c:forEach var="item" items="${cartDetails}">
																	<tr style="border-bottom: 1px solid #f8f8f8;">
																		<td class="py-3">
																			<div class="d-flex align-items-center">
																				<img src="/images/product/${item.proConfiguration.product.image}"
																					class="rounded border"
																					style="width: 60px; height: 60px; object-fit: cover; margin-right: 15px;"
																					alt="">
																				<div>
																					<div class="fw-bold text-dark"
																						style="font-size: 14px;">
																						${item.proConfiguration.product.name}
																					</div>
																					<small class="text-muted">
																						${item.proConfiguration.color} |
																						${item.proConfiguration.ram}GB
																					</small>
																				</div>
																			</div>
																		</td>
																		<td class="text-center">
																			<fmt:formatNumber value="${item.price}" /> ₫
																		</td>
																		<td class="text-center">x${item.quantity}</td>
																		<td class="text-end fw-bold">
																			<fmt:formatNumber
																				value="${item.price * item.quantity}" />
																			₫
																		</td>
																	</tr>
																</c:forEach>
															</tbody>
														</table>
													</div>
												</div>

												<div class="col-12">
													<label class="form-label">Order Notes (Optional)</label>
													<textarea name="note" class="form-control" rows="3"
														placeholder="Notes about your order..."></textarea>
												</div>
											</div>
										</div>
									</div>

									<div class="col-lg-5">
										<div class="order-summary-card p-4 border rounded bg-light">
											<h5 class="mb-4">Order Summary</h5>

											<div class="summary-item d-flex justify-content-between mb-2">
												<span>Subtotal:</span>
												<span class="fw-bold" id="subtotalDisplay"
													data-subtotal="${totalPrice}">
													<fmt:formatNumber value="${totalPrice}" /> ₫
												</span>
											</div>

											<div class="summary-item d-flex justify-content-between mb-2">
												<span>Shipping Fee:</span>
												<span class="text-success fw-bold" id="shippingFeeDisplay">11.000
													₫</span>
											</div>

											<div
												class="summary-total d-flex justify-content-between mt-3 pt-3 border-top">
												<span class="fs-5 fw-bold">Total:</span>
												<span class="fs-5 fw-bold text-danger" id="totalDisplay">
													<fmt:formatNumber value="${totalPrice + 11000}" /> ₫
												</span>
											</div>

											<input type="hidden" id="hiddenShippingFee" name="shippingFee"
												value="11000" />
											<input type="hidden" id="hiddenTotalPrice" name="totalPrice"
												value="${totalPrice + 11000}" />

											<h5 class="mt-4 mb-3">Payment Method</h5>

											<div class="form-check mb-2">
												<input class="form-check-input" type="radio" name="paymentMethod"
													value="COD" id="cod" checked />
												<label class="form-check-label" for="cod">Cash on Delivery (COD)</label>
											</div>
											<div class="form-check mb-4">
												<input class="form-check-input" type="radio" name="paymentMethod"
													value="VNPAY" id="vnpay" />
												<label class="form-check-label" for="vnpay">Pay with VNPay</label>
											</div>

											<div style="display: none;">
												<c:forEach var="item" items="${cartDetails}" varStatus="status">
													<input type="hidden" name="cartDetails[${status.index}].id"
														value="${item.id}" />
													<input type="hidden" name="cartDetails[${status.index}].quantity"
														value="${item.quantity}" />
													<input type="hidden" name="cartDetails[${status.index}].price"
														value="${item.price}" />
												</c:forEach>
											</div>

											<button type="submit"
												class="btn btn-dark w-100 py-3 text-uppercase fw-bold">
												Place Order
											</button>
										</div>
									</div>
								</div>
							</form:form>
						</div>
					</section>

					<section id="instagram" class="padding-large overflow-hidden no-padding-top">
						<div class="container">
							<div class="row">
								<div class="display-header text-uppercase text-dark text-center pb-3">
									<h2 class="display-7">Shop Our Insta</h2>
								</div>
								<div class="d-flex flex-wrap justify-content-center">
									<figure class="instagram-item pe-2">
										<img src="client/img/insta-item1.jpg" alt="instagram" class="insta-image">
									</figure>
									<figure class="instagram-item pe-2">
										<img src="client/img/insta-item2.jpg" alt="instagram" class="insta-image">
									</figure>
									<figure class="instagram-item pe-2">
										<img src="client/img/insta-item3.jpg" alt="instagram" class="insta-image">
									</figure>
									<figure class="instagram-item pe-2">
										<img src="client/img/insta-item4.jpg" alt="instagram" class="insta-image">
									</figure>
									<figure class="instagram-item pe-2">
										<img src="client/img/insta-item5.jpg" alt="instagram" class="insta-image">
									</figure>
								</div>
							</div>
						</div>
					</section>

					<jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>
					<jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>

					<script src="/client/js/cart.js"></script>
				</body>

				</html>