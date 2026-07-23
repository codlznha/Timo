package kr.ac.tukorea.springProject.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;

import kr.ac.tukorea.springProject.dto.NoticeDTO;

@Mapper
public interface NoticeMapper {

    @Select("""
            SELECT
                id,
                admin_id AS adminId,
                title,
                content,
                type
            FROM notice_tbl
            ORDER BY id DESC
            """)
    List<NoticeDTO> selectAllNotices();

    @Insert("""
            INSERT INTO notice_tbl
            (
                admin_id,
                title,
                content,
                type
            )
            VALUES
            (
                #{adminId},
                #{title},
                #{content},
                #{type}
            )
            """)
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insertNotice(NoticeDTO notice);

}