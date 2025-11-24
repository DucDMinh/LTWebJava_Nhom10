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

// Cart initialization (only if cart page is loaded)
if (document.getElementById('cart-items')) {
  initCart();
}


