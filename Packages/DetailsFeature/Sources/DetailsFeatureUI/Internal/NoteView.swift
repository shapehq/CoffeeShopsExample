import SwiftUI

struct NoteView: View {
    private enum Field: Int, CaseIterable {
        case note
    }

    @Binding var note: String?
    @FocusState private var focusedField: Field?
    private var isNoteEmpty: Bool {
        (note ?? "").isEmpty
    }

    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                TextEditor(text: Binding(get: {
                    note ?? ""
                }, set: { newValue in
                    note = !newValue.isEmpty ? newValue : nil
                }))
                .scrollContentBackground(.hidden)
                .focused($focusedField, equals: .note)
                .padding([.leading, .trailing], -6)
                .padding([.top, .bottom], -8)
                if isNoteEmpty && focusedField != .note {
                    Text("Write a note...")
                        .foregroundStyle(.secondary)
                        .allowsHitTesting(false)
                }
            }
            if focusedField == .note {
                HStack {
                    Spacer()
                    Button {
                        focusedField = nil
                    } label: {
                        Text("Done")
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}
