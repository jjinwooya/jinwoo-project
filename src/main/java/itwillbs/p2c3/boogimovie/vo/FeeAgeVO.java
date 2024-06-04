package itwillbs.p2c3.boogimovie.vo;

import lombok.Data;

@Data
public class FeeAgeVO {
	private String fee_age_keyword;
	private String fee_age_info;
	private int fee_age_discount;
	
	//뷰 용 추가 ====================
	private String fee_time_keyword;
	private int fee_time_discount;
	private String fee_dimension_keyword;
	private int fee_dimension_discount;
	private String fee_day_keyword;
	private int fee_day_discount;
	
	// ===============
	private String keyword;
	private int discount;
	
	
}
