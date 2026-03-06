package com.oceanview.dao;

import com.oceanview.model.Reservation;
import com.oceanview.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    public boolean addReservation(Reservation r) {
        String sql = "INSERT INTO reservations (reservation_number, guest_name, address, contact_number, room_type, check_in_date, check_out_date, room_rate) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, r.getReservationNumber());
            ps.setString(2, r.getGuestName());
            ps.setString(3, r.getAddress());
            ps.setString(4, r.getContactNumber());
            ps.setString(5, r.getRoomType());
            ps.setString(6, r.getCheckInDate());
            ps.setString(7, r.getCheckOutDate());
            ps.setDouble(8, r.getRoomRate());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding reservation: " + e.getMessage());
            return false;
        }
    }

    public Reservation getReservationByNumber(String reservationNumber) {
        String sql = "SELECT * FROM reservations WHERE reservation_number = ?";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, reservationNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getInt("id"));
                r.setReservationNumber(rs.getString("reservation_number"));
                r.setGuestName(rs.getString("guest_name"));
                r.setAddress(rs.getString("address"));
                r.setContactNumber(rs.getString("contact_number"));
                r.setRoomType(rs.getString("room_type"));
                r.setCheckInDate(rs.getString("check_in_date"));
                r.setCheckOutDate(rs.getString("check_out_date"));
                r.setRoomRate(rs.getDouble("room_rate"));
                return r;
            }
        } catch (SQLException e) {
            System.out.println("Error fetching reservation: " + e.getMessage());
        }
        return null;
    }

    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations";
        try {
            Connection conn = DBConnection.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getInt("id"));
                r.setReservationNumber(rs.getString("reservation_number"));
                r.setGuestName(rs.getString("guest_name"));
                r.setAddress(rs.getString("address"));
                r.setContactNumber(rs.getString("contact_number"));
                r.setRoomType(rs.getString("room_type"));
                r.setCheckInDate(rs.getString("check_in_date"));
                r.setCheckOutDate(rs.getString("check_out_date"));
                r.setRoomRate(rs.getDouble("room_rate"));
                list.add(r);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching all reservations: " + e.getMessage());
        }
        return list;
    }

    public boolean deleteReservation(String reservationNumber) {
        String sql = "DELETE FROM reservations WHERE reservation_number = ?";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, reservationNumber);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error deleting reservation: " + e.getMessage());
            return false;
        }
    }
}
