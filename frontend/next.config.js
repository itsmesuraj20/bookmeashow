/** @type {import('next').NextConfig} */
const nextConfig = {
  // Enable React strict mode for better development experience
  reactStrictMode: true,

  // Fast Refresh configuration for hot reload
  webpack: (config, { dev, isServer }) => {
    if (dev && !isServer) {
      config.watchOptions = {
        poll: 1000,
        aggregateTimeout: 300,
      };
    }
    return config;
  },

  images: {
    domains: ['image.tmdb.org', 'localhost'],
    remotePatterns: [
      {
        protocol: 'https',
        hostname: '**',
      },
    ],
  },
  env: {
    API_URL: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8080/api',
    WS_URL: process.env.NEXT_PUBLIC_WS_URL || 'ws://localhost:8080/ws',
  },

  // Enable experimental features for better hot reload
  experimental: {
    optimisticClientCache: true,
  },
};

module.exports = nextConfig;
