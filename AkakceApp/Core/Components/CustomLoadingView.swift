import SwiftUI
///Uses for the loading screen
struct CustomLoadingView: View {
    @State private var rotationAngle = 0.0
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.5)
                .ignoresSafeArea()
            VStack {
                Image(systemName: "angle")
                    .font(.system(size: 30))
                    .rotationEffect(Angle(degrees: rotationAngle))
                    .foregroundColor(Color(red: 83/255, green: 124/255, blue: 209/255))
                    .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false))
         }
        }
        .onAppear {
            rotationAngle = 360
        }
    }
}
