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
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String reservationNumber = request.getParameter("reservationNumber");
        ReservationDAO dao = new ReservationDAO();
        Reservation r = dao.getReservationByNumber(reservationNumber);

        if (r != null) {
            LocalDate checkIn  = LocalDate.parse(r.getCheckInDate());
            LocalDate checkOut = LocalDate.parse(r.getCheckOutDate());
            long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
            if (nights < 1) nights = 1;
            double total = nights * r.getRoomRate();

            request.setAttribute("reservation", r);
            request.setAttribute("nights", nights);
            request.setAttribute("total", total);
            request.getRequestDispatcher("bill.jsp").forward(request, response);
        } else {
            response.sendRedirect("dashboard.jsp?msg=Reservation not found!");
        }
    }
}
