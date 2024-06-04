package itwillbs.p2c3.boogimovie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import itwillbs.p2c3.boogimovie.mapper.EventMapper;
import itwillbs.p2c3.boogimovie.vo.CouponVO;
import itwillbs.p2c3.boogimovie.vo.EventTypeVO;
import itwillbs.p2c3.boogimovie.vo.EventVO;

@Service
public class EventService {

	@Autowired
	private EventMapper mapper;
	// 관리자 리스트 조회
	public List<EventVO> getEventListSearch(String searchKeyword, int startRow, int listLimit) {
		return mapper.selectEventListSearch(searchKeyword, startRow, listLimit);
	}

	// 이벤트 페이지 리스트 조회
	public List<EventVO> getEventList() {
		return mapper.selectEventList();
	}

	public int getEventListCount(String searchKeyword, int startRow, int listLimit) {
		return mapper.selectEventListCount(searchKeyword, startRow, listLimit);
	}
	
	public EventVO getEvent(int event_num) {
		
		return mapper.selectEvent(event_num);
	}
	
	public List<EventTypeVO> getEventTypeList() {
		return mapper.getEventTypeList();
	}
	
	public int insertCoupon(String id, int coupon_type_num) {
		return mapper.insertCoupon(id, coupon_type_num);
	}
	
	public int isCouponExist(String id, int coupon_type_num) {
		return mapper.isCouponExist(id, coupon_type_num);
	}
}
