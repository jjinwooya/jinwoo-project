package itwillbs.p2c3.boogimovie.vo;

import lombok.Data;

@Data
public class ReservationVO {
	private int reservation_num;
	private String member_id;
	private int movie_num;
	private int booth_num;
	
}
