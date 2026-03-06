package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");
        ReservationDAO dao = new ReservationDAO();

        if ("add".equals(action)) {
            Reservation r = new Reservation();
            r.setReservationNumber(request.getParameter("reservationNumber"));
            r.setGuestName(request.getParameter("guestName"));
            r.setAddress(request.getParameter("address"));
            r.setContactNumber(request.getParameter("contactNumber"));
            r.setRoomType(request.getParameter("roomType"));
            r.setCheckInDate(request.getParameter("checkInDate"));
            r.setCheckOutDate(request.getParameter("checkOutDate"));
            r.setRoomRate(Double.parseDouble(request.getParameter("roomRate")));

            boolean success = dao.addReservation(r);
            if (success) {
                response.sendRedirect("dashboard.jsp?msg=Reservation added successfully!");
            } else {
                response.sendRedirect("addReservation.jsp?error=Failed to add reservation!");
            }

        } else if ("delete".equals(action)) {
            String reservationNumber = request.getParameter("reservationNumber");
            dao.deleteReservation(reservationNumber);
            response.sendRedirect("dashboard.jsp?msg=Reservation deleted successfully!");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        ReservationDAO dao = new ReservationDAO();
        request.setAttribute("reservations", dao.getAllReservations());
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
