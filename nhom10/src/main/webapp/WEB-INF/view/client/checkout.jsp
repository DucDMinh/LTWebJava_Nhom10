<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
			<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

				<!DOCTYPE html>
				<html lang="vi">

				<head>
					<title>Thanh Toán | CellWorld</title>
					<meta charset="utf-8">
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>
				</head>

				<body>

					<jsp:include page="/WEB-INF/view/client/layout/header.jsp"></jsp:include>

					<section style="background: url(/client/img/banner.jpg) center 15%/cover no-repeat; height: 300px;">
						<div aria-label="breadcrumb" class="container"></div>
					</section>

					<section id="checkout" style="margin-bottom: 10%;">
						<div class="container">
							<h2 class="section-title" style="margin-top: 5%; margin-bottom: 5%; text-align: center;">
								Checkout</h2>

							<form:form action="/place-order" method="post" modelAttribute="cart" id="checkoutForm">

								<div class="row g-4 mx-auto" style="width: 100%;">

									<div class="col-lg-7">
										<div class="checkout-section">
											<h5 class="mb-4">Thông tin giao hàng</h5>

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
																	<th style="width: 50%;">Sản phẩm</th>
																	<th class="text-center">Đơn giá</th>
																	<th class="text-center">SL</th>
																	<th class="text-end">Thành tiền</th>
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
													<label class="form-label">Ghi chú đơn hàng (Tùy chọn)</label>
													<textarea name="note" class="form-control" rows="3"
														placeholder="Lưu ý cho người bán..."></textarea>
												</div>
											</div>
										</div>
									</div>

									<div class="col-lg-5">
										<div class="order-summary-card p-4 border rounded bg-light">
											<h5 class="mb-4">Đơn hàng của bạn</h5>

											<div class="summary-item d-flex justify-content-between mb-2">
												<span>Tạm tính:</span>
												<span class="fw-bold" id="subtotalDisplay"
													data-subtotal="${totalPrice}">
													<fmt:formatNumber value="${totalPrice}" /> ₫
												</span>
											</div>

											<div class="summary-item d-flex justify-content-between mb-2">
												<span>Phí vận chuyển:</span>
												<span class="text-success fw-bold" id="shippingFeeDisplay">11.000
													₫</span>
											</div>

											<div
												class="summary-total d-flex justify-content-between mt-3 pt-3 border-top">
												<span class="fs-5 fw-bold">Tổng cộng:</span>
												<span class="fs-5 fw-bold text-danger" id="totalDisplay">
													<fmt:formatNumber value="${totalPrice + 11000}" /> ₫
												</span>
											</div>

											<input type="hidden" id="hiddenShippingFee" name="shippingFee"
												value="11000" />
											<input type="hidden" id="hiddenTotalPrice" name="totalPrice"
												value="${totalPrice + 11000}" />

											<h5 class="mt-4 mb-3">Phương thức thanh toán</h5>

											<div class="form-check mb-2">
												<input class="form-check-input" type="radio" name="paymentMethod"
													value="COD" id="cod" checked />
												<label class="form-check-label" for="cod">Thanh toán khi nhận hàng
													(COD)</label>
											</div>
											<div class="form-check mb-4">
												<input class="form-check-input" type="radio" name="paymentMethod"
													value="VNPAY" id="vnpay" />
												<label class="form-check-label" for="vnpay">Thanh toán qua VNPAY</label>
											</div>

											<div style="display: none;">
												<c:forEach var="item" items="${cartDetails}" varStatus="status">
													<input type="hidden" name="cartDetails[${status.index}].id"
														value="${item.id}" />
													<input type="hidden" name="cartDetails[${status.index}].quantity"
														value="${item.quantity}" />
												</c:forEach>
											</div>

											<button type="submit"
												class="btn btn-dark w-100 py-3 text-uppercase fw-bold">
												Đặt Hàng
											</button>
										</div>
									</div>
								</div>
							</form:form>
						</div>
					</section>

					<jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>
					<jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>

					<script src="/client/js/checkout.js"></script>
				</body>

				</html>