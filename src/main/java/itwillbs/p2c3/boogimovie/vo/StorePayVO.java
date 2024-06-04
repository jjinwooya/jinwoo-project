package itwillbs.p2c3.boogimovie.vo;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class StorePayVO {
	private int store_pay_num;
	private String store_pay_type;
	private LocalDateTime store_pay_date;
	private String store_pay_status;
	private LocalDateTime store_pay_cancel_date;
	private int store_pay_price;
	private int coupon_num;
	private String member_id;
	private String merchant_uid;
	private int use_point;
	private String cart_id;
	private int save_point;
	
	//select용
	private int coupon_value;
	
	//결제내역 저장용
	private String store_pay_detail;
}
