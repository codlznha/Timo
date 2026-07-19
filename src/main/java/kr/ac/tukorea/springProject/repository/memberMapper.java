package kr.ac.tukorea.springProject.repository;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.ac.tukorea.springProject.dto.memberDTO;


@Mapper
public interface memberMapper
{
	public int loginCheck(memberDTO memDTO);
	public List<memberDTO> memberList(memberDTO memDTO);
}

