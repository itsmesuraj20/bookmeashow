import axiosInstance from './axios';

export interface Movie {
    id: number;
    title: string;
    description: string;
    duration: number;
    language: string;
    genre: string;
    certification: string;
    releaseDate: string;
    posterUrl: string;
    trailerUrl: string;
    director: string;
    cast: string[];
    status: 'COMING_SOON' | 'NOW_SHOWING' | 'ENDED';
    rating: number;
    totalRatings: number;
}

export const movieApi = {
    getNowShowing: async (page = 0, size = 10) => {
        const response = await axiosInstance.get<{ content: Movie[] }>('/public/movies/now-showing', {
            params: { page, size },
        });
        return response.data;
    },

    getComingSoon: async (page = 0, size = 10) => {
        const response = await axiosInstance.get<{ content: Movie[] }>('/public/movies/coming-soon', {
            params: { page, size },
        });
        return response.data;
    },

    getMovieById: async (id: number) => {
        const response = await axiosInstance.get<Movie>(`/public/movies/${id}`);
        return response.data;
    },

    searchMovies: async (keyword: string, page = 0, size = 10) => {
        const response = await axiosInstance.get<{ content: Movie[] }>('/public/movies/search', {
            params: { keyword, page, size },
        });
        return response.data;
    },
};
