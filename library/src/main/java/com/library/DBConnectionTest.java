package com.library;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectionTest {
    private static final String URL = "jdbc:mariadb://localhost:3306/library_qna?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
    private static final String USER = "libuser";
    private static final String PASSWORD = "libpassword";

    public static void main(String[] args) {
        System.out.println("MariaDB 연결 테스트 시작...");
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("MariaDB에 성공적으로 연결되었습니다!");
            } else {
                System.out.println("연결 실패...");
            }
        } catch (SQLException e) {
            System.out.println("연결 중 오류 발생:");
            e.printStackTrace();
        }
    }
}
