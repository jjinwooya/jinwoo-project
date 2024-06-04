package itwillbs.p2c3.boogimovie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import itwillbs.p2c3.boogimovie.vo.NoticeVO;

@Mapper
public interface NoticeMapper {
	
	List<NoticeVO> selectNoticeList(@Param("listLimit")int listLimit, @Param("startRow")int startRow, @Param("theaterName")String theaterName);

	NoticeVO selectNotice(int notice_num);

	
	//극장명과 동일한 게시판글 갯수
	int selectNoticeListCountCag(String category);
	
	//검색어를 통한 게시판목록
	List<NoticeVO> selectNoticeKeywordList(@Param("listLimit")int listLimit,
										   @Param("startRow")int startRow,
										   @Param("searchKeyword")String searchKeyword);
	//검색어를 통한 게시판목록 갯수
	int selectNoticeSearchKeywordCount(String searchKeyword);
	
	
	//극장의 번호 선택
	int selectTheaterNum(String theater_name);
	
	//게시물 수정
	int updateNotice(NoticeVO notice); 
	
}
