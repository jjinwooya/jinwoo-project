package itwillbs.p2c3.boogimovie.vo;

import java.util.Date;

import lombok.Data;


@Data
public class ReviewVO {
	private int review_num;
    private int movie_num;
    private String member_id;
    private int review_rating;
    private String review_text;
    private Date review_date;
    
}
