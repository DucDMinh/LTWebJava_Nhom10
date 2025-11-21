(function ($) {


  "use strict";

  var searchPopup = function () {
    // open search box
    $('#header-nav').on('click', '.search-button', function (e) {
      $('.search-popup').toggleClass('is-visible');
    });

    $('#header-nav').on('click', '.btn-close-search', function (e) {
      $('.search-popup').toggleClass('is-visible');
    });

    $(".search-popup-trigger").on("click", function (b) {
      b.preventDefault();
      $(".search-popup").addClass("is-visible"),
        setTimeout(function () {
          $(".search-popup").find("#search-popup").focus()
        }, 350)
    }),
      $(".search-popup").on("click", function (b) {
        ($(b.target).is(".search-popup-close") || $(b.target).is(".search-popup-close svg") || $(b.target).is(".search-popup-close path") || $(b.target).is(".search-popup")) && (b.preventDefault(),

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

      $(".search-popup-trigger").on("click", function(b) {
          b.preventDefault();
          $(".search-popup").addClass("is-visible"),
          setTimeout(function() {
              $(".search-popup").find("#search-popup").focus()
          }, 350)
      }),
      $(".search-popup").on("click", function(b) {
          ($(b.target).is(".search-popup-close") || $(b.target).is(".search-popup-close svg") || $(b.target).is(".search-popup-close path") || $(b.target).is(".search-popup")) && (b.preventDefault(),

          $(this).removeClass("is-visible"))
      }),
      $(document).keyup(function (b) {
        "27" === b.which && $(".search-popup").removeClass("is-visible")
      })

  }

  var initProductQty = function () {

    $('.product-qty').each(function () {

      var $el_product = $(this);
      var quantity = 0;

      $el_product.find('.quantity-right-plus').click(function (e) {
        e.preventDefault();
        var quantity = parseInt($el_product.find('#quantity').val());
        $el_product.find('#quantity').val(quantity + 1);
      });

      $el_product.find('.quantity-left-minus').click(function (e) {
        e.preventDefault();
        var quantity = parseInt($el_product.find('#quantity').val());
        if (quantity > 0) {
          $el_product.find('#quantity').val(quantity - 1);
        }
      });

    });

  }

  var initStorageOptions = function () {
    $('.storage-options .btn-group button').on('click', function () {
      $('.storage-options .btn-group button').removeClass('active');
      $(this).addClass('active');
    });
  }

  var initColorOptions = function () {
    $('.product-options .rounded-circle').on('click', function () {
      $('.product-options .rounded-circle').removeClass('active');
      $(this).addClass('active');
    });
  }

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
  }

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


  var initProductDetailQty = function () {
    $('#button-plus').on('click', function (e) {
      e.preventDefault();
      var quantity = parseInt($('#quantityInput').val()) || 1;
      $('#quantityInput').val(quantity + 1);
    });

    $('#button-minus').on('click', function (e) {
      e.preventDefault();
      var quantity = parseInt($('#quantityInput').val()) || 1;
      if (quantity > 1) {
        $('#quantityInput').val(quantity - 1);
      }
    });
  }

  $(document).ready(function () {

    searchPopup();
    initProductQty();
    initStorageOptions();
    initColorOptions();
    initProductCarousel();
    initProductDetailQty();

    var swiper = new Swiper(".main-swiper", {
      speed: 500,
      navigation: {
        nextEl: ".swiper-arrow-prev",
        prevEl: ".swiper-arrow-next",
      },
    });


    var swiper = new Swiper(".product-swiper", {
      slidesPerView: 4,
      spaceBetween: 10,
      pagination: {
        el: "#mobile-products .swiper-pagination",
        clickable: true,
      },
      breakpoints: {
        0: {
          slidesPerView: 2,
          spaceBetween: 20,
        },
        980: {
          slidesPerView: 4,
          spaceBetween: 20,
        }
      },
    });

      var swiper = new Swiper(".main-swiper", {
        speed: 500,
        navigation: {
          nextEl: ".swiper-arrow-prev",
          prevEl: ".swiper-arrow-next",
        },
      });

      var swiper = new Swiper(".product-swiper", {
        slidesPerView: 4,
        spaceBetween: 10,
        pagination: {
          el: "#mobile-products .swiper-pagination",
          clickable: true,
        },
        breakpoints: {
          0: {
            slidesPerView: 2,
            spaceBetween: 20,
          },
          980: {
            slidesPerView: 4,
            spaceBetween: 20,
          }
        },
      });

      var swiper = new Swiper(".product-watch-swiper", {
        slidesPerView: 4,
        spaceBetween: 10,
        pagination: {
          el: "#smart-watches .swiper-pagination",
          clickable: true,
        },
        breakpoints: {
          0: {
            slidesPerView: 2,
            spaceBetween: 20,
          },
          980: {
            slidesPerView: 4,
            spaceBetween: 20,
          }
        },
      });


    var swiper = new Swiper(".product-watch-swiper", {
      slidesPerView: 4,
      spaceBetween: 10,
      pagination: {
        el: "#smart-watches .swiper-pagination",
        clickable: true,
      },
      breakpoints: {
        0: {
          slidesPerView: 2,
          spaceBetween: 20,
        },

        980: {
          slidesPerView: 4,
          spaceBetween: 20,
        }
      },
    });

      });


    var swiper = new Swiper(".testimonial-swiper", {
      loop: true,
      navigation: {
        nextEl: ".swiper-arrow-prev",
        prevEl: ".swiper-arrow-next",
      },
    });

  }); // End of a document ready

})(jQuery);

function formatUSD(x) {
  return '$' + x.toLocaleString('en-US');
}

function initCart() {

  const tbody = document.getElementById('cart-items');
  if (!tbody) return; // Exit if cart table doesn't exist

  const rows = Array.from(tbody.querySelectorAll('tr'));

  function updateSummary() {
    let subtotal = 0;
    rows.forEach(r => {
      const qty = parseInt(r.querySelector('.qty-value').textContent);
      const price = parseInt(r.dataset.price);
      subtotal += qty * price;
      r.querySelector('.subtotal').textContent = formatUSD(qty * price);
      r.querySelector('.qty-decrease').disabled = qty <= 1;
    });
    document.getElementById('summary-subtotal').textContent = formatUSD(subtotal);
    document.getElementById('summary-total').textContent = formatUSD(subtotal);
  }

  rows.forEach(r => {
    const btnDecrease = r.querySelector('.qty-decrease');
    const btnIncrease = r.querySelector('.qty-increase');
    const btnRemove = r.querySelector('.remove-btn');

    btnDecrease.addEventListener('click', () => {
      const qtyElem = r.querySelector('.qty-value');
      let qty = parseInt(qtyElem.textContent);
      if (qty > 1) qty--;
      qtyElem.textContent = qty;
      updateSummary();
    });

    btnIncrease.addEventListener('click', () => {
      const qtyElem = r.querySelector('.qty-value');
      let qty = parseInt(qtyElem.textContent);
      qty++;
      qtyElem.textContent = qty;
      updateSummary();

    const tbody = document.getElementById('cart-items');
    if (!tbody) return; // Exit if cart table doesn't exist

    const rows = Array.from(tbody.querySelectorAll('tr'));

    function updateSummary() {
        let subtotal = 0;
        rows.forEach(r => {
            const qty = parseInt(r.querySelector('.qty-value').textContent);
            const price = parseInt(r.dataset.price);
            subtotal += qty * price;
            r.querySelector('.subtotal').textContent = formatUSD(qty * price);
            r.querySelector('.qty-decrease').disabled = qty <= 1;
        });
        document.getElementById('summary-subtotal').textContent = formatUSD(subtotal);
        document.getElementById('summary-total').textContent = formatUSD(subtotal);
    }

    // Gọi logic giỏ hàng
    initCartQuantity();
    initProductDetailQty();

    // Các logic phụ khác (Storage, Color options...)
    $('.storage-options .btn-group button').on('click', function () {
      $('.storage-options .btn-group button').removeClass('active');
      $(this).addClass('active');

    });

    btnRemove.addEventListener('click', () => {
      r.remove();
      rows.splice(rows.indexOf(r), 1);
      updateSummary();
    });
  });

  updateSummary();
}

initCart();

document.addEventListener("DOMContentLoaded", () => {

  const container = document.getElementById("orderItems");
  const subtotalEl = document.getElementById("subtotal");
  const totalEl = document.getElementById("total");
  const toast = document.getElementById("orderToast");
  const orderBtn = document.getElementById("placeOrder");
  const cart = JSON.parse(localStorage.getItem("cart")) || [
    { name: "Ớt chuông xanh", price: 14000, quantity: 5, img: "./Img/Green-Capsicum.png" },
    { name: "Ớt chuông đỏ", price: 14000, quantity: 1, img: "./Img/Red-Capsicum.png" },
  ];

  if (container) {
    function renderOrderItems() {
      container.innerHTML = "";
      let subtotal = 0;

      cart.forEach(item => {
        const itemTotal = item.price * item.quantity;
        subtotal += itemTotal;

        const div = document.createElement("div");
        div.classList.add("summary-item");
        div.innerHTML = `

    const container = document.getElementById("orderItems");
    const subtotalEl = document.getElementById("subtotal");
    const totalEl = document.getElementById("total");
    const toast = document.getElementById("orderToast");
    const orderBtn = document.getElementById("placeOrder");
    const cart = JSON.parse(localStorage.getItem("cart")) || [
        { name: "Ớt chuông xanh", price: 14000, quantity: 5, img: "./Img/Green-Capsicum.png" },
        { name: "Ớt chuông đỏ", price: 14000, quantity: 1, img: "./Img/Red-Capsicum.png" },
    ];

    if (container) {
        function renderOrderItems() {
            container.innerHTML = "";
            let subtotal = 0;

            cart.forEach(item => {
                const itemTotal = item.price * item.quantity;
                subtotal += itemTotal;

                const div = document.createElement("div");
                div.classList.add("summary-item");
                div.innerHTML = `

            <div class="product-summary">
              <img src="${item.img}" alt="${item.name}" />
              <span>${item.name} x${item.quantity}</span>
            </div>
            <span>${itemTotal.toLocaleString()}₫</span>
          `;
        container.appendChild(div);
      });

      subtotalEl.innerText = `${subtotal.toLocaleString()}₫`;
      totalEl.innerText = `${subtotal.toLocaleString()}₫`;
    }


    renderOrderItems();
    if (orderBtn) {
      orderBtn.addEventListener("click", e => {
        e.preventDefault();
        toast.classList.add("show");
        setTimeout(() => {
          toast.classList.remove("show");
        }, 2000);
        localStorage.removeItem("cart");
      });
    }
  }
});

// header user
const userToggle = document.querySelector(".user-toggle");

if (userToggle) {
  userToggle.addEventListener("click", function (e) {
    e.preventDefault();
    document.querySelector(".user-dropdown").classList.toggle("show");
  });

  document.addEventListener("click", function (e) {
    const menu = document.querySelector(".user-menu");
    if (!menu.contains(e.target)) {
      document.querySelector(".user-dropdown").classList.remove("show");
    }
  });
}

  });

// Cart initialization (only if cart page is loaded)
if (document.getElementById('cart-items')) {
    initCart();
}

// thumb up logic
$(document).ready(function() {
    // Initialize comment functionality
    $('.star-rating').on('click', function() {
        const rating = $(this).data('rating');
        $('#ratingValue').val(rating);

        // update star visuals
        $('.star-rating').each(function(index) {
            const starSvg = $(this).find('svg use');
            if (index < rating) {
                starSvg.attr('xlink:href', '#star-fill');
            } else {
                starSvg.attr('xlink:href', '#star-empty');
            }
        });
    });

    // handle comment form submission
    $('#commentForm').on('submit', function(e) {
        e.preventDefault();
        // should submit the comment to the server here
        alert('Comment submitted successfully!');
        $('#commentForm')[0].reset();
        // reset star ratings to default
        $('.star-rating svg use').attr('xlink:href', '#star-empty');
        $('#ratingValue').val(5);
    });
});

function toggleThumbUp(button) {
    const thumbBtn = $(button);
    const thumbCountSpan = thumbBtn.find('.thumb-count');
    let currentCount = parseInt(thumbCountSpan.text());

    if (thumbBtn.hasClass('btn-outline-secondary')) {
        thumbBtn.removeClass('btn-outline-secondary').addClass('btn-primary');
        currentCount++;
    } else {
        thumbBtn.removeClass('btn-primary').addClass('btn-outline-secondary');
        currentCount--;
    }

    thumbCountSpan.text(currentCount);
}

