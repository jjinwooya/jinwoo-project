package itwillbs.p2c3.boogimovie.vo;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class OTOReplyVO {
	private int oto_reply_num;
	private int oto_num;
	private String oto_reply_content;
	private LocalDateTime oto_reply_date;
	
}
