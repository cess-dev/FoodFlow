<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodFlow - Sign Up</title>
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@300;400;600;700;900&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --purple-950: #1a0b2e;
            --purple-900: #2d1b4e;
            --purple-800: #3d2663;
            --purple-700: #4c1d95;
            --purple-600: #5b21b6;
            --purple-500: #6d28d9;
            --purple-400: #7c3aed;
            --purple-300: #8b5cf6;
            --purple-200: #a78bfa;
            --purple-100: #c4b5fd;
            --purple-50: #ede9fe;
            --accent-cyan: #06b6d4;
            --accent-green: #10b981;
            --accent-red: #ef4444;
            --accent-amber: #f59e0b;
            --text-primary: #f8fafc;
            --text-secondary: #cbd5e1;
            --text-muted: #94a3b8;
            --border-color: rgba(139, 92, 246, 0.2);
            --radius-sm: 6px;
            --radius-md: 10px;
            --radius-lg: 16px;
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.3);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.4);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.5);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Exo 2', sans-serif;
            background: linear-gradient(135deg, var(--purple-950) 0%, var(--purple-900) 50%, var(--purple-800) 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow-y: auto;
        }

        body::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(124, 58, 237, 0.1) 0%, transparent 70%);
            animation: rotate 30s linear infinite;
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .auth-container {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 500px;
            animation: slideUp 0.6s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .auth-card {
            background: rgba(45, 27, 78, 0.8);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 40px;
            box-shadow: var(--shadow-lg);
        }

        .auth-header {
            text-align: center;
            margin-bottom: 32px;
        }

        .auth-logo {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, var(--purple-500), var(--purple-400));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 0 30px rgba(124, 58, 237, 0.5);
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { box-shadow: 0 0 30px rgba(124, 58, 237, 0.5); }
            50% { box-shadow: 0 0 50px rgba(124, 58, 237, 0.8); }
        }

        .auth-logo i {
            font-size: 32px;
            color: white;
        }

        .auth-title {
            font-size: 28px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .auth-subtitle {
            font-size: 14px;
            color: var(--text-secondary);
        }

        .alert {
            padding: 12px 16px;
            border-radius: var(--radius-sm);
            margin-bottom: 20px;
            font-size: 13px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideDown 0.4s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #fca5a5;
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.3);
            color: #6ee7b7;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: var(--text-secondary);
            margin-bottom: 8px;
            letter-spacing: 0.5px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--purple-300);
            font-size: 16px;
            transition: var(--transition);
        }

        .form-control {
            width: 100%;
            padding: 12px 14px 12px 42px;
            background: rgba(26, 11, 46, 0.6);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-sm);
            color: var(--text-primary);
            font-family: 'Exo 2', sans-serif;
            font-size: 14px;
            transition: var(--transition);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--purple-400);
            box-shadow: 0 0 0 3px rgba(124, 58, 237, 0.1);
            background: rgba(26, 11, 46, 0.8);
        }

        .form-control:focus + i {
            color: var(--purple-400);
        }

        .form-control::placeholder {
            color: var(--text-muted);
        }

        .form-control.error {
            border-color: var(--accent-red);
        }

        .error-message {
            color: #fca5a5;
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }

        .error-message.show {
            display: block;
        }

        select.form-control {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%238b5cf6' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 14px center;
            padding-right: 40px;
        }

        select.form-control option {
            background: var(--purple-900);
            color: var(--text-primary);
        }

        .btn-primary {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, var(--purple-500), var(--purple-400));
            border: none;
            border-radius: var(--radius-sm);
            color: white;
            font-family: 'Exo 2', sans-serif;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            letter-spacing: 0.5px;
            margin-top: 10px;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--purple-600), var(--purple-500));
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(124, 58, 237, 0.4);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        .btn-primary:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }

        .auth-footer {
            text-align: center;
            margin-top: 24px;
            padding-top: 24px;
            border-top: 1px solid var(--border-color);
        }

        .auth-link {
            color: var(--purple-300);
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: var(--transition);
        }

        .auth-link:hover {
            color: var(--purple-200);
            text-decoration: underline;
        }

        .password-toggle {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            transition: var(--transition);
            font-size: 16px;
        }

        .password-toggle:hover {
            color: var(--purple-300);
        }

        .password-strength {
            margin-top: 8px;
            height: 4px;
            background: rgba(26, 11, 46, 0.6);
            border-radius: 2px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0;
            transition: var(--transition);
            border-radius: 2px;
        }

        .password-strength-text {
            font-size: 11px;
            margin-top: 4px;
            color: var(--text-muted);
        }

        @media (max-width: 520px) {
            .auth-card {
                padding: 30px 20px;
            }

            .auth-title {
                font-size: 24px;
            }

            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <div class="auth-logo">
                    <i class="fas fa-utensils"></i>
                </div>
                <h1 class="auth-title">Create Account</h1>
                <p class="auth-subtitle">Join FoodFlow today</p>
            </div>

            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- Success Message -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <span>${success}</span>
                </div>
            </c:if>

            <!-- Signup Form -->
            <form action="${pageContext.request.contextPath}/auth?action=signup" method="POST" id="signupForm" onsubmit="return validateForm()">
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="fullName">Full Name</label>
                        <div class="input-wrapper">
                            <input 
                                type="text" 
                                id="fullName" 
                                name="fullName" 
                                class="form-control" 
                                placeholder="John Doe"
                                value="${fullName}"
                                required
                            >
                            <i class="fas fa-user"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="username">Username</label>
                        <div class="input-wrapper">
                            <input 
                                type="text" 
                                id="username" 
                                name="username" 
                                class="form-control" 
                                placeholder="johndoe"
                                value="${username}"
                                required
                            >
                            <i class="fas fa-at"></i>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="email">Email Address</label>
                    <div class="input-wrapper">
                        <input 
                            type="email" 
                            id="email" 
                            name="email" 
                            class="form-control" 
                            placeholder="john@example.com"
                            value="${email}"
                            required
                        >
                        <i class="fas fa-envelope"></i>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="password">Password</label>
                        <div class="input-wrapper">
                            <input 
                                type="password" 
                                id="password" 
                                name="password" 
                                class="form-control" 
                                placeholder="••••••••"
                                required
                                onkeyup="checkPasswordStrength()"
                            >
                            <i class="fas fa-lock"></i>
                            <button type="button" class="password-toggle" onclick="togglePassword('password', this)">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <div class="password-strength">
                            <div class="password-strength-bar" id="strengthBar"></div>
                        </div>
                        <div class="password-strength-text" id="strengthText"></div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="confirmPassword">Confirm Password</label>
                        <div class="input-wrapper">
                            <input 
                                type="password" 
                                id="confirmPassword" 
                                name="confirmPassword" 
                                class="form-control" 
                                placeholder="••••••••"
                                required
                            >
                            <i class="fas fa-lock"></i>
                            <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword', this)">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="role">Account Type</label>
                    <div class="input-wrapper">
                        <select id="role" name="role" class="form-control" required>
                            <option value="">Select role...</option>
                            <option value="STOREKEEPER" ${role eq 'STOREKEEPER' ? 'selected' : ''}>Storekeeper</option>
                            <option value="DEPARTMENT_HEAD" ${role eq 'DEPARTMENT_HEAD' ? 'selected' : ''}>Department Head</option>
                        </select>
                        <i class="fas fa-user-tag"></i>
                    </div>
                </div>

                <button type="submit" class="btn-primary" id="submitBtn">
                    <i class="fas fa-user-plus"></i> Create Account
                </button>
            </form>

            <div class="auth-footer">
                <p>Already have an account? <a href="login.jsp" class="auth-link">Sign In</a></p>
            </div>
        </div>
    </div>

    <script>
        function togglePassword(inputId, button) {
            const passwordInput = document.getElementById(inputId);
            const toggleButton = button.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleButton.classList.remove('fa-eye');
                toggleButton.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleButton.classList.remove('fa-eye-slash');
                toggleButton.classList.add('fa-eye');
            }
        }

        function checkPasswordStrength() {
            const password = document.getElementById('password').value;
            const strengthBar = document.getElementById('strengthBar');
            const strengthText = document.getElementById('strengthText');
            
            let strength = 0;
            
            if (password.length >= 8) strength++;
            if (password.length >= 12) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/\d/.test(password)) strength++;
            if (/[^a-zA-Z0-9]/.test(password)) strength++;
            
            const colors = ['#ef4444', '#f59e0b', '#f59e0b', '#10b981', '#10b981'];
            const texts = ['Very Weak', 'Weak', 'Fair', 'Strong', 'Very Strong'];
            
            strengthBar.style.width = (strength * 20) + '%';
            strengthBar.style.background = colors[strength - 1] || '#ef4444';
            strengthText.textContent = texts[strength - 1] || 'Very Weak';
            strengthText.style.color = colors[strength - 1] || '#ef4444';
        }

        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                alert('Passwords do not match!');
                return false;
            }
            
            if (password.length < 8) {
                alert('Password must be at least 8 characters long!');
                return false;
            }
            
            return true;
        }

        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    alert.style.opacity = '0';
                    alert.style.transform = 'translateY(-10px)';
                    setTimeout(function() {
                        alert.remove();
                    }, 300);
                }, 5000);
            });
        });
    </script>
</body>
</html>
