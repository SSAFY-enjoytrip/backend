package com.ssafy.enjoytrip.review.controller;

import com.ssafy.enjoytrip.global.exception.ErrorCode;
import com.ssafy.enjoytrip.member.exception.MemberException;
import com.ssafy.enjoytrip.member.model.entity.Member;
import com.ssafy.enjoytrip.review.model.dto.request.ReviewSaveRequestDto;
import com.ssafy.enjoytrip.review.model.dto.response.ReviewResponseDto;
import com.ssafy.enjoytrip.review.model.entity.Review;
import com.ssafy.enjoytrip.review.model.service.ReviewService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/review")
@RestController
public class ReviewController {

    private final ReviewService reviewService;

    @GetMapping("/{roomId}")
    public ResponseEntity<List<ReviewResponseDto>> getReviewsByRoomId(@PathVariable("roomId") Long roomId, @AuthenticationPrincipal Member member) {

        log.info("getReviewsByRoomId - GET");

        return ResponseEntity.ok().body(reviewService.findAllByRoomId(roomId));
    }

    @PostMapping("/{roomId}")
    public ResponseEntity<ReviewResponseDto> saveReview(@PathVariable("roomId") Long roomId, @AuthenticationPrincipal Member member, @RequestBody ReviewSaveRequestDto reviewSaveRequestDto) {

        log.info("'{}' 회원 '{}' 번 숙소에 리뷰 작성 요청 - saveReview", member.getLoginId(), roomId);

        reviewService.save(reviewSaveRequestDto);
        Long reviewId = reviewSaveRequestDto.getId();

        return ResponseEntity.ok().body(reviewService.findById(reviewId));
    }

    @DeleteMapping("/{reviewId}")
    public ResponseEntity<String> deleteReview(@PathVariable("reviewId") Long reviewId, @AuthenticationPrincipal Member member) {

        log.info("'{}' 회원 '{}'번 리뷰에 대해 삭제 요청 - deleteReview", member.getLoginId(), reviewId);

        Review review = reviewService.findById(reviewId).toEntity();

        if(review.getMemberId() != member.getId()) {
            throw new MemberException(ErrorCode.UNAUTHORIZED, ErrorCode.UNAUTHORIZED.getMessage());
        }

        reviewService.delete(reviewId);

        return ResponseEntity.ok().body("리뷰가 삭제되었습니다.");
    }

}
