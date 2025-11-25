document.addEventListener('DOMContentLoaded', () => {
    const buttons = document.querySelectorAll('.wishlist-btn');

    buttons.forEach(btn => {
        btn.addEventListener('click', () => {
            const productId = btn.dataset.productId;
            const wishId = btn.dataset.wishId;

            if (wishId) {
                // đã có wishlist -> remove
                fetch('/wishlist/remove', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'X-CSRF-TOKEN': '${_csrf.token}'
                    },
                    body: new URLSearchParams({ wishListId: wishId })
                })
                    .then(res => res.json())
                    .then(data => {
                        if (data.success) {
                            btn.dataset.wishId = '';
                            btn.innerHTML = '<i class="fa-regular fa-heart" style="font-size: 25px;"></i>';
                        }
                    });
            } else {
                const csrfToken = document.querySelector('meta[name="_csrf"]').content;

                fetch('/wishlist/add', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'X-CSRF-TOKEN': csrfToken
                    },
                    body: new URLSearchParams({ productId })
                })
                    .then(res => res.json())
                    .then(data => {
                        if (data.success) {
                            btn.dataset.wishId = data.wishListId;
                            btn.innerHTML = '<i class="fa-solid fa-heart" style="font-size: 25px;"></i>';
                        }
                    });
            }
        });
    });
});