package com.ssafy.enjoytrip.review.model.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.Alias;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Alias("review")
public class Review {

    private Long id;
    private Long memberId;
    private Long roomId;
    private String content;
    private BigDecimal rating;
    private LocalDateTime createdat;
    private LocalDateTime updatedat;
}
