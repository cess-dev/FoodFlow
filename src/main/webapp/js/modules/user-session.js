/* User/session display helpers */

async function loadUserInfo() {
    try {
        // Try to get user info from session via a simple API call
        // For now, we'll use a placeholder that gets updated
        const userName = sessionStorage.getItem('userName') || 'User';
        const userRole = sessionStorage.getItem('userRole') || 'Store Manager';
        
        // Update sidebar
        document.getElementById('sidebarUserName').textContent = userName;
        document.getElementById('sidebarUserRole').textContent = userRole;
        
        // Update topbar
        document.getElementById('topbarUserName').textContent = userName;
        
        console.log('User info loaded:', userName, userRole);
    } catch (error) {
        console.error('Error loading user info:', error);
    }
}

