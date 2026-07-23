package kr.ac.tukorea.springProject.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.ac.tukorea.springProject.dto.UserDTO;

@Mapper
public interface UserMapper {

    // 회원가입
    @Insert("""
        INSERT INTO user_tbl
        (
            id,
            pwd,
            name,
            email
        )
        VALUES
        (
            #{id},
            #{pwd},
            #{name},
            #{email}
        )
        """)
    int insertUser(UserDTO user);

    // 아이디 중복 확인
    @Select("""
        SELECT COUNT(*)
        FROM user_tbl
        WHERE id = #{id}
        """)
    int countById(String id);

    // 로그인
    @Select("""
        SELECT
            id,
            pwd,
            name,
            email,
            is_out,
            created_at
        FROM user_tbl
        WHERE id = #{id}
        """)
    UserDTO selectUserById(String id);

}