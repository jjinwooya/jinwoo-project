package itwillbs.p2c3.boogimovie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import itwillbs.p2c3.boogimovie.vo.CouponVO;
import itwillbs.p2c3.boogimovie.vo.EventTypeVO;
import itwillbs.p2c3.boogimovie.vo.EventVO;

@Mapper
public interface EventMapper {

	// 관리자 이벤트 리스트 가져오기
	List<EventVO> selectEventListSearch(@Param("searchKeyword") String searchKeyword, 
										@Param("startRow") int startRow, 
										@Param("listLimit") int listLimit);
	
	// 이벤트 리스트 가져오기
	List<EventVO> selectEventList();
	
	// 이벤트 리스트 수 가져오기
	int selectEventListCount(@Param("searchKeyword") String searchKeyword, 
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);
	
	// 이벤트 가져오기
	EventVO selectEvent(int event_num);
	
	// 이벤트타입 리스트
	List<EventTypeVO> getEventTypeList();
	
	// 쿠폰 삽입
	int insertCoupon(@Param("id") String id, @Param("coupon_type_num") int coupon_type_num);
	
	// 쿠폰 발급여부 확인
	int isCouponExist(@Param("id") String id, @Param("coupon_type_num") int coupon_type_num);
}
