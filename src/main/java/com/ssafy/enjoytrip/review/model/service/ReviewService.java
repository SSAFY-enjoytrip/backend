package com.ssafy.enjoytrip.review.model.service;

import com.ssafy.enjoytrip.review.model.dto.request.ReviewSaveRequestDto;
import com.ssafy.enjoytrip.review.model.dto.response.ReviewResponseDto;
import java.util.List;

public interface ReviewService {

    List<ReviewResponseDto> findAllByRoomId(Long roomId);

    void save(ReviewSaveRequestDto reviewSaveRequestDto);

    ReviewResponseDto findById(Long id);

    void delete(Long reviewId);
}
