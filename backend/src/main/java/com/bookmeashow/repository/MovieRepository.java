package com.bookmeashow.repository;

import com.bookmeashow.model.Movie;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface MovieRepository extends JpaRepository<Movie, Long> {

    Page<Movie> findByStatus(Movie.MovieStatus status, Pageable pageable);

    @Query("SELECT m FROM Movie m WHERE m.status = :status AND m.releaseDate <= :currentDate")
    Page<Movie> findNowShowing(@Param("status") Movie.MovieStatus status,
            @Param("currentDate") LocalDate currentDate,
            Pageable pageable);

    @Query("SELECT m FROM Movie m WHERE m.releaseDate > :currentDate")
    Page<Movie> findComingSoon(@Param("currentDate") LocalDate currentDate, Pageable pageable);

    @Query("SELECT m FROM Movie m WHERE LOWER(m.title) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(m.genre) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(m.language) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    Page<Movie> searchMovies(@Param("keyword") String keyword, Pageable pageable);

    List<Movie> findByLanguage(String language);

    List<Movie> findByGenre(String genre);
}
