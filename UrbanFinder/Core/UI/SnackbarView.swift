import SwiftUI

struct SnackbarView: View {
    var message: String
    var backgroundColor: Color
    var textColor: Color
    var duration: TimeInterval = 3.0
    var onDismiss: (() -> Void)?

    @State private var isVisible: Bool = false

    var body: some View {
        VStack {
            Spacer()
            if isVisible {
                Text(message)
                    .foregroundColor(textColor)
                    .padding()
                    .background(backgroundColor)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation {
                                isVisible = false
                            }
                            onDismiss?()
                        }
                    }
            }
        }
        .onAppear {
            withAnimation {
                isVisible = true
            }
        }
        .padding(.bottom, 20)
    }
}
