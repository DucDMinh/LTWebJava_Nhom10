(function ($) {
    "use strict";
    function formatCurrency(value) {
        return new Intl.NumberFormat('vi-VN').format(value) + " ₫";
    }

    function updateSelectedTotal() {
        var total = 0;
        var count = 0;
        if ($('.item-checkbox').length === 0) return;

        $('.item-checkbox').each(function () {
            if ($(this).is(':checked')) {
                count++;
                var row = $(this).closest('tr');
                var inputQty = row.find('.quantity input');
                var price = parseFloat(inputQty.attr("data-cart-detail-price")) || 0;
                var quantity = parseFloat(inputQty.val()) || 0;

                total += price * quantity;
            }
        });
        $('#final-total').text(formatCurrency(total));
        $('#selected-count').text(count);
    }

    function initQuantityLogic() {
        $('.quantity button').off('click').on('click', function (e) {
            e.preventDefault();

            var button = $(this);
            var inputVisible = button.closest('.quantity').find('input');

            var oldValue = parseFloat(inputVisible.val()) || 0;
            var newVal = oldValue;
            if (button.hasClass('btn-plus') || button.find('.fa-plus').length > 0) {
                newVal = oldValue + 1;
            } else {
                if (oldValue > 1) {
                    newVal = oldValue - 1;
                } else {
                    newVal = 1;
                }
            }
            inputVisible.val(newVal);
            var index = inputVisible.attr("data-cart-detail-index");
            if (index !== undefined) {
                $('#hidden-qty-' + index).val(newVal);
            }
            var price = parseFloat(inputVisible.attr("data-cart-detail-price")) || 0;
            var id = inputVisible.attr("data-cart-detail-id");
            var newRowTotal = price * newVal;

            $('p[data-total-price-id="' + id + '"]').text(formatCurrency(newRowTotal));
            updateSelectedTotal();
        });
    }

    function initCheckboxLogic() {
        $('#selectAll').on('change', function () {
            var isChecked = $(this).is(':checked');
            $('.item-checkbox').prop('checked', isChecked);
            updateSelectedTotal();
        });
        $('.item-checkbox').on('change', function () {
            if (!$(this).is(':checked')) {
                $('#selectAll').prop('checked', false);
            }
            var totalItems = $('.item-checkbox').length;
            var checkedItems = $('.item-checkbox:checked').length;
            if (totalItems === checkedItems && totalItems > 0) {
                $('#selectAll').prop('checked', true);
            }

            updateSelectedTotal();
        });
    }

    function initSubmitLogic() {
        $('#checkout-form').on('submit', function (e) {
            if ($('.item-checkbox').length > 0) {
                var checkedItems = $('.item-checkbox:checked').length;
                if (checkedItems === 0) {
                    e.preventDefault();
                    alert("Vui lòng chọn ít nhất một sản phẩm để thanh toán!");
                    return false;
                }
                $('.item-checkbox').each(function () {
                    if (!$(this).is(':checked')) {
                        var index = $(this).attr("data-item-index");
                        $('#hidden-id-' + index).prop('disabled', true);
                        $('#hidden-qty-' + index).prop('disabled', true);
                    }
                });
            }
        });
    }

    function initCheckoutLogic() {
        var shippingSelect = $('#shippingMethod');
        if (shippingSelect.length === 0) return;

        var subtotalEl = $('#subtotalDisplay');
        var shippingFeeEl = $('#shippingFeeDisplay');
        var totalEl = $('#totalDisplay');

        var hiddenShippingFee = $('#hiddenShippingFee');
        var hiddenTotalPrice = $('#hiddenTotalPrice');
        var baseSubtotal = parseFloat(subtotalEl.attr('data-subtotal')) || 0;

        function updateTotals() {

            var selectedOption = shippingSelect.find('option:selected');

            var shippingFee = parseFloat(selectedOption.attr('data-price')) || 0;

            var newTotal = baseSubtotal + shippingFee;
            shippingFeeEl.text(formatCurrency(shippingFee));
            totalEl.text(formatCurrency(newTotal));
            if (hiddenShippingFee.length) hiddenShippingFee.val(shippingFee);
            if (hiddenTotalPrice.length) hiddenTotalPrice.val(newTotal);
        }
        shippingSelect.on('change', function () {
            updateTotals();
        });
        updateTotals();
    }


    $(document).ready(function () {

        initQuantityLogic();
        initCheckboxLogic();
        initSubmitLogic();
        updateSelectedTotal();

        initCheckoutLogic();
    });

})(jQuery);