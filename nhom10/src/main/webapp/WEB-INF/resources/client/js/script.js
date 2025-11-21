(function ($) {
  "use strict";

  // --- 1. CÁC HÀM KHỞI TẠO GIAO DIỆN (UI) ---

  // Xử lý Popup Tìm kiếm
  var searchPopup = function () {
    $('#header-nav').on('click', '.search-button', function (e) {
      $('.search-popup').toggleClass('is-visible');
    });

    $('#header-nav').on('click', '.btn-close-search', function (e) {
      $('.search-popup').toggleClass('is-visible');
    });

    $(".search-popup-trigger").on("click", function (b) {
      b.preventDefault();
      $(".search-popup").addClass("is-visible");
      setTimeout(function () {
        $(".search-popup").find("#search-popup").focus();
      }, 350);
    });

    $(".search-popup").on("click", function (b) {
      if ($(b.target).is(".search-popup-close") || $(b.target).is(".search-popup-close svg") || $(b.target).is(".search-popup-close path") || $(b.target).is(".search-popup")) {
        b.preventDefault();
        $(this).removeClass("is-visible");
      }
    });

    $(document).keyup(function (b) {
      if ("27" === b.which) $(".search-popup").removeClass("is-visible");
    });
  };

  // Khởi tạo Carousel (Slider ảnh sản phẩm)
  var initProductCarousel = function () {
    var carousel = document.querySelector('#productCarousel');
    if (carousel) {
      var bsCarousel = new bootstrap.Carousel(carousel, {
        interval: false,
        wrap: true
      });

      $('.carousel-thumbnail').on('click', function () {
        $('.carousel-thumbnail').removeClass('active');
        $(this).addClass('active');
      });

      carousel.addEventListener('slide.bs.carousel', function (e) {
        $('.carousel-thumbnail').removeClass('active');
        $('.carousel-thumbnail').eq(e.to).addClass('active');
      });
    }
  };

  // Khởi tạo các Swiper Slider khác (Trang chủ, Testimonial...)
  var initSwipers = function () {
    new Swiper(".main-swiper", {
      speed: 500,
      navigation: {
        nextEl: ".swiper-arrow-prev",
        prevEl: ".swiper-arrow-next",
      },
    });

    new Swiper(".product-swiper", {
      slidesPerView: 4,
      spaceBetween: 10,
      pagination: {
        el: "#mobile-products .swiper-pagination",
        clickable: true,
      },
      breakpoints: {
        0: { slidesPerView: 2, spaceBetween: 20 },
        980: { slidesPerView: 4, spaceBetween: 20 }
      },
    });

    new Swiper(".product-watch-swiper", {
      slidesPerView: 4,
      spaceBetween: 10,
      pagination: {
        el: "#smart-watches .swiper-pagination",
        clickable: true,
      },
      breakpoints: {
        0: { slidesPerView: 2, spaceBetween: 20 },
        980: { slidesPerView: 4, spaceBetween: 20 }
      },
    });

    new Swiper(".testimonial-swiper", {
      loop: true,
      navigation: {
        nextEl: ".swiper-arrow-prev",
        prevEl: ".swiper-arrow-next",
      },
    });
  };

  // --- 2. LOGIC TĂNG GIẢM SỐ LƯỢNG GIỎ HÀNG (CORE LOGIC) ---

  var initCartQuantity = function () {
    // Xóa sự kiện cũ để tránh bị double click nếu gọi hàm này nhiều lần
    $('.quantity button').off('click').on('click', function (e) {
      // Ngăn chặn nút submit form mặc định
      e.preventDefault();

      const button = $(this);
      // Tìm input nằm cùng nhóm .quantity (dùng closest an toàn hơn parent)
      const inputVisible = button.closest('.quantity').find('input');

      let oldValue = parseFloat(inputVisible.val());
      let newVal = oldValue;

      // A. Tính toán số lượng mới
      if (button.find('.fa-plus').length > 0 || button.hasClass('btn-plus')) {
        // Nếu là nút cộng
        newVal = oldValue + 1;
      } else {
        // Nếu là nút trừ
        if (oldValue > 1) {
          newVal = oldValue - 1;
        } else {
          newVal = 1; // Không cho giảm dưới 1
        }
      }

      // B. Cập nhật giao diện
      inputVisible.val(newVal);

      // C. Cập nhật Input Ẩn (Để gửi về Server khi checkout)
      // Lấy index từ data-attribute của ô input
      const index = inputVisible.attr("data-cart-detail-index");
      // Tìm input ẩn có ID tương ứng (đã sửa trong cart.jsp)
      $(`#hidden-qty-${index}`).val(newVal);

      // D. Tính lại "Thành tiền" của dòng sản phẩm đó
      const price = parseFloat(inputVisible.attr("data-cart-detail-price"));
      const id = inputVisible.attr("data-cart-detail-id");
      const newRowTotal = price * newVal;

      // Tìm thẻ <p> hiển thị giá và update text
      $(`p[data-total-price-id='${id}']`).text(formatCurrency(newRowTotal) + " ₫");

      // E. Tính lại TỔNG TIỀN CẢ GIỎ HÀNG
      updateCartTotal();
    });
  };

  // Hàm tính tổng tiền toàn giỏ hàng
  function updateCartTotal() {
    let total = 0;
    // Duyệt qua tất cả các ô input số lượng để tính lại từ đầu
    $('.quantity input').each(function () {
      const qty = parseFloat($(this).val());
      const price = parseFloat($(this).attr("data-cart-detail-price"));
      total += (qty * price);
    });

    // Format tiền và hiển thị
    const formattedTotal = formatCurrency(total) + " ₫";
    $("#cart-subtotal").text(formattedTotal);
    $("#cart-total").text(formattedTotal);
  }

  // Hàm format tiền tệ Việt Nam
  function formatCurrency(value) {
    // Ví dụ: 1200000 => 1.200.000
    return new Intl.NumberFormat('vi-VN').format(value);
  }

  // Xử lý tăng giảm ở trang Chi tiết sản phẩm (Trang Detail)
  var initProductDetailQty = function () {
    // Nút cộng
    $('.quantity-input-group .btn-outline-secondary:last-child').on('click', function (e) {
      e.preventDefault();
      var input = $('#quantityInput');
      var val = parseInt(input.val()) || 1;
      if (val < 10) input.val(val + 1); // Max 10
    });

    // Nút trừ
    $('.quantity-input-group .btn-outline-secondary:first-child').on('click', function (e) {
      e.preventDefault();
      var input = $('#quantityInput');
      var val = parseInt(input.val()) || 1;
      if (val > 1) input.val(val - 1);
    });
  }


  // --- 3. KHỞI CHẠY KHI DOM READY ---
  $(document).ready(function () {

    searchPopup();
    initProductCarousel();
    initSwipers();

    // Gọi logic giỏ hàng
    initCartQuantity();
    initProductDetailQty();

    // Các logic phụ khác (Storage, Color options...)
    $('.storage-options .btn-group button').on('click', function () {
      $('.storage-options .btn-group button').removeClass('active');
      $(this).addClass('active');
    });

    $('.product-options .rounded-circle').on('click', function () {
      $('.product-options .rounded-circle').removeClass('active');
      $(this).addClass('active');
    });

  });

})(jQuery);