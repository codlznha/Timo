package kr.ac.tukorea.springProject.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ac.tukorea.springProject.service.memberService;

@Controller
@RequestMapping("/club")
public class ClubController {

    @Autowired
    private memberService memService;

    @RequestMapping("/main")
    public String clubMain() {
        return "club/club_main";
    }

    @RequestMapping("/detail")
    public String clubDetail() {
        return "club/club_detail";
    }

    @RequestMapping("/board")
    public String clubBoard() {
        return "club/club_board";
    }

    @RequestMapping("/apply")
    public String clubApply() {
        return "club/club_apply";
    }

}