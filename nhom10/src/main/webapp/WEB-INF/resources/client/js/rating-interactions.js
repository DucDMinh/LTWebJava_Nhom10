// JavaScript for interactive star rating and thumb up functionality

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