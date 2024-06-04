package itwillbs.p2c3.boogimovie.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itwillbs.p2c3.boogimovie.mapper.MemberMapper;
import itwillbs.p2c3.boogimovie.vo.MailAuthInfoVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
@Service
public class MemberService {
	@Autowired
	private MemberMapper mapper;
	
	public MemberVO isCorrectUser(MemberVO inputMember) {
		
		return mapper.isCorrectMember(inputMember);
		 
	}
	
	public MemberVO memberIdSearch(MemberVO inputMember) {
		MemberVO outputMember = mapper.preRegMember(inputMember);
//		MemberVO outputMember = mapper.getMemberInfo(inputMember);
		if(outputMember == null) {
			outputMember = new MemberVO();
		}
		
		return outputMember;
	}
	
	public boolean IsRegisteredMember(MemberVO inputMember) {
		MemberVO outputMember = mapper.preRegMember(inputMember);
//		MemberVO outputMember = mapper.getMemberInfo(inputMember);
		boolean isRegistedMember = false;
		
		if(outputMember != null) {
			isRegistedMember = true;
		}
		
		
		return isRegistedMember;
	}
	
	public int regMember(MemberVO member) {
		System.out.println("service들어옴");
		
		
		
		
		return mapper.insertMember(member); 
	}
	
	public MemberVO memberPwdSearch(MemberVO inputMember) {
		System.out.println("memberPwdSearch()");
		
		return mapper.memberPwdSearch(inputMember);
	}
	
	
	
	public String movieGenreSearch(String sId) {
		
		return mapper.memberMovieGenreSearch(sId);
	}
	
	
	public MemberVO selectTheatersMyTheater(String sId) {
		
		return mapper.selectTheatersMyTheater(sId);
	}
	
	public int insertAuthInfo(MailAuthInfoVO auth_info) {
		
		return mapper.insertAuthInfo(auth_info);
	}
	
	public MailAuthInfoVO selectAuthInfo(MailAuthInfoVO auth_info) {
		return mapper.selectAuthInfo(auth_info);
	}
	
	public boolean deleteAuthInfo(MailAuthInfoVO auth_info) {
		return mapper.deleteAuthInfo(auth_info) > 0 ? true : false;
	}
	
	public boolean updateMemberPwd(MemberVO member) {
		return mapper.updateMemberPwd(member) > 0 ? true : false;
	}

	public boolean isRegistedEmail(MemberVO inputMember) {
		MemberVO outputMember = mapper.preRegMemberEmail(inputMember);
		boolean isRegistedEmail = false;
		
		if(outputMember != null) {
			isRegistedEmail = true;
		}
		
		
		return isRegistedEmail;
	}
	
}
