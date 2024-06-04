package itwillbs.p2c3.boogimovie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import itwillbs.p2c3.boogimovie.vo.CartVO;
import itwillbs.p2c3.boogimovie.vo.CouponVO;
import itwillbs.p2c3.boogimovie.vo.ItemInfoVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.MovieVO;
import itwillbs.p2c3.boogimovie.vo.PayVO;
import itwillbs.p2c3.boogimovie.vo.ScreenSessionVO;
import itwillbs.p2c3.boogimovie.vo.StorePayVO;
import itwillbs.p2c3.boogimovie.vo.TicketVO;

@Mapper
public interface PaymentMapper {

	MemberVO getMember(MemberVO member);

	int usePoint(MemberVO member);

	void updateMemberPoint(MemberVO member);

	void savePayInfo(PayVO pay);

	PayVO getPayInfo(String merchant_uid);

	ScreenSessionVO getScreenSession(int scs_num);

	List<PayVO> selectPayInfo(PayVO pay);

	void saveTicketInfo(TicketVO ticket2);
	
	List<StorePayVO> selectStorePayInfo(String member_id);

	void insertCart(CartVO cart);

	void saveStorePayInfo(StorePayVO storePay);

	StorePayVO getStorePayInfo(String merchant_uid);

	List<CartVO> getCartInfo(String cart_id);

	ItemInfoVO getItemInfo(int item_info_num);

	int updateEmptySeat(@Param("scs_num") int scs_num,@Param("totalPeople") int totalPeople);


	Map<String, Object> getPaymentInfoView(int ticket_pay_num);

	CouponVO getCoupon(int coupon_num);
	
	
	

}
