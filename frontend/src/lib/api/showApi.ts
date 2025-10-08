import axiosInstance from './axios';

export interface Theater {
  id: number;
  name: string;
  address: string;
  city: string;
  state: string;
  zipCode: string;
}

export interface Show {
  id: number;
  showTime: string;
  basePrice: number;
  availableSeats: number;
  status: 'AVAILABLE' | 'FULL' | 'CANCELLED';
  theater: Theater;
  screen: {
    id: number;
    name: string;
    type: string;
  };
}

export interface Seat {
  id: number;
  rowNumber: string;
  seatNumber: string;
  type: 'STANDARD' | 'PREMIUM' | 'VIP' | 'RECLINER';
  price: number;
  status: 'AVAILABLE' | 'LOCKED' | 'BOOKED';
}

export const showApi = {
  getShowsByMovie: async (movieId: number, city: string, date: string) => {
    const response = await axiosInstance.get<Show[]>('/public/shows', {
      params: { movieId, city, date },
    });
    return response.data;
  },

  getShowById: async (showId: number) => {
    const response = await axiosInstance.get<Show>(`/public/shows/${showId}`);
    return response.data;
  },

  getSeats: async (showId: number) => {
    const response = await axiosInstance.get<Seat[]>(`/public/shows/${showId}/seats`);
    return response.data;
  },

  lockSeats: async (showId: number, seatIds: number[]) => {
    const response = await axiosInstance.post(`/shows/${showId}/lock-seats`, { seatIds });
    return response.data;
  },
};
