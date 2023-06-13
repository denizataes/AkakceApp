import SwiftUI

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
                    .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false))
                    .foregroundColor(Color(red: 83/255, green: 124/255, blue: 209/255))            }
        }
        .onAppear {
            rotationAngle = 360
        }
    }
}
