package itwillbs.p2c3.boogimovie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itwillbs.p2c3.boogimovie.mapper.NoticeMapper;
import itwillbs.p2c3.boogimovie.vo.NoticeVO;

@Service
public class NoticeService {
	
	@Autowired
	private NoticeMapper mapper;

	public List<NoticeVO> getNoticeList(int listLimit, int startRow, String theaterName) {
		return mapper.selectNoticeList(listLimit, startRow, theaterName);
	}

	public NoticeVO getNotice(int notice_num) {
		return mapper.selectNotice(notice_num);
	}

	
	//극장명과 동일한 게시판글 갯수
	public int getNoticeListCountCag(String category) {
		return mapper.selectNoticeListCountCag(category);
	}
	
	//검색어를 통한 게시판 목록
	public List<NoticeVO> getNoticeKeywordList(int listLimit, int startRow, String searchKeyword) {
		return mapper.selectNoticeKeywordList(listLimit, startRow, searchKeyword);
	}
	
	//검색어를 통한 게시판 목록 개수
	public int getNoticeSearchKeywordCount(String searchKeyword) {
		return mapper.selectNoticeSearchKeywordCount(searchKeyword);
	}
	
	//극장번호 가져오기
	public int getTheaterNum(String theater_name) {
		return mapper.selectTheaterNum(theater_name);
	}

	public int updateNotice(NoticeVO notice) {
		return mapper.updateNotice(notice);
	}
	
}
