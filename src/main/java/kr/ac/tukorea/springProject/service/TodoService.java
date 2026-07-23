package kr.ac.tukorea.springProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.tukorea.springProject.dto.TodoDTO;
import kr.ac.tukorea.springProject.repository.TodoMapper;

@Service
public class TodoService {

    @Autowired
    private TodoMapper todoMapper;

    public List<TodoDTO> getTodoList(String userId){
        return todoMapper.getTodoList(userId);
    }

    public void addTodo(TodoDTO todo){
        todoMapper.insertTodo(todo);
    }

    public void updateTodo(TodoDTO todo){
        todoMapper.updateTodo(todo);
    }

    public void deleteTodo(int id){
        todoMapper.deleteTodo(id);
    }

}