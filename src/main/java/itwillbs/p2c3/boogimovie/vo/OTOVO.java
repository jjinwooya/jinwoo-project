package itwillbs.p2c3.boogimovie.vo;

import java.time.LocalDateTime;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class OTOVO {
	private int oto_num;
	private int theater_num;
	private String oto_subject;
	private String oto_content;
	private String member_id;
	private String oto_category;
	private String oto_reply_status;
	private LocalDateTime oto_date;
	private String oto_file1;
	private String oto_file2;
	
	private MultipartFile file1;
	private MultipartFile file2;
	
	private String theater_name;
	
	
	
	
}
