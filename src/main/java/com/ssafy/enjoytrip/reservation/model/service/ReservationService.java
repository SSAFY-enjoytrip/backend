package com.ssafy.enjoytrip.reservation.model.service;

import com.ssafy.enjoytrip.reservation.model.dto.request.ReservationSaveRequestDto;
import com.ssafy.enjoytrip.reservation.model.dto.request.ReviewStatusRequestDto;
import com.ssafy.enjoytrip.reservation.model.dto.response.ReservationResponseDto;
import com.ssafy.enjoytrip.reservation.model.entity.Reservation;
import java.util.List;

public interface ReservationService {

    List<ReservationResponseDto> findAllByMemberId(Long id);

    ReservationResponseDto findById(Long id);

    void checkSufficientMileage(long price, Long mileage);

    Long getReservationMileage(Long mileage);

    void save(ReservationSaveRequestDto reservationSaveRequestDto);

    void delete(Long id);

    void mapReservationDetails(ReservationSaveRequestDto reservationSaveRequestDto, Long memberId, Long roomId, long totalPrice);

    void confirm(Reservation reservation);

    boolean canWriteReview(ReviewStatusRequestDto reviewStatusRequestDto);
}
