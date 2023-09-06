import SwiftUI

struct ProfileHeaderView: View {
    let name: String
    let membership: String

    var body: some View {
        HStack {
            Image(.avatar)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title3)
                Text(membership)
                    .font(.footnote)
            }
        }
    }
}
