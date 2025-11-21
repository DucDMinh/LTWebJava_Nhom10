<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="rating-summary mb-5">
    <h3 class="mb-4">Đánh giá sản phẩm</h3>

    <div class="row">
        <div class="col-md-4">
            <div class="rating-overview text-center p-4 bg-light rounded">
                <div class="rating-average fs-1 fw-bold text-primary">4.2</div>
                <div class="rating-stars d-flex justify-content-center mb-2">
                    <svg class="me-1" width="20" height="20" fill="currentColor">
                        <use xlink:href="#star-fill"></use>
                    </svg>
                    <svg class="me-1" width="20" height="20" fill="currentColor">
                        <use xlink:href="#star-fill"></use>
                    </svg>
                    <svg class="me-1" width="20" height="20" fill="currentColor">
                        <use xlink:href="#star-fill"></use>
                    </svg>
                    <svg class="me-1" width="20" height="20" fill="currentColor">
                        <use xlink:href="#star-fill"></use>
                    </svg>
                    <svg width="20" height="20" fill="currentColor">
                        <use xlink:href="#star-half"></use>
                    </svg>
                </div>
                <div class="rating-count text-muted">120 đánh giá</div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="rating-distribution">
                <div class="rating-row d-flex align-items-center mb-2">
                    <div class="rating-stars-count" style="width: 60px;">5 sao</div>
                    <div class="rating-progress flex-grow-1 me-3">
                        <div class="progress" style="height: 10px;">
                            <div class="progress-bar" role="progressbar" style="width: 60%;" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="rating-count" style="width: 40px; text-align: right;">72</div>
                </div>

                <div class="rating-row d-flex align-items-center mb-2">
                    <div class="rating-stars-count" style="width: 60px;">4 sao</div>
                    <div class="rating-progress flex-grow-1 me-3">
                        <div class="progress" style="height: 10px;">
                            <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="rating-count" style="width: 40px; text-align: right;">30</div>
                </div>

                <div class="rating-row d-flex align-items-center mb-2">
                    <div class="rating-stars-count" style="width: 60px;">3 sao</div>
                    <div class="rating-progress flex-grow-1 me-3">
                        <div class="progress" style="height: 10px;">
                            <div class="progress-bar" role="progressbar" style="width: 10%;" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="rating-count" style="width: 40px; text-align: right;">12</div>
                </div>

                <div class="rating-row d-flex align-items-center mb-2">
                    <div class="rating-stars-count" style="width: 60px;">2 sao</div>
                    <div class="rating-progress flex-grow-1 me-3">
                        <div class="progress" style="height: 10px;">
                            <div class="progress-bar" role="progressbar" style="width: 3%;" aria-valuenow="3" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="rating-count" style="width: 40px; text-align: right;">4</div>
                </div>

                <div class="rating-row d-flex align-items-center mb-2">
                    <div class="rating-stars-count" style="width: 60px;">1 sao</div>
                    <div class="rating-progress flex-grow-1 me-3">
                        <div class="progress" style="height: 10px;">
                            <div class="progress-bar" role="progressbar" style="width: 2%;" aria-valuenow="2" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="rating-count" style="width: 40px; text-align: right;">2</div>
                </div>
            </div>
        </div>
    </div>
</div>
