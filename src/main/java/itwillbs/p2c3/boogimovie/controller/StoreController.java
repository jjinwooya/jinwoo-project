package itwillbs.p2c3.boogimovie.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import itwillbs.p2c3.boogimovie.service.ItemInfoService;
import itwillbs.p2c3.boogimovie.vo.CartVO;
import itwillbs.p2c3.boogimovie.vo.ItemInfoVO;

@Controller
public class StoreController {

	@Autowired
	private ItemInfoService service;

	@GetMapping("boogi_store")
	public String store(Model model, ItemInfoVO item) {
		List<ItemInfoVO> itemInfoSnack = service.getItemListSnack();
		model.addAttribute("itemInfoSnack", itemInfoSnack);
		// System.out.println("스낵들아 가즈아" +itemInfoSnack); 카테고리 스낵들 확인완료

		List<ItemInfoVO> itemInfoCombo = service.getItemListCombo();
		model.addAttribute("itemInfoCombo", itemInfoCombo);
		// System.out.println("콤보들아 가즈아" + itemInfoCombo); 카테고리 콤보들 확인완료

		List<ItemInfoVO> itemInfoPop = service.getItemListPop();
		model.addAttribute("itemInfoPop", itemInfoPop);
		// System.out.println("팝콘들아 가즈아" + itemInfoPop); 카테고리 팝콘들 확인

		List<ItemInfoVO> itemInfoJuice = service.getItemListJuice();
		model.addAttribute("itemInfoJuice", itemInfoJuice);
		// System.out.println("음료들아 가즈아" + itemInfoJuice); 카테고리 음료들 확인완료

		return "store/boogi_store";
	}
	// 스토어 장바구니 ajax관련해서 처리할꺼임.

	@PostMapping("add_to_cart")
	@ResponseBody
	public ResponseEntity<?> addToCart(@RequestBody CartVO cartItems, HttpSession session) {

		List<CartVO> cart = (List<CartVO>) session.getAttribute("cart");

		if (cart == null) {
			cart = new ArrayList<>();
			session.setAttribute("cart", cart);
		}

//		System.out.println("----- 클릭한 상품 ------");
//		System.out.println(cartItems);
//		
//		System.out.println("----- 세션안에 cart -----");
//		System.out.println(cart);

		for (CartVO existingItem : cart) {
			if (existingItem.getItem_info_num() == cartItems.getItem_info_num()) {
				Map<String, String> response = new HashMap<String, String>();
				response.put("msg", "이미 장바구니에 담은 품목입니다.");
				return ResponseEntity.status(HttpStatus.CONFLICT).body(response);
			}
		}
		// 장바구니에 상품을 추가
		cart.add(cartItems);
		// 정상적으로 추가 응딥
		return ResponseEntity.ok().body(cartItems);
	}

	// 장바구니에서 상품 제거
	@PostMapping("remove_from_cart")
	@ResponseBody
	public ResponseEntity<?> removeFromCart(@RequestParam int item_info_num, HttpSession session) {
		List<CartVO> cart = (List<CartVO>) session.getAttribute("cart");

		if (cart != null) {
			Iterator<CartVO> iterator = cart.iterator();
			while (iterator.hasNext()) {
				CartVO item = iterator.next();
				if (item.getItem_info_num() == item_info_num) {
					iterator.remove(); // 아이템 제거
					Map<String, String> response = new HashMap<String, String>();
					response.put("message", "장바구니에서 상품이 제거되었습니다.");
					return ResponseEntity.ok().body(response);
				}
			}
		}

		// 아이템이 없는 경우
		Map<String, String> response = new HashMap<String, String>();
		response.put("message", "장바구니에서 해당 상품을 찾을 수 없습니다.");
		return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
	}
}