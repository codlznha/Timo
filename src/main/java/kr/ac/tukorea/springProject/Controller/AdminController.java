package kr.ac.tukorea.springProject.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    // 관리자 사이드바
    @RequestMapping("/sidebar")
    public String sidebar() {
        return "common/admin_sidebar";
    }

    // 동아리 가입 승인 확인 화면
    @RequestMapping("/add_club_check")
    public String addClubCheck() {
        return "club/add_club_check";
    }

    // 공지사항 작성 화면
    @RequestMapping("/notice_write")
    public String noticeWrite() {
        return "main/notice_write";
    }

}