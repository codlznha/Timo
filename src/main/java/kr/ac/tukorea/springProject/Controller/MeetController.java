package kr.ac.tukorea.springProject.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/meet")
public class MeetController {

    // /meet
    @RequestMapping("")
    public String meet() {
        return "meet/meet";
    }

    // /meet/list
    @RequestMapping("/list")
    public String list() {
        return "meet/meetList";
    }

    // /meet/detail
    @RequestMapping("/detail")
    public String detail() {
        return "meet/meetDetail";
    }

    // /meet/map
    @RequestMapping("/map")
    public String map() {
        return "meet/map";
    }
}