<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%@ page import="com.oceanview.dao.ReservationDAO" %>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    ReservationDAO dao = new ReservationDAO();
    List<Reservation> reservations = dao.getAllReservations();
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - OceanView Hotel</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body style="background:#f0f4f8; min-height:100vh;">
<div class="dashboard">

    <div class="dashboard-header">
        <h2>🌊 OceanView Hotel — Dashboard</h2>
        <div>
            <a href="addReservation.jsp" class="btn btn-add">+ Add Reservation</a>
            <a href="logout" class="btn btn-logout">Logout</a>
        </div>
    </div>

    <% if (msg != null) { %>
        <div class="msg-success"><%= msg %></div>
    <% } %>

    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>Res. Number</th>
                <th>Guest Name</th>
                <th>Contact</th>
                <th>Room Type</th>
                <th>Check In</th>
                <th>Check Out</th>
                <th>Rate (LKR)</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <% if (reservations.isEmpty()) { %>
            <tr>
                <td colspan="9" style="text-align:center; color:#999;">
                    No reservations found.
                </td>
            </tr>
        <% } else {
            int i = 1;
            for (Reservation r : reservations) { %>
            <tr>
                <td><%= i++ %></td>
                <td><%= r.getReservationNumber() %></td>
                <td><%= r.getGuestName() %></td>
                <td><%= r.getContactNumber() %></td>
                <td><%= r.getRoomType() %></td>
                <td><%= r.getCheckInDate() %></td>
                <td><%= r.getCheckOutDate() %></td>
                <td><%= r.getRoomRate() %></td>
                <td>
                    <a href="bill?reservationNumber=<%= r.getReservationNumber() %>"
                       class="btn btn-add"
                       style="padding:6px 12px; font-size:12px; margin-right:5px;">
                        🧾 Bill
                    </a>
                    <form action="reservation" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="reservationNumber"
                               value="<%= r.getReservationNumber() %>"/>
                        <button type="submit" class="btn btn-delete"
                                onclick="return confirm('Delete this reservation?')">
                            Delete
                        </button>
                    </form>
                </td>
            </tr>
        <% } } %>
        </tbody>
    </table>

</div>
</body>
</html>
