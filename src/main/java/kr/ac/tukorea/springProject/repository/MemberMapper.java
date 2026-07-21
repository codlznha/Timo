package kr.ac.tukorea.springProject.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.ac.tukorea.springProject.dto.UserDTO;

@Mapper
public interface MemberMapper {

    // 로그인
	@Select("""
		    SELECT id, pwd, name, email, is_out, created_at
		    FROM user_tbl
		    WHERE id = #{id}
		      AND pwd = #{pwd}
	""")
    UserDTO login(@Param("id") String id,
                  @Param("pwd") String pwd);

    // 회원가입
    @Insert("""
        INSERT INTO user_tbl
        (id, pwd, name, email)
        VALUES
        (#{id}, #{pwd}, #{name}, #{email})
    """)
    int insert(UserDTO dto);

    // 아이디 중복확인
    @Select("""
        SELECT COUNT(*)
        FROM user_tbl
        WHERE id = #{id}
    """)
    int idCheck(String id);

    // 회원 한 명 조회
    @Select("""
    	    SELECT id, pwd, name, email, is_out, created_at
    	    FROM user_tbl
    	    WHERE id = #{id}
    """)
    UserDTO selectOne(String id);

    // 회원 전체 조회
    @Select("""
    	    SELECT id, pwd, name, email, is_out, created_at
    	    FROM user_tbl
    	    ORDER BY created_at DESC
    """)
    List<UserDTO> selectAll();

    // 회원 수정
    @Update("""
    	    UPDATE user_tbl
    	    SET
    	        pwd = #{pwd},
    	        name = #{name},
    	        email = #{email}
    	    WHERE id = #{id}
	""")
	int update(UserDTO dto);

    // 회원 탈퇴
    @Delete("""
        DELETE FROM user_tbl
        WHERE id = #{id}
    """)
    int delete(String id);
}