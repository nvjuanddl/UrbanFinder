import SwiftUI
import MapKit

struct MapView: View {
    
    @ObservedObject var viewModel: MapViewModel
    @State private var zoomLevel: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    @State private var mapPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    ))
    
    var body: some View {
        let coordinate = CLLocationCoordinate2D(latitude: viewModel.coordinate.latitude, longitude: viewModel.coordinate.longitude)
        
        ZStack {
            Map(position: $mapPosition) {
                Annotation("", coordinate: coordinate) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                }
            }
            .onAppear {
                mapPosition = .region(MKCoordinateRegion(center: coordinate, span: zoomLevel))
            }
            .mapControlVisibility(.automatic)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            zoomLevel = MKCoordinateSpan(
                                latitudeDelta: max(zoomLevel.latitudeDelta / 2, 0.0005),
                                longitudeDelta: max(zoomLevel.longitudeDelta / 2, 0.0005)
                            )
                            mapPosition = .region(MKCoordinateRegion(center: coordinate, span: zoomLevel))
                        }) {
                            Image(systemName: "plus.magnifyingglass")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                        .padding(.bottom, 8)
                        
                        Button(action: {
                            zoomLevel = MKCoordinateSpan(
                                latitudeDelta: min(zoomLevel.latitudeDelta * 2, 180),
                                longitudeDelta: min(zoomLevel.longitudeDelta * 2, 180)
                            )
                            mapPosition = .region(MKCoordinateRegion(center: coordinate, span: zoomLevel))
                        }) {
                            Image(systemName: "minus.magnifyingglass")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
