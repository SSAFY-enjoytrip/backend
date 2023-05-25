package com.ssafy.enjoytrip.review.model.dto.response;

import com.ssafy.enjoytrip.review.model.entity.Review;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ReviewResponseDto {

    private Long id;
    private Long memberId;
    private Long roomId;
    private String content;
    private BigDecimal rating;
    private LocalDateTime createdat;
    private LocalDateTime updatedat;

    public Review toEntity() {
        return Review.builder()
                     .id(this.id)
                     .memberId(this.memberId)
                     .roomId(this.roomId)
                     .content(this.content)
                     .rating(this.rating)
                     .createdat(this.createdat)
                     .updatedat(this.updatedat)
                     .build();
    }

    public static ReviewResponseDto from(Review entity) {
        return ReviewResponseDto.builder()
                                .id(entity.getId())
                                .memberId(entity.getMemberId())
                                .roomId(entity.getRoomId())
                                .content(entity.getContent())
                                .rating(entity.getRating())
                                .createdat(entity.getCreatedat())
                                .updatedat(entity.getUpdatedat())
                                .build();
    }

}
