package itwillbs.p2c3.boogimovie.vo;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class NoticeVO {
	private int notice_num;
	private String notice_subject;
	private String notice_content;
	
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private LocalDateTime notice_date;
	private String notice_category;
	private int theater_num;
	private String theater_name;
	private String disable;
	private String notice_fdt;
	
	private int row_num;
	private int prev;
	private int next;
	
	
}
