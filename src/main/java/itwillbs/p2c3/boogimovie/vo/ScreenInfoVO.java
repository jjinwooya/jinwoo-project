package itwillbs.p2c3.boogimovie.vo;

import lombok.Data;

@Data
public class ScreenInfoVO {
	
	private int screen_num;
	private int theater_num;
	private int screen_cinema_num;
	private String screen_seat_row;
	private String screen_seat_col;
	private int screen_status;
	
	// -----------------------------
	private String theater_name;
	private int seat_size;	
	
	
}
