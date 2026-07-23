package kr.ac.tukorea.springProject.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.ac.tukorea.springProject.dto.MeetDTO;
import kr.ac.tukorea.springProject.repository.MeetMapper;

@Service
public class MeetService {
    
    @Autowired
    private MeetMapper meetMapper;

    public List<MeetDTO> getMeetList() {
        return meetMapper.selectMeetList();
    }

    public void createMeet(MeetDTO meetDTO) {
        meetMapper.insertMeet(meetDTO);
    }
}