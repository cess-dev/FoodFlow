/* View and quick action handlers */

async function viewItem(itemId) {
    try {
        const item = await FoodFlowAPI.items.getById(itemId);
        
        const body = document.getElementById('viewItemBody');
        body.innerHTML = `
            <div class="detail-grid">
                <div class="detail-item">
                    <div class="detail-label">Item Name</div>
                    <div class="detail-value">${item.name}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Category</div>
                    <div class="detail-value">${item.category}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Current Stock</div>
                    <div class="detail-value">${item.currentStock} ${item.unitOfMeasure || ''}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Status</div>
                    <div class="detail-value">${getStatusBadge(item.status)}</div>
                </div>
            </div>
        `;
        
        const modal = new bootstrap.Modal(document.getElementById('viewItemModal'));
        modal.show();
    } catch (error) {
        showToast('Error loading item details: ' + error.message, 'danger');
    }
}

