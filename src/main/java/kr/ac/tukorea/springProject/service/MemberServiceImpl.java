package kr.ac.tukorea.springProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.tukorea.springProject.dto.UserDTO;
import kr.ac.tukorea.springProject.repository.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberMapper mapper;

    @Override
    public UserDTO login(String id, String pwd) {
        return mapper.login(id, pwd);
    }

    @Override
    public int insert(UserDTO dto) {
        return mapper.insert(dto);
    }

    @Override
    public int idCheck(String id) {
        return mapper.idCheck(id);
    }

    @Override
    public UserDTO selectOne(String id) {
        return mapper.selectOne(id);
    }

    @Override
    public List<UserDTO> selectAll() {
        return mapper.selectAll();
    }

    @Override
    public int update(UserDTO dto) {
        return mapper.update(dto);
    }

    @Override
    public int delete(String id) {
        return mapper.delete(id);
    }
}