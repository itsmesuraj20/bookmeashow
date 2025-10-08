package com.bookmeashow.repository;

import com.bookmeashow.model.Theater;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TheaterRepository extends JpaRepository<Theater, Long> {

    List<Theater> findByCity(String city);

    @Query("SELECT DISTINCT t.city FROM Theater t ORDER BY t.city")
    List<String> findAllCities();

    @Query("SELECT t FROM Theater t WHERE t.city = :city " +
            "AND LOWER(t.name) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Theater> searchTheatersByCity(@Param("city") String city, @Param("keyword") String keyword);
}
