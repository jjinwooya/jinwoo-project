package itwillbs.p2c3.boogimovie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itwillbs.p2c3.boogimovie.mapper.TheaterMapper;
import itwillbs.p2c3.boogimovie.vo.EventVO;
import itwillbs.p2c3.boogimovie.vo.FeeAgeVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.NoticeVO;
import itwillbs.p2c3.boogimovie.vo.TheaterFacilityVO;
import itwillbs.p2c3.boogimovie.vo.TheaterVO;

@Service
public class TheaterService {

	
	@Autowired
	private TheaterMapper mapper;
	
	// 탑 메인 메뉴 + 극장 상단 메뉴에서 극장 상세페이지 이동시 
	public TheaterVO getTheater(TheaterVO theater) {
		return mapper.selectTheater(theater);
	}
	
	public List<TheaterVO> getTheater() {
		return mapper.selectTheater2();
	}
	
	
	// 예매 페이지에서 극장 이름별 정렬 시 사용
	public List<TheaterVO> getTheatersOrderbyName() {
		return mapper.selectTheatersOrderbyName();
	}
	
	// name으로 num가지고오기
	public int getTheaterName(String theater_name) {
		return mapper.selectTheaterName(theater_name);
	}

	// 극장 상세 > 극장별 보유시설 가져오기
	public List<TheaterFacilityVO> getFacility(TheaterFacilityVO facility) {
		return mapper.selectFacility(facility);
	}
		
	

	//  극장 상세 > 지점별 공지사항 
	public List<NoticeVO> getTheaterNoticeList(NoticeVO notice) {
		return mapper.selectTheaterNoticeList(notice);
	}


	// 극장 메인 > 극장 카테고리 공지사항 
	public List<NoticeVO> getNoticeList() {
		return mapper.selectNoticeList();
	}

	public int modifyTheater(TheaterVO theater) {
		return mapper.updateTheater(theater);
	}

	public int registTheater(TheaterVO theater) {
		return mapper.insertTheater(theater);
	}

	public int deleteTheater(TheaterVO theater) {
		return  mapper.deleteTheater(theater);
	}

	public List<EventVO> getTheaterEventList() {
		return mapper.selectTheaterEventList();
	}

	public List<FeeAgeVO> getFeeInfoList() {
		return mapper.selectFeeInfo();
	}

	public List<FeeAgeVO> getFeeList() {
		// TODO Auto-generated method stub
		return mapper.selectFeeList();
	}

	public List<Map<String, Object>> getTheaterScsList(int theater_num, String scs_date) {
		return mapper.getTheaterScsList(theater_num, scs_date);
	}

	public Map<String, String> getMyTheater(MemberVO member) {
		return mapper.getMyTheater(member);
	}

	
	
	
}
