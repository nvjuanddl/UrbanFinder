import SwiftUI

struct TextFieldClearButton: ViewModifier {
        
    @Binding var fieldText: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if !fieldText.isEmpty {
                HStack {
                    Spacer()
                    Button(action: {
                        fieldText = ""
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    .padding(.trailing, 8)
                }
            }
        }
    }
}
