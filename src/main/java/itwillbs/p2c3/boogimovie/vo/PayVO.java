package itwillbs.p2c3.boogimovie.vo;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class PayVO {

	
	private int ticket_pay_num; 
	private String ticket_pay_type;
	private LocalDateTime ticket_pay_date;
	private String ticket_pay_status;
	private LocalDateTime ticket_pay_cancel_date;
	private int ticket_pay_price; 
	private String member_id;
	private int scs_num; 
	private int coupon_num; 
	private String merchant_uid;
	private int use_point; 
	private int save_point; 
	
	
	
	
}
