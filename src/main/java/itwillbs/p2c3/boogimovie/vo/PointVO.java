package itwillbs.p2c3.boogimovie.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PointVO {
    private int points;
    private int usePoints;
    private LocalDateTime date;
    private String type;
    private String theater;
}
