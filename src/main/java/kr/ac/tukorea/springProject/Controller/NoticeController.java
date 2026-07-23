package kr.ac.tukorea.springProject.Controller;

import jakarta.servlet.http.HttpSession;
import kr.ac.tukorea.springProject.dto.NoticeDTO;
import kr.ac.tukorea.springProject.repository.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private NoticeMapper noticeMapper;

    @PostMapping("/write")
    public ResponseEntity<?> writeNotice(@RequestBody NoticeDTO notice, HttpSession session) {

        // 로그인한 관리자 ID
        String adminId = (String) session.getAttribute("adminId");

        // 아직 로그인 기능이 없으면 테스트용
        if(adminId == null){
            adminId = "admin";
        }

        notice.setAdminId(adminId);

        noticeMapper.insertNotice(notice);

        return ResponseEntity.ok().build();
    }

}