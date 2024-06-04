package itwillbs.p2c3.boogimovie.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import itwillbs.p2c3.boogimovie.mapper.AdminMapper;
import itwillbs.p2c3.boogimovie.vo.CartVO;
import itwillbs.p2c3.boogimovie.vo.CouponVO;
import itwillbs.p2c3.boogimovie.vo.EventVO;
import itwillbs.p2c3.boogimovie.vo.ItemInfoVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.MovieVO;
import itwillbs.p2c3.boogimovie.vo.NoticeVO;
import itwillbs.p2c3.boogimovie.vo.OTOReplyVO;
import itwillbs.p2c3.boogimovie.vo.ReviewVO;
import itwillbs.p2c3.boogimovie.vo.ScreenInfoVO;
import itwillbs.p2c3.boogimovie.vo.ScreenSessionVO;
import itwillbs.p2c3.boogimovie.vo.StorePayVO;

@Service
public class AdminService {
	
	@Autowired
	private AdminMapper mapper;
	
	// 회원수 조회
	public int countMemberList() {
		return mapper.countMemberList();
	}
	
	// 현재상영작 수 조회
	public int movieCount() {
		return mapper.movieCount();
	}
	
	// 금일 상영건 수 조회
	public int countMoviePlan() {
		return mapper.countMoviePlan();
	}
	
	// 금일 예매 수 조회
	public int countReserve() {
		return mapper.countReserve();
	}
	
	// 월간 매출 가져오기
	public List<Map<String, String>> getMonthSales(){
		return mapper.getMonthSales();
	}
	
	//------------------------------------------------------------
	
	// 회원 리스트 조회
	public List<MemberVO> getMemberList(String searchKeyword, int startRow, int listLimit) {
		return mapper.selectMemberList(searchKeyword, startRow, listLimit);
	}

	// 회원 리스트 수 조회
	public int getMemberListCount(String searchKeyword, int startRow, int listLimit) {
		return mapper.selectMemberListCount(searchKeyword, startRow, listLimit);
	}
	
	// 회원 상세보기
	public MemberVO SelectMember(String id) {
		return mapper.selectMember(id);
	}
	
	// 회원삭제
	public int deleteMember(String id) {
		return mapper.deleteMember(id);
	}
	
	//--------------------------------------------------------------
	// 예매리스트
	public List<Map<String, String>> getReserveList(String searchKeyword, int startRow, int listLimit) {
		return mapper.selectReserveList(searchKeyword, startRow, listLimit);
	}
	// 예매리스트 수
	public int getReserveListCount(String searchKeyword, int startRow, int listLimit) {
		return mapper.selectReserveListCount(searchKeyword, startRow, listLimit);
	}
	
	// 예매 상세보기
	public Map<String, String> selectReserveDetail(int ticket_pay_num) {
		return mapper.selectReserve(ticket_pay_num);
	}
	
	// 좌석정보 가져오기
	public List<Map<String, String>> selectSeatInfo(int ticket_pay_num) {
		return mapper.selectSeatInfo(ticket_pay_num);
	}
	
	//--------------------------------------------------------------
	// 리뷰 리스트 조회
	public List<ReviewVO> getReviewList(String searchKeyword, int startRow, int listLimit) {
		return mapper.selectReviewList(searchKeyword, startRow, listLimit);
	}
	
	// 리뷰 리스트 수 조회
	public int getReviewListCount(String searchKeyword, int startRow, int listLimit) {
		return mapper.selectReviewListCount(searchKeyword, startRow, listLimit);
	}
	
	// 리뷰 삭제
	public int deleteReview(String review_num) {
		return mapper.deleteReview(review_num);
	}
	
	//--------------------------------------------------------------
	// 영화 삭제
	public int deleteMovie(String movie_num) {
		return mapper.deleteMovie(movie_num);
	}
	
	// 영화 리스트 조회
	public List<Map<String, String>> getmovieList() {
		return mapper.selectMovieList();
	}
	
	// 검색어로 영화 리스트 조회
	public List<MovieVO> searchMovieList(String searchKeyword, int startRow, int listLimit) {
		return mapper.searchMovieList(searchKeyword, startRow, listLimit);
	}

	// 영화 리스트 수 조회
	public int getMovieListCount(String searchKeyword, int startRow, int listLimit) {
		return mapper.selectMovieListCount(searchKeyword, startRow, listLimit);
	}
	
	// 영화 상세보기
	public MovieVO SelectMovie(int movie_num) {
		return mapper.selectMovie(movie_num);
	}
	
	// 영화 확인
	public MovieVO getMovie(String movie_name) {
		return mapper.getMovie(movie_name);
	}
	
	// 영화 수정 업데이트
	public int UpdateMovie(MovieVO movie) {
		return mapper.updateMovie(movie);
	}
	
	// 영화 등록
	public int InsertMovie(MovieVO movie) {
		return mapper.insertMovie(movie);
	}
	//--------------------------------------------------------------
	// 극장 이름 가져오기
	public List<Map<String, String>> getTheaterList(){
		return mapper.getTheaterList();
	}
	
	// 상영관 좌석 정보 가져오기
	public ScreenInfoVO getSeatInfo(ScreenSessionVO screenSession) {
		return mapper.getSeatInfo(screenSession);
	}
	
	// 상영관리 상영관 데이터 가져오기
	public List<ScreenInfoVO> getScreensByTheater(String theater_num) {
		return mapper.getScreensByTheater(theater_num);
	}
	
	// 상영일정 등록
	public int insertMoviePlan(ScreenSessionVO screenSession) {
		return mapper.insertMoviePlan(screenSession);
	}
	
	// 상영일정 삭제
	public int deleteMoviePlan(int scs_num) {
		return mapper.deleteMoviePlan(scs_num);
	}
	
	// 상영관 일정 가져오기
	public List<Map<String, String>> selectMoviePlanList(int startRow, int listLimit) {
		return mapper.selectMoviePlanList(startRow, listLimit);
	}

	// 상영관 일정 수 가져오기
	public int selectMoviePlanListCount(int startRow, int listLimit) {
		return mapper.selectMoviePlanListCount(startRow, listLimit);
	}
	
	// 시작, 종료시간 가져오기
	public List<Map<String, String>> getMovieTimeList(int theaterSelect, int screenSelect, Date scs_date) {
		return mapper.getMovieTimeList( theaterSelect,  screenSelect,  scs_date);
	}
	
//	// 상영조회
//	public List<ScreenSessionVO> getMoivePlanList(int theater_num, Date scs_date, int startRow, int listLimit) {
//		return mapper.getMoivePlanList(theater_num, scs_date, startRow, listLimit);
//	}
	// 상영조회
	public List<ScreenSessionVO> getMoivePlanList(int theater_num, Date scs_date, int screen_cinema_num) {
		return mapper.getMoivePlanList(theater_num, scs_date, screen_cinema_num);
	}

//	// 상영조회 수
//	public int getMoivePlanListCount(int theater_num, Date scs_date, int startRow, int listLimit) {
//		return mapper.getMoivePlanListCount(theater_num, scs_date, startRow, listLimit);
//	}
	//------------------------------------------------------------
	// 상영관 조회하기
	public List<ScreenInfoVO> getScreenInfo(String searchKeyword, int startRow, int listLimit){
		return mapper.selectScreenInfo(searchKeyword, startRow, listLimit);
	}

	// 상영관 수 조회하기
	public int getScreenInfoCount(String searchKeyword, int startRow, int listLimit){
		return mapper.selectScreenInfoCount(searchKeyword, startRow, listLimit);
	}
	
	
	//--------------------------------------------------------------
	// 쿠폰 타입 리스트 쿠폰페이지
	public List<CouponVO> getCouponTypeListSearch(String searchKeyword, int startRow, int listLimit) {
		return mapper.getCouponTypeListSearch(searchKeyword, startRow, listLimit);
	}

	// 쿠폰 수 조회
	public int getCouponListCount(String searchKeyword, int startRow, int listLimit) {
		return mapper.getCouponListCount(searchKeyword, startRow, listLimit);
	}
	// 쿠폰등록
	public int insertCoupon(CouponVO coupon) {
		return mapper.insertCoupon(coupon);
	}
	
	//쿠폰 삭제
	public int deleteCoupon(CouponVO coupon) {
		return mapper.deleteCoupon(coupon);
	}

	// 쿠폰 타입 리스트
	public List<Map<String, String>> getCouponTypeList() {
		return mapper.getCouponTypeList();
	}
	
	// 이벤트 등록
	public int InsertEvent(EventVO event) {
		return mapper.insertEvent(event);
	}
	
	// 이벤트 수정
	public int updateEvent(EventVO event) {
		return mapper.updateEvent(event);
	}
	
	// 이벤트 삭제
	public int deleteEvent(EventVO event) {
		return mapper.deleteEvent(event);
	}
	//---------------------------------------------------------------
	//공지사항 등록
	public int InsertNotice(NoticeVO notice, int theater_num) {
		return mapper.insertNotice(notice, theater_num);
	}
	//공지사항 list 가져오기
	public List<NoticeVO> getNoticeList(int startRow, int listLimit) {
		return mapper.selectNoticeList(startRow, listLimit);
	}

	public int replyRegist(OTOReplyVO reply, int oto_num) {
		return mapper.insertReply(reply, oto_num);
	}

	public int deleteNotice(int notice_num) {
		return mapper.deleteNotice(notice_num);
	}

	public int getNoticeListCount() {
		return mapper.getNoticeListCount();
	}

	public NoticeVO getNotice(NoticeVO notice) {
		return mapper.selectNotice(notice);
	}
	
	//notice 마지막 번호 가져오기
	public int getMaxNotice(NoticeVO notice) {
		return mapper.selectMaxNotice(notice);
	}
	//notice 처음 번호 가져오기
	public int getMinNotice(NoticeVO notice) {
		return mapper.selectMinNotice(notice);
	}
	
	//스토어 모든 리스트 가져오기
	public List<ItemInfoVO> getItmeListFull(){
		
		return mapper.selectItemListFull();
	}

	
	//스토어 아이템 추가전 확인
		
	public ItemInfoVO getItem(String item_info_name) {
		
		return mapper.selectItem(item_info_name);
	}
	
	//스토어 아이템 추가 
	public int insertItem(ItemInfoVO insertItem) {
		return mapper.insertItem(insertItem);
	}
	
	//스토어 아이템삭제
	public int deleteItem(String item_info_name) {
		return mapper.deleteItem(item_info_name);
	}
	// 스토어 업데이트 아이템
	public int updateItem(ItemInfoVO item) {
		return mapper.updateItem(item);
	}

	public List<StorePayVO> selectStorePay(StorePayVO store_pay, int startRow, int listLimit) {
		return mapper.selectStorePay(store_pay, startRow, listLimit);
	}

	// 결제 리스트 조회
	public List<StorePayVO> selectStorePayList(String searchKeyword, int startRow, int listLimit) {
		return mapper.selectStorePayList(searchKeyword, startRow, listLimit);
	}
	
	// 결제 리스트 수
	public int getStorePayListCount( String searchKeyword, int startRow, int listLimit) {
		return mapper.getStorePayListCount(searchKeyword, startRow, listLimit);
	}

	public StorePayVO selectStorePayDetail(int store_pay_num) {
		return mapper.selectStorePayDetail(store_pay_num);
	}

	public List<CartVO> selectCart(int store_pay_num) {
		return mapper.selectCart(store_pay_num);
	}
	
}
