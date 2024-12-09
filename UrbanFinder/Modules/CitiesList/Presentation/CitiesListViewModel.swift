import Foundation
import Combine

final class CitiesListViewModel: ObservableObject {

    private let coordinator: CitiesListCoordinatorProtocol
    private let useCase: CitiesListUseCaseProtocol
    
    @Published var errorMessage: String?
    @Published var items: [CityUi] = []
    @Published var selectedCity: CityUi?
    var allItems: [CityUi] = []

    init(
        useCase: CitiesListUseCaseProtocol,
        coordinator: CitiesListCoordinatorProtocol
    ) {
        self.useCase = useCase
        self.coordinator = coordinator
        Task {
            await self.loadAndMarkFavoriteCitiesIfPossible()
        }
    }
        
    @MainActor
    func loadAndMarkFavoriteCitiesIfPossible() async {
        do {
            let cities = (try await useCase.getAllCitiesWithFavorites()).sorted()
            allItems = cities
            items = cities
        } catch {
            errorMessage = getErrorMessage(for: error)
        }
    }
    
    @MainActor
    func toggleFavoriteFilter(showFavorites: Bool) async {
        do {
            if showFavorites {
                items = (try await useCase.getFavoriteCities()).sorted()
            } else {
                items = allItems
            }
        } catch {
            errorMessage = getErrorMessage(for: error)
        }
    }
    
    func search(query: String) {
        guard !query.isEmpty else {
            items = allItems
            return
        }
        items = allItems.filter { city in
            city.headline.lowercased().hasPrefix(query.lowercased())
        }
    }
    
    func goToMap(with value: CityUi) {
        coordinator.navigateToCityDetail(city: value)
    }
    
    func setSelectedCity(with value: CityUi) {
        selectedCity = value
    }
    
    @MainActor
    func toggleFavorite(for city: CityUi) async {
        do {
            try await useCase.toggleFavorite(for: city)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func getErrorMessage(for error: Error) -> String {
        switch error as? NetworkServiceError {
        case .notConnectedToInternet, .networkConnectionLost:
            return "No internet connection"
        case .decodingError:
            return "Data processing failed. Please try again later."
        default:
            return "An unexpected error occurred. Please try again."
        }
    }
}

