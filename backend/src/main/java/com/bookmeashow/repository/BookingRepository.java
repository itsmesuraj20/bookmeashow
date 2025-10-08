package com.bookmeashow.repository;

import com.bookmeashow.model.Booking;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {
    
    Optional<Booking> findByBookingReference(String bookingReference);
    
    Page<Booking> findByUserId(Long userId, Pageable pageable);
    
    Page<Booking> findByUserIdAndStatus(Long userId, Booking.BookingStatus status, Pageable pageable);
}
