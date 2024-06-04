package itwillbs.p2c3.boogimovie.mapper;

import org.apache.ibatis.annotations.Mapper;

import itwillbs.p2c3.boogimovie.vo.MailAuthInfoVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;

@Mapper
public interface MemberMapper {
	
	int insertMember(MemberVO member);
		
	MemberVO preRegMember(MemberVO member);
	
	MemberVO isCorrectMember(MemberVO member);
	
	MemberVO memberPwdSearch(MemberVO member);
	
	String memberMovieGenreSearch(String sId);
	
	MemberVO selectTheatersMyTheater(String sId);
	
	int insertAuthInfo(MailAuthInfoVO auth_info);
	
	MailAuthInfoVO selectAuthInfo(MailAuthInfoVO auth_info);
	
	int deleteAuthInfo(MailAuthInfoVO auth_info);
	
	int updateMemberPwd(MemberVO member);
//	MemberVO getMemberInfo(MemberVO member);

	MemberVO preRegMemberEmail(MemberVO inputMember);
}
