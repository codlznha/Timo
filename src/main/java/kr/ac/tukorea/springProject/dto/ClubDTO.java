package kr.ac.tukorea.springProject.dto;

public class ClubDTO {

    private String id;
    private String longDesc;
    private String shortDesc;
    private int memberCnt;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLongDesc() {
        return longDesc;
    }

    public void setLongDesc(String longDesc) {
        this.longDesc = longDesc;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public int getMemberCnt() {
        return memberCnt;
    }

    public void setMemberCnt(int memberCnt) {
        this.memberCnt = memberCnt;
    }
}