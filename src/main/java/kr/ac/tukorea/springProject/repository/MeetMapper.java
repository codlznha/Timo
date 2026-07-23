package kr.ac.tukorea.springProject.repository;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import kr.ac.tukorea.springProject.dto.MeetDTO;

@Mapper
public interface MeetMapper {
    List<MeetDTO> selectMeetList();
    void insertMeet(MeetDTO meetDTO);
}