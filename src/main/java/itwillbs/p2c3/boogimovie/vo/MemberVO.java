package itwillbs.p2c3.boogimovie.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberVO {
	private String member_id;
	private String member_name;
	private String member_pwd;
	private String member_email;
	private String member_tel;
	private String member_addr;
	private String member_movie_genre;
	private String member_status;
	private int member_point;
	private String member_birth;
	private Date member_reg_date;
	private Date member_withdraw_date;
	private String member_my_theater1;
	private String member_my_theater2;
	private String member_my_theater3;
	
	private String member_post_code;
	private String member_address1;
	private String member_address2;
		
}
