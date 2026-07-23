package kr.ac.tukorea.springProject.Controller;

import java.util.List;

import jakarta.servlet.http.HttpSession;
import kr.ac.tukorea.springProject.dto.ScheduleDTO;
import kr.ac.tukorea.springProject.dto.UserDTO;
import kr.ac.tukorea.springProject.service.ScheduleService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@Controller
public class ScheduleController {

    @Autowired
    private ScheduleService scheduleService;

    // ✅ 1. 캘린더 페이지 이동 + 데이터 전달
    @GetMapping("/calendar")
    public String calendar(HttpSession session,
                           org.springframework.ui.Model model) {

        UserDTO user = (UserDTO) session.getAttribute("loginUser");

        if (user == null) {
            return "redirect:/login";
        }

        List<ScheduleDTO> list = scheduleService.getSchedule(user.getId());

        model.addAttribute("scheduleList", list);

        return "calendar"; // 👉 calendar.jsp
    }

    // ✅ 2. 일정 추가 (JSP fetch랑 연결됨)
    @PostMapping("/schedule/add")
    @ResponseBody
    public void addSchedule(@RequestBody ScheduleDTO dto,
                            HttpSession session) {

        UserDTO user = (UserDTO) session.getAttribute("loginUser");

        dto.setUserId(user.getId());

        scheduleService.insertSchedule(dto);
    }
    
    @PostMapping("/schedule/delete")
    @ResponseBody
    public void deleteSchedule(@RequestBody ScheduleDTO dto,
                               HttpSession session){

        UserDTO user=(UserDTO)session.getAttribute("loginUser");

        dto.setUserId(user.getId());

        scheduleService.deleteSchedule(dto);

    }
}