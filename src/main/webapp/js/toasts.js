(function () {
    var ICONS = { success: '&#10003;', error: '&#10007;', info: '&#8505;' };

    function showToast(type, message) {
        var container = document.getElementById('toast-container');
        if (!container || !message) return;

        var toast = document.createElement('div');
        toast.className = 'toast toast-' + (type || 'info');

        var icon = document.createElement('span');
        icon.className = 'toast-icon';
        icon.innerHTML = ICONS[type] || ICONS.info;

        var body = document.createElement('span');
        body.className = 'toast-body';
        body.textContent = message;

        var close = document.createElement('button');
        close.className = 'toast-close';
        close.setAttribute('aria-label', 'Dismiss');
        close.innerHTML = '&times;';

        toast.appendChild(icon);
        toast.appendChild(body);
        toast.appendChild(close);
        container.appendChild(toast);

        var timer = setTimeout(function () { dismiss(toast); }, 4000);

        close.addEventListener('click', function () {
            clearTimeout(timer);
            dismiss(toast);
        });
    }

    function dismiss(toast) {
        toast.classList.add('toast-out');
        toast.addEventListener('animationend', function () {
            if (toast.parentNode) { toast.parentNode.removeChild(toast); }
        }, { once: true });
    }

    var flashEl = document.getElementById('flash-data');
    if (flashEl) {
        showToast(flashEl.dataset.type, flashEl.dataset.message);
    }

    window.YatraGoToast = showToast;
}());
