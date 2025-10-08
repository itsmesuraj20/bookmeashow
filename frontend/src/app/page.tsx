import { HeroSection } from '@/components/home/HeroSection';
import { NowShowing } from '@/components/home/NowShowing';
import { ComingSoon } from '@/components/home/ComingSoon';
import { Header } from '@/components/layout/Header';
import { Footer } from '@/components/layout/Footer';

export default function Home() {
    return (
        <main className="min-h-screen">
            <Header />
            <HeroSection />
            <NowShowing />
            <ComingSoon />
            <Footer />
        </main>
    );
}
