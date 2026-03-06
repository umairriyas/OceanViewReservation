package com.oceanview.servlet;

import com.oceanview.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        boolean isValid = userDAO.validateUser(username, password);

        if (isValid) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid username or password!");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
