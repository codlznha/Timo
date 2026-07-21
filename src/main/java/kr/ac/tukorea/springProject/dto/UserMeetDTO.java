package kr.ac.tukorea.springProject.dto;

public class UserMeetDTO {

    private String userId;
    private int meetId;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getMeetId() {
        return meetId;
    }

    public void setMeetId(int meetId) {
        this.meetId = meetId;
    }
}