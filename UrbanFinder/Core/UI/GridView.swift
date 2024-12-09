import SwiftUI

protocol GridViewDelegate {
    var isSearching: Bool { get }
    func more()
    func hasNext() -> Bool
}

struct GridView<Content>: View where Content: View {
        
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(minimum: minimumItemSize)), count: max(numberOfColumns, 1))
    }
        
    let numberOfColumns: Int
    let minimumItemSize: CGFloat
    let content: () -> Content
        
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                self.content()
            }
            .padding(.horizontal, 16)
        }
        .background(.white)
    }
}
