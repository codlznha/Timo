package kr.ac.tukorea.springProject.Controller;

import jakarta.servlet.http.HttpSession;
import kr.ac.tukorea.springProject.dto.UserDTO;
import kr.ac.tukorea.springProject.repository.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/my")
public class MyController {

    @Autowired
    private UserMapper userMapper;

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

    // =========================
    // 회원가입
    // =========================
    @PostMapping("/signup")
    public String signupProcess(@ModelAttribute UserDTO userDTO) {

        // 아이디 중복 확인
        if (userMapper.countById(userDTO.getId()) > 0) {
            return "redirect:/my/login";
        }

        // DB 저장
        userMapper.insertUser(userDTO);

        return "redirect:/my/login";
    }

    // =========================
    // 로그인
    // =========================
    @PostMapping("/login")
    public String loginProcess(@ModelAttribute UserDTO userDTO,
                               HttpSession session) {

        UserDTO loginUser = userMapper.selectUserById(userDTO.getId());

        // 아이디 없음
        if (loginUser == null) {
            return "redirect:/my/login";
        }

        // 비밀번호 확인
        if (!loginUser.getPwd().equals(userDTO.getPwd())) {
            return "redirect:/my/login";
        }

        // 탈퇴 회원 확인
        if (loginUser.isOut()) {
            return "redirect:/my/login";
        }

        // 세션 저장
        session.setAttribute("loginUser", loginUser);

        // 관리자 계정
        if ("관리자".equals(loginUser.getName())) {
            return "redirect:/admin/sidebar";
        }

        // 일반 사용자
        return "redirect:/main";
    }

    // =========================
    // 로그아웃
    // =========================
    @RequestMapping("/logout")
    public String logout(HttpSession session) {

        session.invalidate();

        return "redirect:/my/login";
    }
}