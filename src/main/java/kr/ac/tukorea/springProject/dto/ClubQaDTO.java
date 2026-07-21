package kr.ac.tukorea.springProject.dto;

import java.time.LocalDateTime;

public class ClubQaDTO {

    private int id;
    private String clubId;
    private String userId;
    private String content;
    private boolean isAns;
    private LocalDateTime quesTime;
    private String answer;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getClubId() {
        return clubId;
    }

    public void setClubId(String clubId) {
        this.clubId = clubId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isAns() {
        return isAns;
    }

    public void setAns(boolean ans) {
        isAns = ans;
    }

    public LocalDateTime getQuesTime() {
        return quesTime;
    }

    public void setQuesTime(LocalDateTime quesTime) {
        this.quesTime = quesTime;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }
}