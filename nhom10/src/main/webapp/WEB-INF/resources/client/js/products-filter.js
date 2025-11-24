const filterState = {
    category: [],
    factory: [],
    os: [],
    ram: [],
    storage: [],
    priceRange: [],
    screenSizeRange: [],
    batteryRange: []
};

// configuration for range filters (maps range string -> min/max values)
const RANGE_CONFIG = {
    price: { minInput: 'minPriceInput', maxInput: 'maxPriceInput', defaultMax: 999999999 },
    screen: { minInput: 'minScreenSizeInput', maxInput: 'maxScreenSizeInput', defaultMax: 99 },
    battery: {
        minInput: 'minPinInput', maxInput: 'maxPinInput', defaultMax: 99999,
        mappings: {
            'Dưới 3000': [0, 3000],
            '3000-4000': [3000, 4000],
            '4000-5500': [4000, 5500],
            'Trên 5500': [5500, 99999]
        }
    }
};

document.addEventListener('DOMContentLoaded', function() {
    const savedScroll = sessionStorage.getItem('filterScrollPosition');

    if (savedScroll) {
        window.scrollTo({
            top: parseInt(savedScroll),
            behavior: 'instant'
        });
        sessionStorage.removeItem('filterScrollPosition');
    }

    const urlParams = new URLSearchParams(window.location.search);

    ['category', 'factory'].forEach(type => {
        const values = urlParams.getAll(type).filter(v => v.trim() !== '');
        if (values.length > 0) {
            const allBox = document.getElementById(`all${capitalize(type)}`);
            if (allBox) allBox.checked = false;
        }
    });

    ['os', 'ram', 'storage'].forEach(type => {
        const param = urlParams.get(type);
        if (param) {
            const values = param.split(',');
            filterState[type] = values;
            document.getElementById(`${type}Input`).value = param;

            // highlight Buttons
            values.forEach(val => {
                // find button by text content (trimming spaces)
                const btn = Array.from(document.querySelectorAll(`.accordion-body button`))
                    .find(b => {
                        const buttonText = b.textContent.replace('+', '').trim();
                        return buttonText === val.trim() && b.getAttribute('onclick')?.includes(type);
                    });

                if (btn) toggleButtonVisuals(btn, true);
            });
        }
    });

    ['priceRange', 'screenSizeRange', 'batteryRange'].forEach(type => {
        const values = urlParams.getAll(type).filter(v => v.trim() !== '');
        if (values.length > 0) {
            const shortName = type.replace('Range', '');
            const allId = type === 'screenSizeRange' ? 'allScreen' : `all${capitalize(shortName)}`;
            const allBox = document.getElementById(allId);
            if (allBox) allBox.checked = false;

            values.forEach(val => {
                const input = document.querySelector(`input[name="${type}"][value="${val}"]`);
                if (input) input.checked = true;
            });
        }
    });

    updatePriceDisplay();
});

function capitalize(s) {
    return s.charAt(0).toUpperCase() + s.slice(1);
}

function toggleButtonVisuals(btn, isActive) {
    if (isActive) {
        btn.classList.remove('btn-outline-secondary');
        btn.classList.add('active', 'btn-primary');
    } else {
        btn.classList.add('btn-outline-secondary');
        btn.classList.remove('active', 'btn-primary');
    }
}

function toggleButtonFilter(type, value, btn) {
    const index = filterState[type].indexOf(value);

    if (index > -1) {
        filterState[type].splice(index, 1); // memove
        toggleButtonVisuals(btn, false);
    } else {
        filterState[type].push(value); // add
        toggleButtonVisuals(btn, true);
    }

    // sync hidden input
    document.getElementById(`${type}Input`).value = filterState[type].join(',');
    filterProducts(null);
}

function toggleAll(type, isChecked) {
    const name = type === 'screen' ? 'screenSizeRange' : (type === 'price' || type === 'battery' ? `${type}Range` : type);

    if (isChecked) {
        // uncheck all specific inputs
        document.querySelectorAll(`input[name="${name}"]`).forEach(el => el.checked = false);

        // reset Ranges if applicable
        if (RANGE_CONFIG[type]) {
            document.getElementById(RANGE_CONFIG[type].minInput).value = 0;
            document.getElementById(RANGE_CONFIG[type].maxInput).value = RANGE_CONFIG[type].defaultMax;
        }
    } else {
        // if user unchecks "All" but nothing else is selected, force "All" back on
        const anyChecked = document.querySelectorAll(`input[name="${name}"]:checked`).length > 0;
        if (!anyChecked) document.getElementById(`all${capitalize(type)}`).checked = true;
    }
    filterProducts(null);
}

function onFilterChange(type) {
    const allBox = document.getElementById(`all${capitalize(type)}`);
    const anyChecked = document.querySelectorAll(`input[name="${type}"]:checked`).length > 0;
    allBox.checked = !anyChecked;
    filterProducts(null);
}

function handleRangeFilter(type, rangeValue, isChecked) {
    const config = RANGE_CONFIG[type];
    const rangeName = type === 'screen' ? 'screenSizeRange' : `${type}Range`;
    const allId = type === 'screen' ? 'allScreen' : `all${capitalize(type)}`;

    if (isChecked) {
        document.getElementById(allId).checked = false;

        // calculate min/max
        let min, max;
        if (config.mappings && config.mappings[rangeValue]) {
            [min, max] = config.mappings[rangeValue];
        } else {
            [min, max] = rangeValue.split('-').map(Number);
        }

        if (min !== undefined) document.getElementById(config.minInput).value = min;
        if (max !== undefined) document.getElementById(config.maxInput).value = max;
    } else {
        // if everything unchecked, re-check "All"
        const anyChecked = document.querySelectorAll(`input[name="${rangeName}"]:checked`).length > 0;
        if (!anyChecked) {
            document.getElementById(allId).checked = true;
            document.getElementById(config.minInput).value = 0;
            document.getElementById(config.maxInput).value = config.defaultMax;
        }
    }
    filterProducts(null);
}

function onManualRangeChange(type) {
    const rangeName = type === 'screen' ? 'screenSizeRange' : `${type}Range`;
    document.querySelectorAll(`input[name="${rangeName}"]`).forEach(el => el.checked = false);

    filterProducts(null);
}

function filterProducts(targetPage) {
    const params = new URLSearchParams();

    if (typeof targetPage !== 'undefined' && targetPage !== null) {
        params.append('page', targetPage);
    }

    const search = document.getElementById('searchInput').value;
    if (search && search.trim() !== '') {
        params.append('search', search.trim());
    }

    const checkboxGroups = ['category', 'factory', 'priceRange', 'screenSizeRange', 'batteryRange'];
    checkboxGroups.forEach(group => {
        const checked = document.querySelectorAll(`input[name="${group}"]:checked`);
        checked.forEach(el => {
            if (el.value && el.value.trim() !== '') {
                params.append(group, el.value);
            }
        });
    });

    ['os', 'ram', 'storage'].forEach(id => {
        const val = document.getElementById(`${id}Input`).value;
        if (val && val.trim() !== '') {
            params.append(id, val);
        }
    });

    const rangeInputs = [
        { key: 'minPrice', id: 'minPriceInput', def: '0' },
        { key: 'maxPrice', id: 'maxPriceInput', def: '999999999' },
        { key: 'minScreenSize', id: 'minScreenSizeInput', def: '0' },
        { key: 'maxScreenSize', id: 'maxScreenSizeInput', def: '99' },
        { key: 'minPin', id: 'minPinInput', def: '0' },
        { key: 'maxPin', id: 'maxPinInput', def: '99999' },
    ];

    rangeInputs.forEach(item => {
        const el = document.getElementById(item.id);
        if (el) {
            const val = el.value;
            // Parse both as floats to compare values (0.0 == 0), ignoring string format
            const numVal = parseFloat(val);
            const numDef = parseFloat(item.def);

            // Check if valid number AND different from default
            if (!isNaN(numVal) && numVal !== numDef) {
                params.append(item.key, val); // Send the original value (or numVal if you prefer clean URL)
            }
        }
    });

    // Save scroll position and reload
    sessionStorage.setItem('filterScrollPosition', window.scrollY);
    window.location.href = `/products?${params.toString()}`;
}

function updatePriceDisplay() {
    const minPrice = document.getElementById('minPriceInput').value;
    const maxPrice = document.getElementById('maxPriceInput').value;
    const minDisplay = document.getElementById('minPriceDisplay');
    const maxDisplay = document.getElementById('maxPriceDisplay');

    if (minDisplay) {
        minDisplay.textContent = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(minPrice);
    }
    if (maxDisplay) {
        maxDisplay.textContent = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(maxPrice);
    }
}
