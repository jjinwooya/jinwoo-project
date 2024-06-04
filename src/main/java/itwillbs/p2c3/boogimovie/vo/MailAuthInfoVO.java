package itwillbs.p2c3.boogimovie.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MailAuthInfoVO {
	private String member_id;
	private String auth_code;
}
