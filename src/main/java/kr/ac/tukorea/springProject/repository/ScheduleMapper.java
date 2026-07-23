package kr.ac.tukorea.springProject.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;

import kr.ac.tukorea.springProject.dto.ScheduleDTO;

@Mapper
public interface ScheduleMapper {

    // 🔥 전체 일정 조회 (findAll)
    @Select("""
        SELECT 
            schedule_date AS date,
            title,
            user_id AS userId
        FROM personal_schedule_tbl
        ORDER BY schedule_date
    """)
    List<ScheduleDTO> findAll();


    // 🔥 유저별 일정 조회
    @Select("""
    	    SELECT
    	        schedule_date AS schedule_date,
    	        title AS title,
    	        user_id AS userId
    	    FROM personal_schedule_tbl
    	    WHERE user_id = #{userId}
    	    ORDER BY schedule_date
    	""")
    	List<ScheduleDTO> getSchedule(String userId);


    // 🔥 일정 추가
    @Insert("""
        INSERT INTO personal_schedule_tbl(schedule_date, title, user_id)
        VALUES(#{scheduleDate}, #{title}, #{userId})
    """)
    void insertSchedule(ScheduleDTO dto);
    
    @Delete("""
    		DELETE
    		FROM personal_schedule_tbl
    		WHERE user_id=#{userId}
    		AND schedule_date=#{scheduleDate}
    		AND title=#{title}
    """)
    void deleteSchedule(ScheduleDTO dto);
}