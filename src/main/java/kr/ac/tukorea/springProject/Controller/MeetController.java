package kr.ac.tukorea.springProject.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/meet")
public class MeetController {

    @RequestMapping("/main")
    public String meet() {
        return "meet/meet";
    }

    @RequestMapping("/detail")
    public String meetDetail() {
        return "meet/detail";
    }

    @RequestMapping("/list")
    public String meetList() {
        return "meet/meetList";
    }
    
    @RequestMapping("/map")
    public String clubMap() {
    	return "meet/map";
    }

}