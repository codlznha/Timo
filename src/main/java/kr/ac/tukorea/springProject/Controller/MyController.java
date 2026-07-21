package kr.ac.tukorea.springProject.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/my")
public class MyController {

    // 로그인 화면
    @RequestMapping("/login")
    public String login() {
        return "my/login";
    }

    // 마이페이지
    @RequestMapping("/mypage")
    public String mypage() {
        return "my/mypage";
    }


    // 회원가입 처리
    @PostMapping("/signup")
    public String signupProcess() {

        // 나중에 DB 회원가입 처리

        return "redirect:/my/login";
    }

}