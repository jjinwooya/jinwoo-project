package itwillbs.p2c3.boogimovie.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ScreenSessionVO {
	private int scs_num;
	private int movie_num;
	private int scs_empty_seat;
	private Date scs_date;
	private String screen_dimension;
	private int screen_num;
	
	//SELECT 용 멤버변수
	private String screen_seat_row;
	private String screen_seat_col;
	private String select_date;
	private Date current_date;
	private int theater_num;
	private int screen_cinema_num;
	
	//뷰페이지용 멤버변수
	private String scs_start_time;
	private String scs_end_time;
	private String movie_name;
	private int total_seat;
	private String theater_name;
	private String movie_poster;
}
