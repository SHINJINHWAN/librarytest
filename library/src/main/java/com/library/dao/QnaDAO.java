package com.library.dao;

import com.library.dto.Qna;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QnaDAO {

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        String url = "jdbc:mariadb://localhost:3306/librarydb";
        String user = "root";
        String password = "1";
        return DriverManager.getConnection(url, user, password);
    }

    // QnA 글 작성
    public boolean insertQna(Qna qna) {
        String sql = "INSERT INTO qna (title, content, writer, password, status, open_yn, category, reg_date, view_count) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), 0)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, qna.getTitle());
            pstmt.setString(2, qna.getContent());
            pstmt.setString(3, qna.getWriter());
            pstmt.setString(4, qna.getPassword());
            pstmt.setString(5, qna.getStatus());
            pstmt.setString(6, qna.getOpenYn());
            pstmt.setString(7, qna.getCategory());

            int affected = pstmt.executeUpdate();
            return affected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // QnA 글 1개 조회
    public Qna getQnaById(int qnaId) {
        String sql = "SELECT qna_id, title, content, writer, reg_date, status, view_count, password, open_yn, category, answer, answer_reg_date " +
                     "FROM qna WHERE qna_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, qnaId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Qna qna = new Qna();
                    qna.setQnaId(rs.getInt("qna_id"));
                    qna.setTitle(rs.getString("title"));
                    qna.setContent(rs.getString("content"));
                    qna.setWriter(rs.getString("writer"));
                    qna.setRegDate(rs.getTimestamp("reg_date"));
                    qna.setStatus(rs.getString("status"));
                    qna.setViewCount(rs.getInt("view_count"));
                    qna.setPassword(rs.getString("password"));
                    qna.setOpenYn(rs.getString("open_yn"));
                    qna.setCategory(rs.getString("category"));
                    qna.setAnswer(rs.getString("answer"));
                    qna.setAnswerRegDate(rs.getTimestamp("answer_reg_date"));
                    return qna;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // QnA 글 전체 목록 조회
    public List<Qna> getAllQnas() {
        String sql = "SELECT qna_id, title, content, writer, reg_date, status, view_count, password, open_yn, category, answer, answer_reg_date " +
                     "FROM qna ORDER BY qna_id DESC";
        List<Qna> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Qna qna = new Qna();
                qna.setQnaId(rs.getInt("qna_id"));
                qna.setTitle(rs.getString("title"));
                qna.setContent(rs.getString("content"));
                qna.setWriter(rs.getString("writer"));
                qna.setRegDate(rs.getTimestamp("reg_date"));
                qna.setStatus(rs.getString("status"));
                qna.setViewCount(rs.getInt("view_count"));
                qna.setPassword(rs.getString("password"));
                qna.setOpenYn(rs.getString("open_yn"));
                qna.setCategory(rs.getString("category"));
                qna.setAnswer(rs.getString("answer"));
                qna.setAnswerRegDate(rs.getTimestamp("answer_reg_date"));
                list.add(qna);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // QnA 글 수정
    public boolean updateQna(Qna qna) {
        String sql = "UPDATE qna SET title = ?, content = ?, status = ?, password = ?, open_yn = ?, category = ? WHERE qna_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, qna.getTitle());
            pstmt.setString(2, qna.getContent());
            pstmt.setString(3, qna.getStatus());
            pstmt.setString(4, qna.getPassword());
            pstmt.setString(5, qna.getOpenYn());
            pstmt.setString(6, qna.getCategory());
            pstmt.setInt(7, qna.getQnaId());

            int affected = pstmt.executeUpdate();
            return affected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // QnA 글 삭제
    public boolean deleteQna(int qnaId) {
        String sql = "DELETE FROM qna WHERE qna_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, qnaId);
            int affected = pstmt.executeUpdate();
            return affected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // QnA 조회수 증가
    public boolean increaseViewCount(int qnaId) {
        String sql = "UPDATE qna SET view_count = view_count + 1 WHERE qna_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, qnaId);
            int affected = pstmt.executeUpdate();
            return affected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // QnA 상태 업데이트 (예: "완료", "대기중" 등)
    public boolean updateStatus(int qnaId, String status) {
        String sql = "UPDATE qna SET status = ? WHERE qna_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, status);
            pstmt.setInt(2, qnaId);
            int affected = pstmt.executeUpdate();
            return affected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // QnA 답변 등록 또는 수정 (answer 컬럼 + answer_reg_date 업데이트)
    public boolean updateAnswer(int qnaId, String answer) {
        String sql = "UPDATE qna SET answer = ?, answer_reg_date = NOW() WHERE qna_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, answer);
            pstmt.setInt(2, qnaId);

            int affected = pstmt.executeUpdate();
            return affected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 전체 글 개수 조회 (페이징용)
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM qna";
        int count = 0;
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // 페이징 처리된 글 목록 조회
    public List<Qna> getQnaByPage(int page, int pageSize) {
        List<Qna> list = new ArrayList<>();
        String sql = "SELECT qna_id, title, content, writer, reg_date, status, view_count, password, open_yn, category, answer, answer_reg_date " +
                     "FROM qna ORDER BY qna_id DESC LIMIT ? OFFSET ?";
        int offset = (page - 1) * pageSize;

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, pageSize);
            pstmt.setInt(2, offset);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Qna qna = new Qna();
                    qna.setQnaId(rs.getInt("qna_id"));
                    qna.setTitle(rs.getString("title"));
                    qna.setContent(rs.getString("content"));
                    qna.setWriter(rs.getString("writer"));
                    qna.setRegDate(rs.getTimestamp("reg_date"));
                    qna.setStatus(rs.getString("status"));
                    qna.setViewCount(rs.getInt("view_count"));
                    qna.setPassword(rs.getString("password"));
                    qna.setOpenYn(rs.getString("open_yn"));
                    qna.setCategory(rs.getString("category"));
                    qna.setAnswer(rs.getString("answer"));
                    qna.setAnswerRegDate(rs.getTimestamp("answer_reg_date"));
                    list.add(qna);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // 검색 기능 추가 (검색 키워드와 카테고리에 따라 글 조회)
    public List<Qna> getQnasBySearch(String searchKeyword, String searchCategory, int currentPage, int pageSize) {
        List<Qna> list = new ArrayList<>();
        String sql = "SELECT qna_id, title, content, writer, reg_date, status, view_count, password, open_yn, category, answer, answer_reg_date " +
                     "FROM qna WHERE 1=1 ";

        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            sql += "AND (title LIKE ? OR content LIKE ?) ";
        }
        if (searchCategory != null && !searchCategory.isEmpty()) {
            sql += "AND category = ? ";
        }

        sql += "ORDER BY qna_id DESC LIMIT ? OFFSET ?";

        int index = 1;
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                pstmt.setString(index++, "%" + searchKeyword + "%");
                pstmt.setString(index++, "%" + searchKeyword + "%");
            }
            if (searchCategory != null && !searchCategory.isEmpty()) {
                pstmt.setString(index++, searchCategory);
            }

            pstmt.setInt(index++, (currentPage - 1) * pageSize);
            pstmt.setInt(index, pageSize);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Qna qna = new Qna();
                    qna.setQnaId(rs.getInt("qna_id"));
                    qna.setTitle(rs.getString("title"));
                    qna.setContent(rs.getString("content"));
                    qna.setWriter(rs.getString("writer"));
                    qna.setRegDate(rs.getTimestamp("reg_date"));
                    qna.setStatus(rs.getString("status"));
                    qna.setViewCount(rs.getInt("view_count"));
                    qna.setPassword(rs.getString("password"));
                    qna.setOpenYn(rs.getString("open_yn"));
                    qna.setCategory(rs.getString("category"));
                    qna.setAnswer(rs.getString("answer"));
                    qna.setAnswerRegDate(rs.getTimestamp("answer_reg_date"));
                    list.add(qna);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 검색 시 전체 글 개수 조회 (페이징용)
    public int getTotalCountBySearch(String searchKeyword, String searchCategory) {
        String sql = "SELECT COUNT(*) FROM qna WHERE 1=1 ";

        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            sql += "AND (title LIKE ? OR content LIKE ?) ";
        }
        if (searchCategory != null && !searchCategory.isEmpty()) {
            sql += "AND category = ? ";
        }

        int count = 0;
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            int index = 1;
            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                pstmt.setString(index++, "%" + searchKeyword + "%");
                pstmt.setString(index++, "%" + searchKeyword + "%");
            }
            if (searchCategory != null && !searchCategory.isEmpty()) {
                pstmt.setString(index++, searchCategory);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}
