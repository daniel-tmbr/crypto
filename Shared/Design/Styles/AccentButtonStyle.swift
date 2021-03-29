import SwiftUI

struct AccentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.accent.opacity(configuration.isPressed ? 0.7 : 1))
    }
}

struct AccentButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Accent button") {
            print("Accent button touched")
        }
    }
}
