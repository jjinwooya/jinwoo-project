package itwillbs.p2c3.boogimovie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import itwillbs.p2c3.boogimovie.vo.CouponVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.MovieVO;
import itwillbs.p2c3.boogimovie.vo.PayVO;
import itwillbs.p2c3.boogimovie.vo.ReservationVO;
import itwillbs.p2c3.boogimovie.vo.StorePayVO;
import itwillbs.p2c3.boogimovie.vo.TheaterVO;

@Mapper
public interface MypageMapper {
	
	// 메인페이지 id
	MemberVO selectMember (String id);
	
	// My극장 극장 전체리스트
	List<TheaterVO> selectTheater();
	
	// My극장 자주가는 영화관
	MemberVO selectMyTheater(MemberVO member);
	
	// 예매내역
    List<Map<String, Object>> selectMovieReservation(Map<String, Object> param);
	
	// 예매내역 페이징처리
	int selectResvCount(@Param("member_id") String member_id, @Param("status") String status);
	
	// 스토어
	List<StorePayVO> selectStorePay(MemberVO member);
	
	// 스토어 페이 카운트
	int selectStorePayCount(String member_id);
	
	// 취소내역 
	List<Map<String, Object>> selectCancelList(MemberVO member);
	
	// 회원정보
	MemberVO selectDbMember(MemberVO member);
	
	// 정보수정
	int updateMember(MemberVO member);
	
	// 자주가는 극장
	void updateMyTheater(@Param("checkedValues") List<String> checkedValues, @Param("member_id")String member_id, @Param("member") MemberVO member);
	
	ReservationVO selectMovieResv(String id);
	
	void updateTheater( @Param("id")String id, @Param("theater")String theater, @Param("theaterNumber")int theaterNumber);
	
	// 탈퇴처리
	int updateMemberForWithdraw(MemberVO member);
	
	// 예매취소 pay 테이블
	int updatePayStatus(@Param("member_id") String id,@Param("ticket_pay_num") int ticket_pay_num);
	
	// 예매취소 coupon 테이블
	void updateCouponStatus(@Param("member_id") String id,@Param("coupon_num") int coupon_num);
	
	// 예매취소 member 테이블
	void updateMemberPoint(PayVO pay);

	
	Integer selectCouponNum(int ticket_pay_num);

	
	PayVO selectMemberPoint(@Param("member_id") String id,@Param("ticket_pay_num") int ticket_pay_num);

	
	StorePayVO selectStorePayPoint(@Param("member_id") String id,@Param("store_pay_num") int store_pay_num);

	
	void updateMemberPointStore(StorePayVO dbStorePay);

	
	int updateStorePayStatus(@Param("member_id") String id,@Param("store_pay_num") int store_pay_num);
	
	
	
}
