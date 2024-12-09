import SwiftUI

protocol SearchDelegate {
    var placeHolder: String { get }
    func search(query: String)
}

struct HeaderSearchView: View {
        
    @State private var fieldTextSearch: String = ""
    @State private var isEditing: Bool = false
    @State private var isFocus: Bool = false
        
    let delegate: SearchDelegate
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.black)
                    .padding(.leading, 16)
                    .opacity(0.5)
                
                TextField(delegate.placeHolder, text: $fieldTextSearch)
                    .padding(8)
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .accentColor(Color.black)
                    .onTapGesture {
                        isFocus = true
                        isEditing = true
                    }
                    .onChange(of: fieldTextSearch) { _, _ in
                        delegate.search(query: fieldTextSearch)
                    }
                    .showClearButton($fieldTextSearch)
            }
            .background(Color.white)
            .clipShape(Capsule())
            .padding(16)
        }
        .background(Color.black)
        .onChange(of: fieldTextSearch) { _, _ in
            isEditing = !fieldTextSearch.isEmpty || isFocus
        }
    }
}

extension HeaderSearchView: SearchDelegate {
    
    var placeHolder: String {
        self.delegate.placeHolder
    }
    
    func search(query: String) {
        self.delegate.search(query: query)
    }
}
