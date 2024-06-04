package itwillbs.p2c3.boogimovie.vo;

import lombok.Data;

@Data
public class FAQVO {
	private int faq_num;
	private String faq_subject;
	private String faq_content;
	private String faq_category;
	private int faq_read_count;
}
