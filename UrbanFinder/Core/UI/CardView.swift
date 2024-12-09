import SwiftUI

struct CardView: View {
    
    let element: CardViewProtocol
    let onFavoriteToggle: (() -> Void)?
    let onInformationToggle: (() -> Void)?
    @State private var isFavorite: Bool
    
    init(element: CardViewProtocol, isFavorite: Bool, onFavoriteToggle: (() -> Void)? = nil, onInformationToggle: (() -> Void)? = nil) {
        self.element = element
        self._isFavorite = State(initialValue: isFavorite)
        self.onFavoriteToggle = onFavoriteToggle
        self.onInformationToggle = onInformationToggle
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(isFavorite ? Color.blue.opacity(0.8) : Color.gray.opacity(0.8))
            
            HStack {
                VStack {
                    Text(element.headline)
                        .padding(EdgeInsets(top: 16, leading: 10, bottom: .zero, trailing: 10))
                        .lineLimit(1)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(element.subheadline)
                        .padding(EdgeInsets(top: .zero, leading: 10, bottom: 16, trailing: 10))
                        .lineLimit(1)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Button(action: {
                    isFavorite.toggle()
                    onFavoriteToggle?()
                }) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .yellow : .white)
                        .padding(8)
                }
                
                Button(action: {
                    onInformationToggle?()
                }) {
                    Image(systemName: "info.circle")
                        .foregroundColor(isFavorite ? .yellow : .white)
                        .padding(8)
                }
            }
            .cornerRadius(10)
        }
    }
}
