package itwillbs.p2c3.boogimovie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import itwillbs.p2c3.boogimovie.vo.EventVO;
import itwillbs.p2c3.boogimovie.vo.FeeAgeVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.NoticeVO;
import itwillbs.p2c3.boogimovie.vo.TheaterFacilityVO;
import itwillbs.p2c3.boogimovie.vo.TheaterVO;

@Mapper
public interface TheaterMapper {
	
	// 탑메뉴 또는 극장 페이지 내 탑에서 지점 선택
	TheaterVO selectTheater(TheaterVO theater);
	
	
	// 극장 상세 > theater_detail_info.jsp 에서 지점별 보유 시설 조회
	List<TheaterFacilityVO> selectFacility(TheaterFacilityVO facility);
	
	
	// 극장 상세 > theater_detail_info.jsp 에서 지점별 공지사항 조회
	List<NoticeVO> selectTheaterNoticeList(NoticeVO notice);

	//theater_num 가져오기
	int selectTheaterName(String theater_name);

	
	// 극장 메인 > theater_main.jsp 에서 극장 전체 공지사항 조회
	List<NoticeVO> selectNoticeList();
	
	
	
	List<TheaterVO> selectTheatersOrderbyName();

	
	// 관리자 > 극장 관리 페이지
	List<TheaterVO> selectTheater2();

	
	// 관리자 > 극장 수정 등록 업데이트
	int updateTheater(TheaterVO theater);

	// 관리자 > 새 극장 정보 등록
	int insertTheater(TheaterVO theater);

	// 관리자 > 극장 관리 > 극장삭제
	int deleteTheater(TheaterVO theater);

	// 극장 메인 > 극장 관련 이벤트 목록
	List<EventVO> selectTheaterEventList();

	// 극장 상세 > 요금정보 
	List<FeeAgeVO> selectFeeInfo();


	List<FeeAgeVO> selectFeeList();


	List<Map<String, Object>> getTheaterScsList(@Param("theater_num") int theater_num, @Param("scs_date") String scs_date);


	Map<String, String> getMyTheater(MemberVO member);











	
}
