package kr.ac.tukorea.springProject.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import kr.ac.tukorea.springProject.dto.ScheduleDTO;
import kr.ac.tukorea.springProject.dto.UserDTO;
import kr.ac.tukorea.springProject.repository.ScheduleMapper;
import kr.ac.tukorea.springProject.service.MainService;

@Controller
@RequestMapping("/main")
public class MainController {

	@Autowired
	private MainService mainService;

	@Autowired
	private ScheduleMapper scheduleMapper; // ✅ 반드시 추가

	@RequestMapping("")
	public String main(HttpSession session, Model model) {

		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

		// 🔥 이거 추가
		if (loginUser == null) {
			return "redirect:/my/login"; // 로그인 페이지 경로
		}
		if ("관리자".equals(loginUser.getName())) {
			return "redirect:/admin/sidebar"; // 로그인 페이지 경로
		}

		model.addAttribute("user", loginUser);

		model.addAttribute("noticeList", mainService.noticeList());
		model.addAttribute("clubList", mainService.clubList(loginUser.getId()));
		model.addAttribute("todoList", mainService.todoList(loginUser.getId()));
		model.addAttribute("scheduleList", mainService.scheduleList(loginUser.getId()));

		return "main/main";
	}

	@RequestMapping("/board")
	public String board() {
		return "main/board";
	}

	@RequestMapping("/sos")
	public String mainSos() {
		return "main/sos_board";
	}

}