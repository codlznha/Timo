package kr.ac.tukorea.springProject.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import kr.ac.tukorea.springProject.dto.TodoDTO;
import kr.ac.tukorea.springProject.service.TodoService;

@Controller
public class TodoController {

    @Autowired
    private TodoService todoService;

    @PostMapping("/todo/add")
    public String addTodo(String content,
                          HttpSession session) {

        String userId = (String)session.getAttribute("loginId");

        TodoDTO dto = new TodoDTO();
        dto.setUserId(userId);
        dto.setContent(content);

        todoService.addTodo(dto);

        return "redirect:/main/main";
    }
    
    @PostMapping("/todo/update")
    @ResponseBody
    public void updateTodo(int id, boolean done){

        TodoDTO dto = new TodoDTO();
        dto.setId(id);
        dto.setDone(done);

        todoService.updateTodo(dto);
    }

}