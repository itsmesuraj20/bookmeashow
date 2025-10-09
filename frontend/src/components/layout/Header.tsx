export function Header() {
  return (
    <header className="bg-white shadow-sm sticky top-0 z-50">
      <nav className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          <div className="flex items-center">
            <h1 className="text-2xl font-bold text-purple-900">BookMeAShow</h1>
          </div>
          <div className="hidden md:flex space-x-8">
            <a href="#" className="text-gray-700 hover:text-purple-900 transition">Movies</a>
            <a href="#" className="text-gray-700 hover:text-purple-900 transition">Events</a>
            <a href="#" className="text-gray-700 hover:text-purple-900 transition">Plays</a>
          </div>
          <div className="flex items-center space-x-4">
            <button className="text-gray-700 hover:text-purple-900 transition">Sign In</button>
            <button className="bg-purple-900 text-white px-4 py-2 rounded-lg hover:bg-purple-800 transition">
              Sign Up
            </button>
          </div>
        </div>
      </nav>
    </header>
  );
}
