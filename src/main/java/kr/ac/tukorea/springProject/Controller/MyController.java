package kr.ac.tukorea.springProject.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/my")
public class MyController {

    // /my/login
    @RequestMapping("/login")
    public String login() {
        return "my/login";
    }

    // /my/mypage
    @RequestMapping("/mypage")
    public String mypage() {
        return "my/mypage";
    }
}