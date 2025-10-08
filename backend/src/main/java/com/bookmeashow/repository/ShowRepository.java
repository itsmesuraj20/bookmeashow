package com.bookmeashow.repository;

import com.bookmeashow.model.Show;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ShowRepository extends JpaRepository<Show, Long> {
    
    @Query("SELECT s FROM Show s WHERE s.movie.id = :movieId " +
           "AND s.showTime >= :startTime AND s.showTime < :endTime " +
           "AND s.status = 'AVAILABLE' ORDER BY s.showTime")
    List<Show> findShowsByMovieAndDateRange(@Param("movieId") Long movieId,
                                             @Param("startTime") LocalDateTime startTime,
                                             @Param("endTime") LocalDateTime endTime);
    
    @Query("SELECT s FROM Show s WHERE s.movie.id = :movieId " +
           "AND s.screen.theater.city = :city " +
           "AND s.showTime >= :startTime AND s.showTime < :endTime " +
           "AND s.status = 'AVAILABLE' ORDER BY s.showTime")
    List<Show> findShowsByMovieCityAndDate(@Param("movieId") Long movieId,
                                            @Param("city") String city,
                                            @Param("startTime") LocalDateTime startTime,
                                            @Param("endTime") LocalDateTime endTime);
}
