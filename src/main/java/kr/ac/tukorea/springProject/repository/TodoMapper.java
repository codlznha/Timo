package kr.ac.tukorea.springProject.repository;

import java.util.List;

import org.apache.ibatis.annotations.*;

import kr.ac.tukorea.springProject.dto.TodoDTO;

@Mapper
public interface TodoMapper {

    @Select("""
        SELECT
            id,
            user_id AS userId,
            content,
            is_done AS done,
            created_at AS createdAt
        FROM todo_tbl
        WHERE user_id = #{userId}
        ORDER BY created_at DESC
    """)
    List<TodoDTO> getTodoList(String userId);


    @Insert("""
        INSERT INTO todo_tbl(user_id, content)
        VALUES(#{userId}, #{content})
    """)
    void insertTodo(TodoDTO todo);


    @Update("""
    		UPDATE todo_tbl
    		SET is_done = #{done}
    		WHERE id = #{id}
    """)
    void updateTodo(TodoDTO dto);


    @Delete("""
        DELETE FROM todo_tbl
        WHERE id = #{id}
    """)
    void deleteTodo(int id);
}