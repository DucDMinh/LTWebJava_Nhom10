<!-- Swiper -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
      integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
      crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- Bootstrap -->
<link rel="stylesheet" href="${env}/client/bootstrap/css/bootstrap.min.css">

<!-- Slick -->
<link rel="stylesheet" type="text/css" href="${env}/client/bootstrap/css/slick.css" />
<link rel="stylesheet" type="text/css" href="${env}/client/bootstrap/css/slick-theme.css" />

<!-- Css -->
<link rel="stylesheet" href="${env}/client/css/style.css">
<!-- vendor Css -->
<link rel="stylesheet" href="${env}/client/css/vendor.css">
<!--Sign In Css -->
<link rel="stylesheet" href="${env}/client/css/Sign_in.css">
<!--Sign Up Css -->
<link rel="stylesheet" href="${env}/client/css/Sign_up.css">

<style>
      .summary-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 20px;
            /* Giữ card khi cuộn trang */
      }

      .summary-title {
            font-weight: 700;
            font-size: 1.25rem;
            margin-bottom: 1.5rem;
            color: #1f2937;
            border-bottom: 2px solid #f3f4f6;
            padding-bottom: 10px;
      }

      .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            font-size: 0.95rem;
            color: #4b5563;
      }

      .summary-row span.label {
            color: #6b7280;
      }

      .summary-row span.value {
            font-weight: 500;
            color: #111827;
      }

      .summary-row.total {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px dashed #d1d5db;
            font-size: 1.1rem;
      }

      .summary-row.total .value {
            color: #dc2626;
            /* Màu đỏ cho tổng tiền */
            font-weight: 800;
            font-size: 1.35rem;
      }

      .checkout-btn {
            width: 100%;
            background-color: #0d6efd;
            /* Bootstrap Primary */
            color: white;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            margin-top: 1.5rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
      }

      .checkout-btn:hover {
            background-color: #0b5ed7;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(13, 110, 253, 0.25);
      }

      .coupon-section {
            margin-top: 1.5rem;
            padding: 15px;
            background-color: #f9fafb;
            border-radius: 8px;
            border: 1px dashed #d1d5db;
      }

      .input-group-coupon {
            display: flex;
            gap: 8px;
      }

      .input-group-coupon input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 0.9rem;
      }

      .input-group-coupon button {
            padding: 8px 16px;
            background-color: #374151;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9rem;
      }

      .discount-text {
            color: #059669;
            /* Màu xanh lá cho giảm giá */
            font-size: 0.9rem;
      }
</style>