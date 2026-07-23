package kr.ac.tukorea.springProject.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.ac.tukorea.springProject.dto.ClubDTO;
import kr.ac.tukorea.springProject.dto.NoticeDTO;
import kr.ac.tukorea.springProject.dto.ScheduleDTO;
import kr.ac.tukorea.springProject.dto.TodoDTO;

@Mapper
public interface MainMapper {

    @Select("""
            SELECT *
            FROM notice_tbl
            ORDER BY id DESC
            LIMIT 5
            """)
    List<NoticeDTO> noticeList();
    
    @Select("""
    		SELECT c.*
    		FROM club_tbl c
    		JOIN club_member_link m
    		ON c.id = m.club_id
    		WHERE m.user_id = #{userId}
    		""")
    List<ClubDTO> clubList(String userId);

    @Select("""
    	    SELECT *
    	    FROM todo_tbl
    	    WHERE user_id = #{userId}
    	    ORDER BY id DESC
    	""")
    List<TodoDTO> todoList(String userId);
    
    @Select("""
    		SELECT
    		    schedule_date AS scheduleDate,
    		    title,
    		    user_id AS userId
    		FROM personal_schedule_tbl
    		WHERE user_id = #{userId}
    		ORDER BY id DESC
    """)
    List<ScheduleDTO> scheduleList(String userId);

    @Select("""
    	    SELECT *
    	    FROM club_tbl
    	    WHERE id = #{id}
    """)
    ClubDTO clubDetail(String id);
}