package itwillbs.p2c3.boogimovie.vo;

import java.time.LocalTime;

import lombok.Data;

@Data
public class ScreenRoundVO {
	private int round_num;
	private LocalTime start_time;
	private LocalTime end_time;
	
}
