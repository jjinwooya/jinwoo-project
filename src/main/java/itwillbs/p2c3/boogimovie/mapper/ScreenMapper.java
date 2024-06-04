package itwillbs.p2c3.boogimovie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import itwillbs.p2c3.boogimovie.vo.ScreenInfoVO;

@Mapper
public interface ScreenMapper {
	
	// 전체 상영관 리스트 조회 
	List<ScreenInfoVO> selectScreenInfoList();
	
	// 상영관 정보 조회 
	ScreenInfoVO selectScreeninfo(ScreenInfoVO screenInfo);

	// 상영관 정보 수정
	int updateScreeninfo(ScreenInfoVO screenInfo);
	
	// 새 상영관 등록
	int insertScreeninfo(ScreenInfoVO screenInfo);
	
	// 상영관 정보 삭제
	int deleteScreeninfo(ScreenInfoVO screenInfo);
	
	// 조회된 극장의 cinema_num 최대값을 찾아 +1하여 새로 등록할 번호 리턴
	int selectNewCinemaNum(int theater_num);
	
	
	
	
}
