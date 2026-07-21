package kr.ac.tukorea.springProject.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import kr.ac.tukorea.springProject.dto.UserDTO;
import kr.ac.tukorea.springProject.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    // 로그인
    @PostMapping("/login")
    public String login(@ModelAttribute UserDTO dto, HttpSession session) {

        UserDTO loginUser = memberService.login(dto.getId(), dto.getPwd());

        if (loginUser != null) {
            session.setAttribute("loginUser", loginUser);
            return "redirect:/main";
        }

        return "redirect:/login";
    }

    // 회원가입
    @PostMapping("/signup")
    public String signup(@ModelAttribute UserDTO dto) {

        memberService.insert(dto);

        return "redirect:/login";
    }

    // 로그아웃
    @RequestMapping("/logout")
    public String logout(HttpSession session) {

        session.invalidate();

        return "redirect:/login";
    }
}