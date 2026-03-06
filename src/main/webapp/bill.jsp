<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    Reservation r = (Reservation) request.getAttribute("reservation");
    long nights    = (long) request.getAttribute("nights");
    double total   = (double) request.getAttribute("total");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bill - OceanView Hotel</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .bill-wrapper {
            max-width: 650px;
            margin: 40px auto;
            background: white;
            border-radius: 12px;
            padding: 50px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            font-family: 'Times New Roman', serif;
        }
        .bill-header {
            text-align: center;
            border-bottom: 2px solid #2c5364;
            padding-bottom: 20px;
            margin-bottom: 30px;
        }
        .bill-header h1 {
            color: #2c5364;
            font-size: 28px;
            margin-bottom: 5px;
        }
        .bill-header p {
            color: #666;
            font-size: 13px;
        }
        .bill-section {
            margin-bottom: 25px;
        }
        .bill-section h3 {
            color: #2c5364;
            font-size: 15px;
            margin-bottom: 12px;
            border-bottom: 1px solid #eee;
            padding-bottom: 5px;
        }
        .bill-row {
            display: flex;
            justify-content: space-between;
            padding: 6px 0;
            font-size: 14px;
            color: #333;
        }
        .bill-row span:first-child {
            color: #666;
        }
        .bill-total-box {
            background: #2c5364;
            color: white;
            border-radius: 8px;
            padding: 20px 25px;
            margin-top: 20px;
        }
        .bill-total-box .bill-row {
            color: white;
            font-size: 15px;
        }
        .bill-total-box .bill-row span:first-child {
            color: #cde;
        }
        .bill-total-box .grand-total {
            font-size: 22px;
            font-weight: bold;
            border-top: 1px solid rgba(255,255,255,0.3);
            margin-top: 10px;
            padding-top: 10px;
        }
        .bill-actions {
            text-align: center;
            margin-top: 30px;
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        @media print {
            .bill-actions { display: none; }
            body { background: white; }
        }
    </style>
</head>
<body style="background:#f0f4f8; min-height:100vh;">
<div class="bill-wrapper" id="billContent">

    <div class="bill-header">
        <h1>🌊 OceanView Hotel</h1>
        <p>Beachside Hotel, Galle, Sri Lanka</p>
        <p>Tel: +94 91 234 5678 | info@oceanviewhotel.lk</p>
        <h2 style="margin-top:15px; font-size:18px; color:#555;">GUEST INVOICE</h2>
    </div>

    <div class="bill-section">
        <h3>Reservation Details</h3>
        <div class="bill-row">
            <span>Reservation Number</span>
            <span><%= r.getReservationNumber() %></span>
        </div>
        <div class="bill-row">
            <span>Guest Name</span>
            <span><%= r.getGuestName() %></span>
        </div>
        <div class="bill-row">
            <span>Address</span>
            <span><%= r.getAddress() %></span>
        </div>
        <div class="bill-row">
            <span>Contact Number</span>
            <span><%= r.getContactNumber() %></span>
        </div>
    </div>

    <div class="bill-section">
        <h3>Stay Details</h3>
        <div class="bill-row">
            <span>Room Type</span>
            <span><%= r.getRoomType() %></span>
        </div>
        <div class="bill-row">
            <span>Check-In Date</span>
            <span><%= r.getCheckInDate() %></span>
        </div>
        <div class="bill-row">
            <span>Check-Out Date</span>
            <span><%= r.getCheckOutDate() %></span>
        </div>
        <div class="bill-row">
            <span>Number of Nights</span>
            <span><%= nights %> night(s)</span>
        </div>
        <div class="bill-row">
            <span>Rate Per Night</span>
            <span>LKR <%= String.format("%.2f", r.getRoomRate()) %></span>
        </div>
    </div>

    <div class="bill-total-box">
        <div class="bill-row">
            <span>Room Charges (<%= nights %> nights × LKR <%= String.format("%.2f", r.getRoomRate()) %>)</span>
            <span>LKR <%= String.format("%.2f", total) %></span>
        </div>
        <div class="bill-row grand-total">
            <span>TOTAL AMOUNT DUE</span>
            <span>LKR <%= String.format("%.2f", total) %></span>
        </div>
    </div>

    <p style="text-align:center; margin-top:25px; color:#999; font-size:12px;">
        Thank you for staying at OceanView Hotel! We hope to see you again.
    </p>

    <div class="bill-actions">
        <button onclick="window.print()" class="btn btn-add" style="padding:10px 25px;">
            🖨️ Print Bill
        </button>
        <a href="dashboard.jsp" class="btn btn-logout" style="padding:10px 25px;">
            ← Back to Dashboard
        </a>
    </div>

</div>
</body>
</html>
