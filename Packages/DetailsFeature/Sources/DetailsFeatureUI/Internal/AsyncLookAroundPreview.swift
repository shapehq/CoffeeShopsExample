import MapKit
import SwiftUI

struct AsyncLookAroundPreview: View {
    let loader: () async throws -> MKLookAroundScene?

    fileprivate enum Content {
        case loading
        case lookAround(MKLookAroundScene)
        case error(Error)
        case unavailable
    }

    @State private var content: Content = .loading
    @State private var isLookAroundViewerPresented = false

    var body: some View {
        switch content {
        case .loading:
            LookAroundContentContainer {
                ProgressView()
            }
            .task {
                await loadLookAroundScene()
            }
        case .lookAround(let lookAroundScene):
            LookAroundContentContainer {
                LookAroundPreview(initialScene: lookAroundScene)
            }
            .lookAroundViewer(isPresented: $isLookAroundViewerPresented, initialScene: lookAroundScene)
        case .error(let error):
            LookAroundContentContainer {
                Text(error.localizedDescription)
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding()
            }
        case .unavailable:
            EmptyView()
        }
    }
}

private struct LookAroundContentContainer<Content: View>: View {
    private let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        ZStack {
            content()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 128)
        .background(.primary.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .padding()
    }
}

private extension AsyncLookAroundPreview {
    private func loadLookAroundScene() async {
        do {
            content = .loading
            if let lookAroundScene = try await loader() {
                content = .lookAround(lookAroundScene)
            } else {
                content = .unavailable
            }
        } catch {
            content = .error(error)
        }
    }
}
