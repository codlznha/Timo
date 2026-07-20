package kr.ac.tukorea.springProject.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/main")
public class MainController {

    @RequestMapping("")
    public String main() {
        return "main/main";
    }

    @RequestMapping("/board")
    public String board() {
        return "main/board";
    }
}