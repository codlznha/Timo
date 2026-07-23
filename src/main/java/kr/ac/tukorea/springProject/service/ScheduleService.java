package kr.ac.tukorea.springProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.tukorea.springProject.dto.ScheduleDTO;
import kr.ac.tukorea.springProject.repository.ScheduleMapper;



@Service
public class ScheduleService {

    @Autowired
    private ScheduleMapper mapper;

    public List<ScheduleDTO> getSchedule(String userId) {
        return mapper.getSchedule(userId);
    }

    public void insertSchedule(ScheduleDTO dto) {
        mapper.insertSchedule(dto);
    }
    
    public void deleteSchedule(ScheduleDTO dto){

        mapper.deleteSchedule(dto);

    }
}