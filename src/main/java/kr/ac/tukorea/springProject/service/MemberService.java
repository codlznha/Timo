package kr.ac.tukorea.springProject.service;

import java.util.List;

import kr.ac.tukorea.springProject.dto.UserDTO;

public interface MemberService {

    // 로그인
    UserDTO login(String id, String pwd);

    // 회원가입
    int insert(UserDTO dto);

    // 아이디 중복확인
    int idCheck(String id);

    // 회원 조회
    UserDTO selectOne(String id);

    // 회원 전체 조회
    List<UserDTO> selectAll();

    // 회원 수정
    int update(UserDTO dto);

    // 회원 탈퇴
    int delete(String id);

}