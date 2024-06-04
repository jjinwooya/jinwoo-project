package itwillbs.p2c3.boogimovie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import itwillbs.p2c3.boogimovie.vo.ItemInfoVO;

@Mapper
public interface ItemMapper {
	List<ItemInfoVO> selectItemListSnack();
	List<ItemInfoVO> selectItemListCombo();
	List<ItemInfoVO> selectItemListPop();
	List<ItemInfoVO> selectItemListJuice();
	List<ItemInfoVO> selectItemListFull();
	int selectItemNum(String item_name);
	String selectItemImage(int item_num);
	
}
