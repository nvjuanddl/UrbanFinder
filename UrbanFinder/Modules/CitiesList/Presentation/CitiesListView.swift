import SwiftUI
import MapKit

struct CitiesListView: View {    
        
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @ObservedObject var viewModel: CitiesListViewModel
    @State private var coordinate: CLLocationCoordinate2D?
    @State private var isFavorite: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                    getGridView { item in
                        viewModel.goToMap(with: item)
                    }
                } else {
                    HStack {
                        getGridView { item in
                            coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
                        }
                        Map {
                            if let coordinate {
                                Annotation("", coordinate: coordinate) {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 10, height: 10)
                                }
                            }
                        }
                    }
                }
            }
            
            if let errorMessage = viewModel.errorMessage {
                SnackbarView(
                    message: errorMessage,
                    backgroundColor: .red,
                    textColor: .white,
                    onDismiss: {
                        viewModel.errorMessage = nil
                    }
                )
                .padding(.top, 20)
                .zIndex(1)
            }
        }
        .sheet(isPresented: Binding(
            get: { viewModel.selectedCity != nil },
            set: { newValue in
                if !newValue {
                    viewModel.selectedCity = nil
                }
            }
        )) {
            if let selectedCity = viewModel.selectedCity {
                CardView(element: selectedCity, isFavorite: selectedCity.isFavorite)
                    .padding()
                    .presentationDetents([.height(100)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
    
    func getGridView(closure: @escaping (CityUi) -> Void) -> some View {
        VStack {
            HeaderSearchView(delegate: self)
            
            Button(action: {
                Task { @MainActor in
                    isFavorite.toggle()
                    await viewModel.toggleFavoriteFilter(showFavorites: isFavorite)
                }
            }) {
                Text(isFavorite ? "Show All" : "Show Favorites")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            GridView(numberOfColumns: 1, minimumItemSize: 100) {
                ForEach(viewModel.items, id: \.id) { item in
                    CardView(element: item, isFavorite: item.isFavorite, onFavoriteToggle:  {
                        Task { @MainActor in
                            await viewModel.toggleFavorite(for: item)
                        }
                    }, onInformationToggle: {
                        viewModel.setSelectedCity(with: item)
                    })
                    .onTapGesture {
                        closure(item)
                    }
                }
            }
        }
    }
}

extension CitiesListView: SearchDelegate {
    
    var placeHolder: String { return "Find your city" }
    
    func search(query: String) {
        viewModel.search(query: query)
    }
}
