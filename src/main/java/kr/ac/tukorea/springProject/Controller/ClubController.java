package kr.ac.tukorea.springProject.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/club")
public class ClubController {

    // /club
    @RequestMapping("")
    public String clubMain() {
        return "club/club_main";
    }

    // /club/detail
    @RequestMapping("/detail")
    public String detail() {
        return "club/club_detail";
    }

    // /club/apply
    @RequestMapping("/apply")
    public String apply() {
        return "club/club_apply";
    }

    // /club/add
    @RequestMapping("/add")
    public String addClub() {
        return "club/add_club";
    }

    // /club/add/check
    @RequestMapping("/add/check")
    public String addClubCheck() {
        return "club/add_club_check";
    }

    // /club/write
    @RequestMapping("/write")
    public String write() {
        return "club/add_writing";
    }

    // /club/manager
    @RequestMapping("/manager")
    public String manager() {
        return "club/club_manager";
    }
}