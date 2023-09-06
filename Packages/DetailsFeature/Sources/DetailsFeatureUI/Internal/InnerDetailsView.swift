import DetailsFeatureDomain
import SwiftUI

struct InnerDetailsView<DetailsType: Details>: View {
    @Bindable var details: DetailsType

    var body: some View {
        VStack(spacing: 0) {
            RatingView(selection: $details.rating)
                .padding()
            Divider().padding(.leading)
            NoteView(note: $details.note)
                .padding()
        }
    }
}
