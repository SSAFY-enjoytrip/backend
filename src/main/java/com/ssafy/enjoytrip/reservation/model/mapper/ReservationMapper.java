package com.ssafy.enjoytrip.reservation.model.mapper;

import com.ssafy.enjoytrip.reservation.model.dto.ReservationResponseDto;
import java.util.List;
import java.util.Optional;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReservationMapper {

    List<ReservationResponseDto> findAllByMemberId(Long id);

    Optional<ReservationResponseDto> findById(Long id);
}