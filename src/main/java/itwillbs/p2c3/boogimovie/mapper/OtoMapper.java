package itwillbs.p2c3.boogimovie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import itwillbs.p2c3.boogimovie.vo.OTOReplyVO;
import itwillbs.p2c3.boogimovie.vo.OTOVO;

@Mapper
public interface OtoMapper {
	
	int selectTheaterNum(String theater_name);

	int insertOto(@Param("oto")OTOVO oto,
				  @Param("theater_num")int theater_num,
				  @Param("id")String id);

	List<OTOVO> selectOtoList(@Param("startRow")int startRow, 
							  @Param("listLimit")int listLimit,
							  @Param("faqCategory")String faqCategory,
							  @Param("theaterName")String theaterName,
							  @Param("id")String id);

	OTOVO selectOto(int oto_num);

	String selectTheaterName(int theater_num);
	
	//1대1 문의 수정
	int updateOto(OTOVO oto);
	
	//1대1 문의 삭제
	int deleteOto(int oto_num);
	
	//1대1 문의 '미답' -> '답변' 수정
	int updateResponse(int oto_num);
	
	//1대1 문의 유형에 따른 갯수
	int getOtoListCount(@Param("faqCategory")String faqCategory,
						@Param("theaterName")String theaterName,
						@Param("id")String id);
	
	//1대1 문의 파일 삭제
	int deleteOtoFile(OTOVO oto);
	
	//1대1 문의에 대한 답변 가져오기
	OTOReplyVO selectOtoReply(int oto_num);

	int updateOtoContent(OTOReplyVO reply);
}
