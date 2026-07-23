package kr.ac.tukorea.springProject.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.ac.tukorea.springProject.dto.MeetDTO;
import kr.ac.tukorea.springProject.service.MeetService;

@Controller
@RequestMapping("/meet")
public class MeetController {

    @Autowired
    private MeetService meetService;

    @GetMapping("/list")
    public String meetList(Model model) {
        // DB에서 목록을 가져와 모델에 담아 뷰로 전달
        model.addAttribute("meetList", meetService.getMeetList());
        return "meet/meetList";
    }

    @PostMapping("/create")
    public String createMeet(MeetDTO meetDTO) {
        // 폼에서 넘어온 데이터를 DB에 저장
        meetService.createMeet(meetDTO);
        // 저장이 완료되면 다시 리스트 페이지로 이동
        return "redirect:/meet/list";
    }
    
    @GetMapping("/map")
    public String clubMap() {
        return "meet/map";
    }
}