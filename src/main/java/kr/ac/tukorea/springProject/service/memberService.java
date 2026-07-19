package kr.ac.tukorea.springProject.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.tukorea.springProject.dto.memberDTO;
import kr.ac.tukorea.springProject.repository.memberMapper;


@Service
public class memberService
{
	@Autowired
	private memberMapper memMapper;
	
	public int loginCheck(memberDTO memDTO)
	{
		return memMapper.loginCheck(memDTO);
	}
	
	public List<memberDTO> memberList(memberDTO memDTO)
	{
		return memMapper.memberList(memDTO);
	}
}
