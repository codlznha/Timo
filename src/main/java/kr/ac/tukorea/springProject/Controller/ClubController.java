package kr.ac.tukorea.springProject.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ac.tukorea.springProject.dto.ClubDTO;
import kr.ac.tukorea.springProject.service.MainService;
import kr.ac.tukorea.springProject.service.MemberService;

@Controller
@RequestMapping("/club")
public class ClubController {

    @Autowired
    private MemberService memService;
    
    @Autowired
    private MainService mainserivce;

    @RequestMapping("/main")
    public String clubMain() {
        return "club/club_main";
    }

    @RequestMapping("/detail")
    public String clubDetail(String id, Model model) {

        ClubDTO club = mainserivce.clubDetail(id);

        model.addAttribute("club", club);

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
    
    @RequestMapping("/add")
    public String clubAdd() {
    	return "club/add_club";
    }

    @RequestMapping("/add_writing")
    public String addWriting() {
        return "club/add_writing";
    }
    
    @RequestMapping("/club_QA")
    public String clubQA() {
    	return "club/club_QA";
    }
}