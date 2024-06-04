package itwillbs.p2c3.boogimovie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import itwillbs.p2c3.boogimovie.mapper.MypageMapper;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.PayVO;
import itwillbs.p2c3.boogimovie.vo.ReservationVO;
import itwillbs.p2c3.boogimovie.vo.StorePayVO;
import itwillbs.p2c3.boogimovie.vo.TheaterVO;

@Service
public class MypageService {
	
	@Autowired
	private MypageMapper mapper;
	
	// 메인페이지 id
	public MemberVO getMember(String id) {
		System.out.println("MypageService - getMember");
		MemberVO infoMember = mapper.selectMember(id);
		return infoMember;
	}
	
	// My극장 극장 전체리스트
	public List<TheaterVO> getTheater() {
		System.out.println("MypageService - getTheater");
		List<TheaterVO> infoTheater = mapper.selectTheater();
		return infoTheater;
	}

	// My극장 자주가는 영화관
	public MemberVO getMyTheater(MemberVO member) {
		return mapper.selectMyTheater(member);
	}
	
	// 예매내역 
	public List<Map<String , Object>> getMovieReservation(Map<String, Object> param) {
		return mapper.selectMovieReservation(param);
	}
	
	public int getResvCount(String member_id, String status) {
		return mapper.selectResvCount(member_id, status);
	}
	
	// 스토어
	public List<StorePayVO> getStorePay(MemberVO member){
		return mapper.selectStorePay(member);
	}
	
	// 스토어페이 카운트
	public int getStorePayCount(String member_id) {
		return mapper.selectStorePayCount(member_id);
	}
	
	// 취소내역
	public List<Map<String, Object>> getCancelList(MemberVO member){
		return mapper.selectCancelList(member);
	}
	
	// 회원정보
	public MemberVO getDbMember(MemberVO member) {
		return mapper.selectDbMember(member);
	}
	
	// 정보수정
	public int modifyMember(MemberVO member) {
		return mapper.updateMember(member);
	}
	
	// 자주가는극장 
	@Transactional
	public void myTheater(List<String> checkedValues, String member_id, MemberVO member) {
	    System.out.println("Checked Values: " + checkedValues); // 디버깅 로그 추가

		mapper.updateMyTheater(checkedValues, member_id, member);
	}
	
	public void updateTheater(String id, String theater, int theaterNumber) {
		mapper.updateTheater(id, theater, theaterNumber);
	}
	
	public ReservationVO getMovieResv(String id) {
		System.out.println("MypageInfoService - getMovieResv");
		ReservationVO infoMovieResv = mapper.selectMovieResv(id);
		return mapper.selectMovieResv(id);
	}
	
	// 탈퇴처리
	public int withdrawMember(MemberVO member) {
		return mapper.updateMemberForWithdraw(member);
	}
	
	// 예매취소
	@Transactional
	public int removeMovie(String id,int ticket_pay_num) {
		Integer coupon_num = mapper.selectCouponNum(ticket_pay_num);
		if(coupon_num != null) {
			mapper.updateCouponStatus(id, coupon_num);
		}
		
		PayVO pay =  mapper.selectMemberPoint(id, ticket_pay_num);
		pay.setMember_id(id);
		pay.setTicket_pay_num(ticket_pay_num);
		mapper.updateMemberPoint(pay);
		return mapper.updatePayStatus(id,ticket_pay_num);
	}

	// 스토어 취소
	public int removeStore(StorePayVO storePay) {
		String id = storePay.getMember_id();
		int store_pay_num = storePay.getStore_pay_num();
		Integer coupon_num = mapper.selectCouponNum(store_pay_num);
		
		if(coupon_num != null) {
			mapper.updateCouponStatus(id, coupon_num);
		}
		
		StorePayVO dbStorePay = mapper.selectStorePayPoint(id, store_pay_num);
		dbStorePay.setMember_id(id);
		dbStorePay.setStore_pay_num(store_pay_num);
		mapper.updateMemberPointStore(dbStorePay);
		
		
		return mapper.updateStorePayStatus(id,store_pay_num);
	}
	
}
