package com.library.dao;

import com.library.dto.Reply;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReplyDAO {

    private Connection getConnection() throws Exception {
        Class.forName("org.mariadb.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mariadb://localhost:3306/librarydb", "root", "1");
    }

    // 1. qnaId로 답글 리스트 조회
    public List<Reply> getRepliesByQnaId(int qnaId) {
        List<Reply> list = new ArrayList<>();
        String sql = "SELECT reply_id, qna_id, writer, content, reg_date FROM reply WHERE qna_id = ? ORDER BY reg_date ASC";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setInt(1, qnaId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Reply r = new Reply();
                    r.setReplyId(rs.getInt("reply_id"));
                    r.setQnaId(rs.getInt("qna_id"));
                    r.setWriter(rs.getString("writer"));
                    r.setContent(rs.getString("content"));
                    r.setRegDate(rs.getTimestamp("reg_date"));
                    list.add(r);
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 2. replyId로 단일 답글 조회
    public Reply getReplyById(int replyId) {
        Reply reply = null;
        String sql = "SELECT reply_id, qna_id, writer, content, reg_date FROM reply WHERE reply_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setInt(1, replyId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    reply = new Reply();
                    reply.setReplyId(rs.getInt("reply_id"));
                    reply.setQnaId(rs.getInt("qna_id"));
                    reply.setWriter(rs.getString("writer"));
                    reply.setContent(rs.getString("content"));
                    reply.setRegDate(rs.getTimestamp("reg_date"));
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
        }

        return reply;
    }

    // 3. 새 답글 삽입
    public boolean insertReply(Reply reply) {
        String sql = "INSERT INTO reply (qna_id, writer, content, reg_date) VALUES (?, ?, ?, NOW())";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setInt(1, reply.getQnaId());
            pstmt.setString(2, reply.getWriter());
            pstmt.setString(3, reply.getContent());
            int affected = pstmt.executeUpdate();
            return affected > 0;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 4. 답글 수정 (내용만)
    public boolean updateReply(Reply reply) {
        String sql = "UPDATE reply SET content = ? WHERE reply_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setString(1, reply.getContent());
            pstmt.setInt(2, reply.getReplyId());
            int affected = pstmt.executeUpdate();
            return affected > 0;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 5. 답글 삭제
    public boolean deleteReply(int replyId) {
        String sql = "DELETE FROM reply WHERE reply_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setInt(1, replyId);
            int affected = pstmt.executeUpdate();
            return affected > 0;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
