package com.ssafy.enjoytrip.review.model.service;

import com.ssafy.enjoytrip.review.model.dto.request.ReviewSaveRequestDto;
import com.ssafy.enjoytrip.review.model.dto.response.ReviewResponseDto;
import com.ssafy.enjoytrip.review.model.mapper.ReviewMapper;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class ReviewServiceImpl implements ReviewService {

    private final ReviewMapper reviewMapper;

    @Transactional(readOnly = true)
    @Override
    public List<ReviewResponseDto> findAllByRoomId(Long roomId) {

        return reviewMapper.findAllByRoomId(roomId)
                           .stream()
                           .map(ReviewResponseDto::from)
                           .collect(
                               Collectors.toList());
    }

    @Transactional
    @Override
    public void save(ReviewSaveRequestDto reviewSaveRequestDto) {

        reviewMapper.save(reviewSaveRequestDto);
    }

    @Transactional(readOnly = true)
    @Override
    public ReviewResponseDto findById(Long id) {

        return ReviewResponseDto.from(reviewMapper.findById(id));
    }

    @Transactional
    @Override
    public void delete(Long reviewId) {

        reviewMapper.delete(reviewId);
    }
}
