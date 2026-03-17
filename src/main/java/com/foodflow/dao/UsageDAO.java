package com.foodflow.dao;

import com.foodflow.config.DatabaseConfig;
import com.foodflow.model.Usage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class UsageDAO {

    public boolean addUsage(Usage usage) {
        String insertSql = "INSERT INTO issue_transactions (item_id, quantity_issued, issued_date, issued_by, issued_to) VALUES (?, ?, ?, ?, ?)";
        String stockSql = "UPDATE items SET stock = stock - ?, status = CASE WHEN stock - ? <= 0 THEN 'OUT_OF_STOCK' ELSE 'AVAILABLE' END WHERE item_id = ? AND stock >= ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement insertStmt = conn.prepareStatement(insertSql);
             PreparedStatement stockStmt = conn.prepareStatement(stockSql)) {
            conn.setAutoCommit(false);
            insertStmt.setInt(1, usage.getItemId());
            insertStmt.setDouble(2, usage.getQuantity());
            insertStmt.setTimestamp(3, Timestamp.valueOf(LocalDateTime.of(usage.getDate(), java.time.LocalTime.NOON)));
            if (usage.getRecordedBy() == null || usage.getRecordedBy() <= 0) {
                insertStmt.setNull(4, java.sql.Types.INTEGER);
            } else {
                insertStmt.setInt(4, usage.getRecordedBy());
            }
            insertStmt.setString(5, usage.getIssuedTo() == null || usage.getIssuedTo().isBlank() ? "Internal Department" : usage.getIssuedTo());
            insertStmt.executeUpdate();

            stockStmt.setDouble(1, usage.getQuantity());
            stockStmt.setDouble(2, usage.getQuantity());
            stockStmt.setInt(3, usage.getItemId());
            stockStmt.setDouble(4, usage.getQuantity());
            if (stockStmt.executeUpdate() == 0) {
                conn.rollback();
                return false;
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Usage> getAllUsage() {
        String sql = "SELECT it.*, i.name AS item_name, u.name AS issued_by_name " +
                "FROM issue_transactions it JOIN items i ON it.item_id = i.item_id " +
                "LEFT JOIN users u ON it.issued_by = u.user_id ORDER BY it.issued_date DESC";
        List<Usage> usageList = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                usageList.add(mapResultSetToUsage(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usageList;
    }

    private Usage mapResultSetToUsage(ResultSet rs) throws SQLException {
        Usage usage = new Usage();
        usage.setUsageId(rs.getInt("issue_id"));
        usage.setItemId(rs.getInt("item_id"));
        usage.setItemName(rs.getString("item_name"));
        usage.setQuantity(rs.getDouble("quantity_issued"));
        usage.setQuantityReturned(0);
        int issuedBy = rs.getInt("issued_by");
        usage.setRecordedBy(rs.wasNull() ? null : issuedBy);
        usage.setIssuedTo(rs.getString("issued_to"));
        usage.setItemUserName(rs.getString("issued_by_name"));
        Timestamp timestamp = rs.getTimestamp("issued_date");
        if (timestamp != null) {
            usage.setDate(timestamp.toLocalDateTime().toLocalDate());
        }
        usage.setStatus(Usage.Status.ISSUED);
        return usage;
    }
}
