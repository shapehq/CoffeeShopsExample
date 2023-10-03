import SwiftUI

struct MockDetailsView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
                .background(.regularMaterial)
                .edgesIgnoringSafeArea(.all)
            Text("Mock Details")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
