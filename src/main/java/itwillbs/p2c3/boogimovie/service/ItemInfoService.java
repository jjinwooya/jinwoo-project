package itwillbs.p2c3.boogimovie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itwillbs.p2c3.boogimovie.mapper.ItemMapper;
import itwillbs.p2c3.boogimovie.vo.ItemInfoVO;

@Service
public class ItemInfoService {
	@Autowired
	private ItemMapper mapper;
	
	public List<ItemInfoVO> getItemListSnack(){
		
		return mapper.selectItemListSnack(); 
	}
	public List<ItemInfoVO> getItemListCombo(){
		
		return mapper.selectItemListCombo(); 
	}
	public List<ItemInfoVO> getItemListPop(){
		
		return mapper.selectItemListPop(); 
	}
	public List<ItemInfoVO> getItemListJuice(){
		
		return mapper.selectItemListJuice(); 
	}
	public int getItemNum(String item_name) {
		return mapper.selectItemNum(item_name);
	}
	public String getItemImage(int item_num) {
		// TODO Auto-generated method stub
		return mapper.selectItemImage(item_num);
	}

	
	

}
