package com.ssafy.enjoytrip.review.model.dto.request;

import java.math.BigDecimal;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@ToString
public class ReviewSaveRequestDto {

    private Long id;
    private Long memberId;
    private Long roomId;
    private String content;
    private BigDecimal rating;
}
