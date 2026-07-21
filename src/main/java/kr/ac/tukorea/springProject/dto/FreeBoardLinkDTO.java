package kr.ac.tukorea.springProject.dto;

import java.time.LocalDateTime;

public class FreeBoardLinkDTO {

    private int id;
    private int freeId;
    private String userId;
    private String comment;
    private LocalDateTime createdAt;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFreeId() {
        return freeId;
    }

    public void setFreeId(int freeId) {
        this.freeId = freeId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}