package com.foodflow.config;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AppFilter implements Filter {

    // Pages that don't require authentication
    private static final String[] PUBLIC_PAGES = {
        "/landing.jsp",
        "/login.jsp",
        "/auth",
        "/css/",
        "/js/",
        "/images/",
        "/favicon.ico"
    };

    @Override
    public void init(FilterConfig filterConfig) {
        // No-op.
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        WebConfig.configureRequest(request);
        WebConfig.configureResponse(response);
        
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = requestURI.substring(contextPath.length());

        // Redirect root path to landing page
        if (path.equals("/") || path.isEmpty()) {
            response.sendRedirect(contextPath + "/landing.jsp");
            return;
        }

        // Check if the requested page is public
        if (!isPublicPage(path)) {
            // Check if user is authenticated
            HttpSession session = request.getSession(false);
            boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

            if (!isLoggedIn) {
                // User is not authenticated, redirect to login
                response.sendRedirect(contextPath + "/login.jsp");
                return;
            }
        }
        
        HttpSession activeSession = request.getSession(false);
        if (activeSession != null) {
            activeSession.setMaxInactiveInterval(WebConfig.SESSION_TIMEOUT_MINUTES * 60);
        }

        chain.doFilter(servletRequest, servletResponse);
    }

    /**
     * Check if the requested page is publicly accessible
     */
    private boolean isPublicPage(String path) {
        // Exact match
        for (String publicPage : PUBLIC_PAGES) {
            if (path.equals(publicPage) || path.startsWith(publicPage)) {
                return true;
            }
        }

        return false;
    }

    @Override
    public void destroy() {
        // No-op.
    }
}
