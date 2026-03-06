<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Reservation - OceanView Hotel</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body style="background:#f0f4f8; min-height:100vh;">
<div class="form-container">

    <a href="dashboard.jsp" class="btn btn-back">← Back to Dashboard</a>
    <h2>Add New Reservation</h2>

    <% if (error != null) { %>
        <p class="error-msg"><%= error %></p>
    <% } %>

    <form action="reservation" method="post">
        <input type="hidden" name="action" value="add"/>

        <div class="form-group">
            <label>Reservation Number</label>
            <input type="text" name="reservationNumber" placeholder="e.g. RES-001" required/>
        </div>
        <div class="form-group">
            <label>Guest Name</label>
            <input type="text" name="guestName" placeholder="Full name" required/>
        </div>
        <div class="form-group">
            <label>Address</label>
            <input type="text" name="address" placeholder="Guest address" required/>
        </div>
        <div class="form-group">
            <label>Contact Number</label>
            <input type="text" name="contactNumber" placeholder="Phone number" required/>
        </div>
        <div class="form-group">
            <label>Room Type</label>
            <select name="roomType" required>
                <option value="">-- Select Room Type --</option>
                <option value="Standard">Standard</option>
                <option value="Deluxe">Deluxe</option>
                <option value="Suite">Suite</option>
                <option value="Ocean View">Ocean View</option>
                <option value="Presidential">Presidential</option>
            </select>
        </div>
        <div class="form-group">
            <label>Check-In Date</label>
            <input type="date" name="checkInDate" required/>
        </div>
        <div class="form-group">
            <label>Check-Out Date</label>
            <input type="date" name="checkOutDate" required/>
        </div>
        <div class="form-group">
            <label>Room Rate (LKR)</label>
            <input type="number" name="roomRate" placeholder="e.g. 15000" step="0.01" required/>
        </div>

        <button type="submit" class="btn btn-submit">Add Reservation</button>
    </form>

</div>
</body>
</html>
