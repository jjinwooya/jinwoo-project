package itwillbs.p2c3.boogimovie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import itwillbs.p2c3.boogimovie.vo.ReviewVO;

@Mapper
public interface ReviewMapper {

	int insertReview(ReviewVO review);
	List<ReviewVO> selectReviewList(@Param("movie_num")int movie_num,  @Param("startRow")int startRow, @Param("listLimit")int listLimit);
	ReviewVO selectReviewId(int review_num);
	int updateReview(ReviewVO review2);
	int deleteReview(int review_num);
	int countReviews(@Param("movie_num") int movie_num);
	
	List<ReviewVO> selectMemberReview(@Param("member_id") String member_id, @Param("movie_num")int movie_num);
	
}
