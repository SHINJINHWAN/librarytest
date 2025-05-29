package com.library.dao;

import java.sql.*;
import com.library.dto.User;

public class UserDAO {
    private Connection getConnection() throws Exception {
        Class.forName("org.mariadb.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mariadb://localhost:3306/librarydb", "root", "1");
    }

    // 로그인 메서드
    public User login(String userId, String password) {
        String sql = "SELECT user_id, nickname, role FROM users WHERE user_id = ? AND password = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getString("user_id"));
                    user.setNickname(rs.getString("nickname"));
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;  // 로그인 실패
    }

    // 회원가입 처리
    public boolean insertUser(User user) {
        String sql = "INSERT INTO users (user_id, password, nickname, role) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUserId());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getNickname());
            ps.setString(4, user.getRole());
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 사용자 아이디 중복체크
    public boolean isUserExist(String userId) {
        String sql = "SELECT user_id FROM users WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();  // 존재하면 true 반환
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
