/* Toast and UI feedback utilities */

function closeModal(modalId) {
    const modal = bootstrap.Modal.getInstance(document.getElementById(modalId));
    if (modal) {
        modal.hide();
    }
}

/**
 * Show toast notification
 */
function showToast(message, type = 'info') {
    const toastEl = document.getElementById('appToast');
    const toastBody = document.getElementById('toastBody');
    
    toastBody.textContent = message;
    toastEl.className = `toast align-items-center text-white border-0 bg-${type}`;
    
    const toast = new bootstrap.Toast(toastEl);
    toast.show();
}

/**
 * Animate numeric values
 */
function animateValue(id, start, end, duration) {
    const obj = document.getElementById(id);
    const range = end - start;
    const increment = range / (duration / 50);
    let current = start;
    
    const timer = setInterval(() => {
        current += increment;
        if ((increment > 0 && current >= end) || (increment < 0 && current <= end)) {
            current = end;
            clearInterval(timer);
        }
        obj.textContent = Math.floor(current);
    }, 50);
}

/**
 * Show/hide loading state
 */
function showLoading(show) {
    // Could implement a loading overlay here
    console.log('Loading:', show ? 'started' : 'completed');
}

