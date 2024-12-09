import Foundation

final class MapViewModel: ObservableObject {
    
    var coordinate: CoordinatesUi
    var coordinator: MapViewCoordinator
    
    init(coordinate: CoordinatesUi, coordinator: MapViewCoordinator) {
        self.coordinate = coordinate
        self.coordinator = coordinator
    }
}
