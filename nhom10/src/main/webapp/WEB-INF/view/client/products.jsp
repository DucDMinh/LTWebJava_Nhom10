<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
			<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
			<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

				<!DOCTYPE html>
				<html>

				<head>
					<title>CellWorld - Products</title>
					<meta charset="utf-8">
					<meta http-equiv="X-UA-Compatible" content="IE=edge">
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<meta name="format-detection" content="telephone=no">
					<meta name="apple-mobile-web-app-capable" content="yes">
					<meta name="author" content="">
					<meta name="keywords" content="">
					<meta name="description" content="">
					<jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>
          <style>
            .accordion-button:not(.collapsed) {
                background-color: transparent !important;
                color: inherit !important;
                box-shadow: none !important;
            }

            .accordion-button {
                background-color: transparent !important;
                box-shadow: none !important;
                padding-left: 0;
                padding-right: 0;
            }

            .accordion-item {
                border: none !important;
                background-color: transparent !important;
            }
          </style>

				</head>

				<body data-bs-spy="scroll" data-bs-target="#navbar" data-bs-root-margin="0px 0px -40%"
					data-bs-smooth-scroll="true" tabindex="0">
					<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
						<symbol id="search" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
							<title>Search</title>
							<path fill="currentColor"
								d="M19 3C13.488 3 9 7.488 9 13c0 2.395.84 4.59 2.25 6.313L3.281 27.28l1.439 1.44l7.968-7.969A9.922 9.922 0 0 0 19 23c5.512 0 10-4.488 10-10S24.512 3 19 3zm0 2c4.43 0 8 3.57 8 8s-3.57 8-8 8s-8-3.57-8-8s3.57-8 8-8z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="user" viewBox="0 0 16 16">
							<path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3Zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="cart" viewBox="0 0 16 16">
							<path
								d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
						</symbol>
						<svg xmlns="http://www.w3.org/2000/svg" id="chevron-left" viewBox="0 0 16 16">
							<path fill-rule="evenodd"
								d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z" />
						</svg>
						<symbol xmlns="http://www.w3.org/2000/svg" id="chevron-right" viewBox="0 0 16 16">
							<path fill-rule="evenodd"
								d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="cart-outline" viewBox="0 0 16 16">
							<path
								d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="quality" viewBox="0 0 16 16">
							<path
								d="M9.669.864 8 0 6.331.864l-1.858.282-.842 1.68-1.337 1.32L2.6 6l-.306 1.854 1.337 1.32.842 1.68 1.858.282L8 12l1.669-.864 1.858-.282.842-1.68 1.337-1.32L13.4 6l.306-1.854-1.337-1.32-.842-1.68L9.669.864zm1.196 1.193.684 1.365 1.086 1.072L12.387 6l.248 1.506-1.086 1.072-.684 1.365-1.51.229L8 10.874l-1.355-.702-1.51-.229-.684-1.365-1.086-1.072L3.614 6l-.25-1.506 1.087-1.072.684-1.365 1.51-.229L8 1.126l1.356.702 1.509.229z" />
							<path d="M4 11.794V16l4-1 4 1v-4.206l-2.018.306L8 13.126 6.018 12.1 4 11.794z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="price-tag" viewBox="0 0 16 16">
							<path d="M6 4.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm-1 0a.5.5 0 1 0-1 0 .5.5 0 0 0 1 0z" />
							<path
								d="M2 1h4.586a1 1 0 0 1 .707.293l7 7a1 1 0 0 1 0 1.414l-4.586 4.586a1 1 0 0 1-1.414 0l-7-7A1 1 0 0 1 1 6.586V2a1 1 0 0 1 1-1zm0 5.586 7 7L13.586 9l-7-7H2v4.586z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="shield-plus" viewBox="0 0 16 16">
							<path
								d="M5.338 1.59a61.44 61.44 0 0 0-2.837.856.481.481 0 0 0-.328.39c-.554 4.157.726 7.19 2.253 9.188a10.725 10.725 0 0 0 2.287 2.233c.346.244.652.42.893.533.12.057.218.095.293.118a.55.55 0 0 0 .101.025.615.615 0 0 0 .1-.025c.076-.023.174-.061.294-.118.24-.113.547-.29.893-.533a10.726 10.726 0 0 0 2.287-2.233c1.527-1.997 2.807-5.031 2.253-9.188a.48.48 0 0 0-.328-.39c-.651-.213-1.75-.56-2.837-.855C9.552 1.29 8.531 1.067 8 1.067c-.53 0-1.552.223-2.662.524zM5.072.56C6.157.265 7.31 0 8 0s1.843.265 2.928.56c1.11.3 2.229.655 2.887.87a1.54 1.54 0 0 1 1.044 1.262c.596 4.477-.787 7.795-2.465 9.99a11.775 11.775 0 0 1-2.517 2.453 7.159 7.159 0 0 1-1.048.625c-.28.132-.581.24-.829.24s-.548-.108-.829-.24a7.158 7.158 0 0 1-1.048-.625 11.777 11.777 0 0 1-2.517-2.453C1.928 10.487.545 7.169 1.141 2.692A1.54 1.54 0 0 1 2.185 1.43 62.456 62.456 0 0 1 5.072.56z" />
							<path
								d="M8 4.5a.5.5 0 0 1 .5.5v1.5H10a.5.5 0 0 1 0 1H8.5V9a.5.5 0 0 1-1 0V7.5H6a.5.5 0 0 1 0-1h1.5V5a.5.5 0 0 1 .5-.5z" />
						</symbol>
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
						<symbol xmlns="http://www.w3.org/2000/svg" id="quote" viewBox="0 0 24 24">
							<path fill="currentColor" d="m15 17l2-4h-4V6h7v7l-2 4h-3Zm-9 0l2-4H4V6h7v7l-2 4H6Z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="facebook" viewBox="0 0 24 24">
							<path fill="currentColor"
								d="M9.198 21.5h4v-8.01h3.604l.396-3.98h-4V7.5a1 1 0 0 1 1-1h3v-4h-3a5 5 0 0 0-5 5v2.01h-2l-.396 3.98h2.396v8.01Z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="youtube" viewBox="0 0 32 32">
							<path fill="currentColor"
								d="M29.41 9.26a3.5 3.5 0 0 0-2.47-2.47C24.76 6.2 16 6.2 16 6.2s-8.76 0-10.94.59a3.5 3.5 0 0 0-2.47 2.47A36.13 36.13 0 0 0 2 16a36.13 36.13 0 0 0 .59 6.74a3.5 3.5 0 0 0 2.47 2.47c2.18.59 10.94.59 10.94.59s8.76 0 10.94-.59a3.5 3.5 0 0 0 2.47-2.47A36.13 36.13 0 0 0 30 16a36.13 36.13 0 0 0-.59-6.74ZM13.2 20.2v-8.4l7.27 4.2Z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="twitter" viewBox="0 0 256 256">
							<path fill="currentColor"
								d="m245.66 77.66l-29.9 29.9C209.72 177.58 150.67 232 80 232c-14.52 0-26.49-2.3-35.58-6.84c-7.33-3.67-10.33-7.6-11.08-8.72a8 8 0 0 1 3.85-11.93c.26-.1 24.24-9.31 39.47-26.84a110.93 110.93 0 0 1-21.88-24.2c-12.4-18.41-26.28-50.39-22-98.18a8 8 0 0 1 13.65-4.92c.35.35 33.28 33.1 73.54 43.72V88a47.87 47.87 0 0 1 14.36-34.3A46.87 46.87 0 0 1 168.1 40a48.66 48.66 0 0 1 41.47 24H240a8 8 0 0 1 5.66 13.66Z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="instagram" viewBox="0 0 256 256">
							<path fill="currentColor"
								d="M128 80a48 48 0 1 0 48 48a48.05 48.05 0 0 0-48-48Zm0 80a32 32 0 1 1 32-32a32 32 0 0 1-32 32Zm48-136H80a56.06 56.06 0 0 0-56 56v96a56.06 56.06 0 0 0 56 56h96a56.06 56.06 0 0 0 56-56V80a56.06 56.06 0 0 0-56-56Zm40 152a40 40 0 0 1-40 40H80a40 40 0 0 1-40-40V80a40 40 0 0 1 40-40h96a40 40 0 0 1 40 40ZM192 76a12 12 0 1 1-12-12a12 12 0 0 1 12 12Z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="linkedin" viewBox="0 0 24 24">
							<path fill="currentColor"
								d="M6.94 5a2 2 0 1 1-4-.002a2 2 0 0 1 4 .002zM7 8.48H3V21h4V8.48zm6.32 0H9.34V21h3.94v-6.57c0-3.66 4.77-4 4.77 0V21H22v-7.93c0-6.17-7.06-5.94-8.72-2.91l.04-1.68z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="nav-icon" viewBox="0 0 16 16">
							<path
								d="M14 10.5a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 .5-.5zm0-3a.5.5 0 0 0-.5-.5h-7a.5.5 0 0 0 0 1h7a.5.5 0 0 0 .5-.5zm0-3a.5.5 0 0 0-.5-.5h-11a.5.5 0 0 0 0 1h11a.5.5 0 0 0 .5-.5z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="close" viewBox="0 0 16 16">
							<path
								d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z" />
						</symbol>
						<symbol xmlns="http://www.w3.org/2000/svg" id="navbar-icon" viewBox="0 0 16 16">
							<path
								d="M14 10.5a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 .5-.5zm0-3a.5.5 0 0 0-.5-.5h-7a.5.5 0 0 0 0 1h7a.5.5 0 0 0 .5-.5zm0-3a.5.5 0 0 0-.5-.5h-11a.5.5 0 0 0 0 1h11a.5.5 0 0 0 .5-.5z" />
						</symbol>
					</svg>


					<jsp:include page="/WEB-INF/view/client/layout/header.jsp"></jsp:include>

					<section id="products-page" class="position-relative overflow-hidden bg-light-blue padding-large">
						<div class="container">
							<div class="row">
								<!-- Filter Sidebar -->
								<div class="col-lg-3 col-md-4">
									<div class="filter-sidebar bg-white p-4 rounded shadow-sm mb-4">
										<h3 class="fs-5 mb-3">Lọc Sản Phẩm</h3>

										<form id="searchForm" method="GET" action="/products" class="mb-4">
											<div class="input-group">
												<input type="text" class="form-control" placeholder="Tìm kiếm..."
													name="search" value="${search}" id="searchInput">
                        <button class="btn btn-outline-secondary" type="button" onclick="filterProducts(0)">
                            <svg class="search" width="20" height="20" style="fill: currentColor;">
                                <use xlink:href="#search" />
                            </svg>
                        </button>
											</div>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</form>

										<div class="accordion accordion-flush" id="filterAccordion">

											<div class="accordion-item">
												<h2 class="accordion-header" id="headingCategory">
													<button class="accordion-button" type="button" data-bs-toggle="collapse"
															data-bs-target="#collapseCategory" aria-expanded="true" aria-controls="collapseCategory">
														Danh Mục
													</button>
												</h2>
												<div id="collapseCategory" class="accordion-collapse collapse show" aria-labelledby="headingCategory">
													<div class="accordion-body">
														<div class="form-check">
															<input class="form-check-input" type="checkbox" id="allCategory"
																${empty param.category ? 'checked' : ''}
																onchange="toggleAll('category', this.checked)">
															<label class="form-check-label" for="allCategory">Tất cả</label>
														</div>
														<c:forEach var="cat" items="${categories}">
															<div class="form-check">
																<input class="form-check-input" type="checkbox" name="category"
																	   value="${cat}" id="cat_${cat}"
																	   ${fn:contains(fn:join(paramValues.category, ','), cat) ? 'checked' : ''}
																	   onchange="onFilterChange('category')">
																<label class="form-check-label" for="cat_${cat}">${cat}</label>
															</div>
														</c:forEach>
													</div>
												</div>
											</div>

											<div class="accordion-item">
												<h2 class="accordion-header" id="headingFactory">
													<button class="accordion-button" type="button" data-bs-toggle="collapse"
															data-bs-target="#collapseFactory" aria-expanded="true" aria-controls="collapseFactory">
														Thương Hiệu
													</button>
												</h2>
												<div id="collapseFactory" class="accordion-collapse collapse show" aria-labelledby="headingFactory">
													<div class="accordion-body">
														<div class="form-check">
															<input class="form-check-input" type="checkbox" id="allFactory"
																${empty param.factory ? 'checked' : ''}
																onchange="toggleAll('factory', this.checked)">
															<label class="form-check-label" for="allFactory">Tất cả</label>
														</div>
														<c:forEach var="fact" items="${factories}">
															<div class="form-check">
																<input class="form-check-input" type="checkbox" name="factory"
																	   value="${fact}" id="fact_${fact}"
																	   ${fn:contains(fn:join(paramValues.factory, ','), fact) ? 'checked' : ''}
																	   onchange="onFilterChange('factory')">
																<label class="form-check-label" for="fact_${fact}">${fact}</label>
															</div>
														</c:forEach>
													</div>
												</div>
											</div>

											<div class="accordion-item">
												<h2 class="accordion-header" id="headingPrice">
													<button class="accordion-button" type="button" data-bs-toggle="collapse"
															data-bs-target="#collapsePrice" aria-expanded="true" aria-controls="collapsePrice">
														Mức giá
													</button>
												</h2>
												<div id="collapsePrice" class="accordion-collapse collapse show" aria-labelledby="headingPrice">
													<div class="accordion-body">
														<div class="form-check">
															<input class="form-check-input" type="checkbox" id="allPrice"
																checked onchange="toggleAll('price', this.checked)">
															<label class="form-check-label" for="allPrice">Tất cả</label>
														</div>

														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="priceRange" value="0-2000000" id="price_2m"
																onchange="handleRangeFilter('price', '0-2000000', this.checked)">
															<label class="form-check-label" for="price_2m">Dưới 2 triệu</label>
														</div>
														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="priceRange" value="2000000-4000000" id="price_2_4m" onchange="handleRangeFilter('price', '2000000-4000000', this.checked)">
															<label class="form-check-label" for="price_2_4m">Từ 2 - 4 triệu</label>
														</div>
														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="priceRange" value="4000000-7000000" id="price_4_7m" onchange="handleRangeFilter('price', '4000000-7000000', this.checked)">
															<label class="form-check-label" for="price_4_7m">Từ 4 - 7 triệu</label>
														</div>
														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="priceRange" value="7000000-13000000" id="price_7_13m" onchange="handleRangeFilter('price', '7000000-13000000', this.checked)">
															<label class="form-check-label" for="price_7_13m">Từ 7 - 13 triệu</label>
														</div>
														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="priceRange" value="13000000-20000000" id="price_13_20m" onchange="handleRangeFilter('price', '13000000-20000000', this.checked)">
															<label class="form-check-label" for="price_13_20m">Từ 13 - 20 triệu</label>
														</div>
														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="priceRange" value="20000000-999999999" id="price_20m" onchange="handleRangeFilter('price', '20000000-999999999', this.checked)">
															<label class="form-check-label" for="price_20m">Trên 20 triệu</label>
														</div>
														<div class="mt-3">
															<div class="input-group">
																<span class="input-group-text">Từ</span>
																<input type="number" class="form-control" placeholder="0"
																	name="minPrice" id="minPriceInput"
																	value="${minPrice}" onchange="filterProducts()">
																<span class="input-group-text">₫</span>
															</div>
															<div class="input-group mt-2">
																<span class="input-group-text">Đến</span>
																<input type="number" class="form-control" placeholder="999999999"
																	name="maxPrice" id="maxPriceInput"
																	value="${maxPrice}" onchange="filterProducts()">
																<span class="input-group-text">₫</span>
															</div>
														</div>
													</div>
												</div>
											</div>

											<div class="accordion-item">
												<h2 class="accordion-header" id="headingScreen">
													<button class="accordion-button" type="button" data-bs-toggle="collapse"
															data-bs-target="#collapseScreen" aria-expanded="true" aria-controls="collapseScreen">
														Màn hình
													</button>
												</h2>
												<div id="collapseScreen" class="accordion-collapse collapse show" aria-labelledby="headingScreen">
													<div class="accordion-body">
														<div class="form-check">
															<input class="form-check-input" type="checkbox" id="allScreen"
																checked onchange="toggleAll('screen', this.checked)">
															<label class="form-check-label" for="allScreen">Tất cả</label>
														</div>
														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="screenSizeRange" value="0-5" id="screen_small" onchange="handleRangeFilter('screen', '0-5', this.checked)">
															<label class="form-check-label" for="screen_small">Màn hình nhỏ</label>
														</div>
														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="screenSizeRange" value="5-6.5" id="screen_5_65" onchange="handleRangeFilter('screen', '5-6.5', this.checked)">
															<label class="form-check-label" for="screen_5_65">Từ 5 - 6.5 inch</label>
														</div>
														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="screenSizeRange" value="6.5-6.8" id="screen_65_68" onchange="handleRangeFilter('screen', '6.5-6.8', this.checked)">
															<label class="form-check-label" for="screen_65_68">Từ 6.5 - 6.8 inch</label>
														</div>
														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="screenSizeRange" value="6.8-99" id="screen_large" onchange="handleRangeFilter('screen', '6.8-99', this.checked)">
															<label class="form-check-label" for="screen_large">Trên 6.8 inch</label>
														</div>
														<!-- Hidden inputs for actual screen size values -->
														<input type="hidden" name="minScreenSize" id="minScreenSizeInput" value="${minScreenSize}">
														<input type="hidden" name="maxScreenSize" id="maxScreenSizeInput" value="${maxScreenSize}">
													</div>
												</div>
											</div>

											<div class="accordion-item">
												<h2 class="accordion-header" id="headingOS">
													<button class="accordion-button" type="button" data-bs-toggle="collapse"
															data-bs-target="#collapseOS" aria-expanded="true" aria-controls="collapseOS">
														Hệ điều hành
													</button>
												</h2>
												<div id="collapseOS" class="accordion-collapse collapse show" aria-labelledby="headingOS">
													<div class="accordion-body">
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('os', 'iOS', this)">iOS</button>
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('os', 'Android', this)">Android</button>
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('os', 'Windows', this)">Windows</button>
														<input type="hidden" name="os" id="osInput" value="${os}">
													</div>
												</div>
											</div>

											<div class="accordion-item">
												<h2 class="accordion-header" id="headingRAM">
													<button class="accordion-button" type="button" data-bs-toggle="collapse"
															data-bs-target="#collapseRAM" aria-expanded="true" aria-controls="collapseRAM">
														RAM
													</button>
												</h2>
												<div id="collapseRAM" class="accordion-collapse collapse show" aria-labelledby="headingRAM">
													<div class="accordion-body">
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('ram', '4GB', this)">4GB</button>
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('ram', '6GB', this)">6GB</button>
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('ram', '8GB', this)">8GB</button>
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('ram', '16GB', this)">16GB</button>
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('ram', '32GB', this)">32GB</button>
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('ram', '64GB', this)">64GB</button>
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('ram', '128GB', this)">128GB+</button>
														<input type="hidden" name="ram" id="ramInput" value="${ram}">
													</div>
												</div>
											</div>

											<div class="accordion-item">
												<h2 class="accordion-header" id="headingStorage">
													<button class="accordion-button" type="button" data-bs-toggle="collapse"
															data-bs-target="#collapseStorage" aria-expanded="true" aria-controls="collapseStorage">
														Bộ nhớ
													</button>
												</h2>
												<div id="collapseStorage" class="accordion-collapse collapse show" aria-labelledby="headingStorage">
													<div class="accordion-body">
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('storage', '32GB', this)">32GB</button>
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('storage', '64GB', this)">64GB</button>
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('storage', '128GB', this)">128GB</button>
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('storage', '256GB', this)">256GB</button>
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('storage', '512GB', this)">512GB</button>
														<button type="button" class="btn btn-outline-secondary btn-sm me-2 mb-2" onclick="toggleButtonFilter('storage', '1TB', this)">1TB</button>
														<input type="hidden" name="storage" id="storageInput" value="${storage}">
													</div>
												</div>
											</div>

											<div class="accordion-item">
												<h2 class="accordion-header" id="headingBattery">
													<button class="accordion-button" type="button" data-bs-toggle="collapse"
															data-bs-target="#collapseBattery" aria-expanded="true" aria-controls="collapseBattery">
														Dung lượng Pin
													</button>
												</h2>
												<div id="collapseBattery" class="accordion-collapse collapse show" aria-labelledby="headingBattery">
													<div class="accordion-body">
														<div class="form-check">
															<input class="form-check-input" type="checkbox" id="allBattery"
																checked onchange="toggleAll('battery', this.checked)">
															<label class="form-check-label" for="allBattery">
																Tất cả
															</label>
														</div>
														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="batteryRange" value="Dưới 3000" id="battery_under3000" onchange="handleRangeFilter('battery', 'Dưới 3000', this.checked)">
															<label class="form-check-label" for="battery_under3000">Dưới 3000 mAh</label>
														</div>
														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="batteryRange" value="3000-4000" id="battery_3000_4000" onchange="handleRangeFilter('battery', '3000-4000', this.checked)">
															<label class="form-check-label" for="battery_3000_4000">Pin từ 3000 - 4000 mAh</label>
														</div>
														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="batteryRange" value="4000-5500" id="battery_4000_5500" onchange="handleRangeFilter('battery', '4000-5500', this.checked)">
															<label class="form-check-label" for="battery_4000_5500">Pin từ 4000 - 5500 mAh</label>
														</div>
														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="batteryRange" value="Trên 5500" id="battery_over5500" onchange="handleRangeFilter('battery', 'Trên 5500', this.checked)">
															<label class="form-check-label" for="battery_over5500">Pin trâu: trên 5500 mAh</label>
														</div>
														<div class="mt-3">
															<div class="input-group">
																<span class="input-group-text">Từ</span>
																<input type="number" class="form-control" placeholder="0"
																	name="minPin" id="minPinInput"
																	value="${minPin}" onchange="onManualRangeChange('battery')">
																<span class="input-group-text">mAh</span>
															</div>
															<div class="input-group mt-2">
																<span class="input-group-text">Đến</span>
																<input type="number" class="form-control" placeholder="999999"
																	name="maxPin" id="maxPinInput"
																	value="${maxPin}" onchange="onManualRangeChange('battery')">
																<span class="input-group-text">mAh</span>
															</div>
														</div>
													</div>
												</div>
											</div>

										</div>
									</div>
								</div>

								<!-- Product Grid -->
								<div class="col-lg-9 col-md-8">
									<div class="d-flex justify-content-between align-items-center mb-3">
										<h2 class="fs-4 mb-0">Danh Sách Sản Phẩm</h2>
										<div class="results-count text-muted small">
											${totalItems} sản phẩm
										</div>
									</div>

									<div class="row g-4">
										<c:forEach var="product" items="${products}">
											<div class="col-md-6 col-lg-4 col-xl-3">
												<div class="card h-100 shadow-sm border-0">
													<span class="badge bg-danger position-absolute top-0 end-0 m-2"
														style="z-index: 2;">
														Hot
													</span>
													<a href="/product/${product.id}">
														<img src="/images/product/${product.image}"
															class="card-img-top" alt="${product.name}">
													</a>

													<div class="card-body text-center d-flex flex-column">

														<h5 class="card-title fs-6">
															<a href="/product/${product.id}"
																class="text-decoration-none text-dark">
																${product.name}
															</a>
														</h5>

														<p class="card-text text-muted small mb-2">
															${product.shortDesc}
														</p>

														<p class="fs-5 fw-bold text-primary mb-3">
															<fmt:formatNumber type="number"
																value="${product.price}" /> $
														</p>

														<form action="/add-product-to-cart/${product.id}"
															method="post" class="mt-auto">
															<button
																class="btn btn-outline-primary rounded-pill px-3 w-100 btn-sm">
																<i class="fa fa-shopping-bag me-2"></i>
																<span class="small">Thêm vào giỏ hàng</span>
															</button>
															<input type="hidden" name="${_csrf.parameterName}"
																value="${_csrf.token}" />
														</form>

													</div>
												</div>
											</div>
										</c:forEach>

										<c:if test="${empty products}">
											<div class="col-12 text-center">
												<div class="alert alert-info">
													Không tìm thấy sản phẩm phù hợp với tiêu chí lọc của bạn.
												</div>
											</div>
										</c:if>
									</div>

									<!-- Pagination Controls -->
									<c:if test="${totalPages > 1}">
										<nav aria-label="Page navigation" class="mt-4">
											<ul class="pagination justify-content-center">
												<!-- Previous button -->
												<li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
													<a class="page-link" href="javascript:void(0)" onclick="filterProducts(${currentPage - 1})">
														Previous
													</a>
												</li>

												<!-- Page numbers -->
												<c:forEach begin="0" end="${totalPages - 1}" var="i">
													<li class="page-item ${currentPage == i ? 'active' : ''}">
														<a class="page-link" href="javascript:void(0)" onclick="filterProducts(${i})">
															${i + 1}
														</a>
													</li>
												</c:forEach>

												<!-- Next button -->
												<li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
													<a class="page-link" href="javascript:void(0)" onclick="filterProducts(${currentPage + 1})">
														Next
													</a>
												</li>
											</ul>
										</nav>

										<div class="text-center mt-2">
											<small class="text-muted">
												Page ${currentPage + 1} of ${totalPages} (Total ${totalItems} products)
											</small>
										</div>
									</c:if>
								</div>
							</div>
						</div>
					</section>

					<jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>

					<jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>

				</body>

				</html>
