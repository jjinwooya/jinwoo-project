package itwillbs.p2c3.boogimovie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itwillbs.p2c3.boogimovie.mapper.PaymentMapper;
import itwillbs.p2c3.boogimovie.vo.CartVO;
import itwillbs.p2c3.boogimovie.vo.CouponVO;
import itwillbs.p2c3.boogimovie.vo.ItemInfoVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.PayVO;
import itwillbs.p2c3.boogimovie.vo.ScreenSessionVO;
import itwillbs.p2c3.boogimovie.vo.StorePayVO;
import itwillbs.p2c3.boogimovie.vo.TicketVO;

@Service
public class PaymentService {
	
	@Autowired
	private PaymentMapper mapper;

	public MemberVO getMember(MemberVO member) {
		return mapper.getMember(member);
	}

	public int usePoint(MemberVO dbmember) {
		return mapper.usePoint(dbmember);
	}

	public void updateMemberPoint(MemberVO member) {
		mapper.updateMemberPoint(member);
	}

	public void savePayInfo(PayVO pay) {
		mapper.savePayInfo(pay);
		
	}

	public PayVO getPayInfo(String merchant_uid) {
		return mapper.getPayInfo(merchant_uid);
	}

	
	public ScreenSessionVO getScreenSession(int scs_num) {
		return mapper.getScreenSession(scs_num);
	}

	public List<PayVO> selectPayInfo(PayVO pay) {
		return mapper.selectPayInfo(pay);
	}

	public void saveTicketInfo(TicketVO ticket2) {
		mapper.saveTicketInfo(ticket2);
	}
	
	public List<StorePayVO> selectStorePayInfo(String member_id){
		return mapper.selectStorePayInfo(member_id);
	}

	public void insertCart(CartVO cart) {
		mapper.insertCart(cart);
		
	}

	public void saveStorePayInfo(StorePayVO storePay) {
		mapper.saveStorePayInfo(storePay);
		
	}

	public StorePayVO getStorePayInfo(String merchant_uid) {
		return mapper.getStorePayInfo(merchant_uid);
	}

	public List<CartVO> getCartInfo(String cart_id) {
		return mapper.getCartInfo(cart_id);
	}

	public ItemInfoVO getItemInfo(int item_info_num) {
		return mapper.getItemInfo(item_info_num);
	}

	public int updateEmptySeat(int scs_num, int totalPeople) {
		
		return mapper.updateEmptySeat(scs_num, totalPeople);
	}


	public Map<String, Object> getPaymentInfoView(int ticket_pay_num) {
		return mapper.getPaymentInfoView(ticket_pay_num);
	}

	public CouponVO getCoupon(int coupon_num) {
		return mapper.getCoupon(coupon_num);
	}

	

}
