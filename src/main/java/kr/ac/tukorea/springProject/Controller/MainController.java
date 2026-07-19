package kr.ac.tukorea.springProject.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

    @RequestMapping("/")
    public String home() {
        return "main/main";
    }
    
    @RequestMapping("/main/main")
    public String main() {
        return "main/main";
    }

    @RequestMapping("/main/board")
    public String mainBoard() {
        return "main/board";
    }
}