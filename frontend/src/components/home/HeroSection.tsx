export function HeroSection() {
    return (
        <section className="relative bg-gradient-to-r from-purple-900 to-indigo-900 text-white py-20">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="text-center">
                    <h1 className="text-5xl md:text-6xl font-bold mb-6">
                        Book Your Show, Anytime, Anywhere
                    </h1>
                    <p className="text-xl md:text-2xl mb-8 text-gray-200">
                        Experience the best movies in town with BookMeAShow
                    </p>
                    <div className="flex justify-center gap-4">
                        <button className="bg-white text-purple-900 px-8 py-3 rounded-lg font-semibold hover:bg-gray-100 transition">
                            Explore Movies
                        </button>
                        <button className="border-2 border-white px-8 py-3 rounded-lg font-semibold hover:bg-white hover:text-purple-900 transition">
                            Sign Up
                        </button>
                    </div>
                </div>
            </div>
        </section>
    );
}
