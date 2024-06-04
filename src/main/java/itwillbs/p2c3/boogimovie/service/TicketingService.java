package itwillbs.p2c3.boogimovie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itwillbs.p2c3.boogimovie.mapper.TicketingMapper;
import itwillbs.p2c3.boogimovie.vo.FeeAgeVO;
import itwillbs.p2c3.boogimovie.vo.ScreenSessionVO;
import itwillbs.p2c3.boogimovie.vo.TicketVO;

@Service
public class TicketingService {
	
	@Autowired
	private TicketingMapper mapper;

	public List<ScreenSessionVO> finalListSelect(ScreenSessionVO scs) {
		return mapper.fianlListSelect(scs);
	}
	
	public ScreenSessionVO chooseSeatSelect(ScreenSessionVO scs) {
		return mapper.chooseSeatSelect(scs);
	}
	
	public Map<String, Object> feeCalc(Map<String, String> params){
		return mapper.feeCalc(params);
	}
	
	public List<FeeAgeVO> feeCalcAge(){
		return mapper.feeCalcAge();
	}

	public List<TicketVO> selectPayedSeat(int pay_num) {
		return mapper.selectPayedSeat(pay_num);
	}
	
	public List<Integer> selectPayNum(int scs_num) {
		return mapper.selectPayNum(scs_num);
	}
	
	public List<Map<String, Integer>> selectTheaterByMovie(int movie_num){
		return mapper.selectTheaterByMovie(movie_num);
	}
}	
