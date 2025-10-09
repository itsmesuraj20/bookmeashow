export function ComingSoon() {
    return (
        <section className="py-16 bg-white">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <h2 className="text-3xl font-bold mb-8">Coming Soon</h2>
                <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-6">
                    <div className="bg-gray-50 rounded-lg shadow-md p-4 hover:shadow-lg transition">
                        <div className="bg-gray-300 h-64 rounded-md mb-4"></div>
                        <h3 className="text-xl font-semibold mb-2">Upcoming Movie</h3>
                        <p className="text-gray-600">Releasing Soon</p>
                    </div>
                </div>
            </div>
        </section>
    );
}
