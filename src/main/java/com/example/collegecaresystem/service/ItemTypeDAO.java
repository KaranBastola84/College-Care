package com.example.collegecaresystem.service;

import com.example.collegecaresystem.utils.DBConnectionUtil;
import model.ItemType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemTypeDAO {

    public List<ItemType> getAllItemTypes() throws SQLException {
        String sql = "SELECT * FROM item_types ORDER BY type_name";
        List<ItemType> itemTypes = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                ItemType type = new ItemType();
                type.setItemTypeId(rs.getInt("item_type_id"));
                type.setTypeName(rs.getString("type_name"));
                itemTypes.add(type);
            }
        }
        return itemTypes;
    }

    public boolean exists(int itemTypeId) throws SQLException {
        String sql = "SELECT item_type_id FROM item_types WHERE item_type_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, itemTypeId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
}