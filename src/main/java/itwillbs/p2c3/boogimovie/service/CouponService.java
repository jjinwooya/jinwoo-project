package itwillbs.p2c3.boogimovie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itwillbs.p2c3.boogimovie.mapper.CouponMapper;
import itwillbs.p2c3.boogimovie.vo.CouponVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;

@Service
public class CouponService {

	@Autowired
	private CouponMapper mapper;
	
	public List<CouponVO> getCoupon(MemberVO member) {
		return mapper.selectCoupon(member);
	}

	public List<CouponVO> getMemberCoupon(MemberVO member) {
		return mapper.selectMemberCoupon(member);
	}

	public void useCoupon(String coupon_num) {
		mapper.useCoupon(coupon_num);
		
	}
	
	
	
}
