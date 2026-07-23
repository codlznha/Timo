package kr.ac.tukorea.springProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.tukorea.springProject.dto.ClubDTO;
import kr.ac.tukorea.springProject.dto.NoticeDTO;
import kr.ac.tukorea.springProject.dto.ScheduleDTO;
import kr.ac.tukorea.springProject.dto.TodoDTO;
import kr.ac.tukorea.springProject.repository.MainMapper;
import kr.ac.tukorea.springProject.repository.TodoMapper;


@Service
public class MainService {

    @Autowired
    MainMapper mainMapper;
    
    @Autowired
    TodoMapper todoMapper;
    

    public List<NoticeDTO> noticeList(){

        return mainMapper.noticeList();

    }

    public List<ClubDTO> clubList(String userId){
        return mainMapper.clubList(userId);
    }
    
    public List<TodoDTO> todoList(String userId){
        return todoMapper.getTodoList(userId);
    }
    
    public List<ScheduleDTO> scheduleList(String userId) {
    	return mainMapper.scheduleList(userId);
    }
    
    public ClubDTO clubDetail(String id){
        return mainMapper.clubDetail(id);
    }
}