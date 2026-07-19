package kr.ac.tukorea.springProject.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

    // 루트 → 메인으로 리다이렉트
    @RequestMapping("/")
    public String home() {
        return "redirect:/main";
    }

    // /main
    @RequestMapping("/main")
    public String main() {
        return "main/main";
    }

    // /main/board
    @RequestMapping("/main/board")
    public String board() {
        return "main/board";
    }

    // /main/notice
    @RequestMapping("/main/notice")
    public String noticeWrite() {
        return "main/notice_write";
    }

    // /main/sos
    @RequestMapping("/main/sos")
    public String sosBoard() {
        return "main/sos_board";
    }
}