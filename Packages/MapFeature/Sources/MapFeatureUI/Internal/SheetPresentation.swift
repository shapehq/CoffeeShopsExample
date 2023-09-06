import SwiftUI

extension View {
    func sheetPresentation<Item, SheetView: View>(
        presentedItem: Binding<Item?>,
        detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
        largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = nil,
        prefersGrabberVisible: Bool = true,
        prefersScrollingExpandsWhenScrolledToEdge: Bool = false,
        preferredCornerRadius: CGFloat = 20,
        @ViewBuilder sheetView: @escaping (Item) -> SheetView,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        modifier(
            SheetPresentationViewModifier(
                presentedItem: presentedItem,
                detents: detents,
                largestUndimmedDetentIdentifier: largestUndimmedDetentIdentifier,
                prefersGrabberVisible: prefersGrabberVisible,
                prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge,
                preferredCornerRadius: preferredCornerRadius,
                sheetView: sheetView,
                onDismiss: onDismiss
            )
        )
    }
}

private struct SheetPresentationViewModifier<Item, SheetView: View>: ViewModifier {
    private let presentedItem: Binding<Item?>
    private let detents: [UISheetPresentationController.Detent]
    private let largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    private let prefersGrabberVisible: Bool
    private let prefersScrollingExpandsWhenScrolledToEdge: Bool
    private let preferredCornerRadius: CGFloat
    private let sheetView: (Item) -> SheetView
    private let onDismiss: (() -> Void)?

    init(
        presentedItem: Binding<Item?>,
        detents: [UISheetPresentationController.Detent],
        largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?,
        prefersGrabberVisible: Bool,
        prefersScrollingExpandsWhenScrolledToEdge: Bool,
        preferredCornerRadius: CGFloat,
        @ViewBuilder sheetView: @escaping (Item) -> SheetView,
        onDismiss: (() -> Void)? = nil
    ) {
        self.presentedItem = presentedItem
        self.detents = detents
        self.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        self.prefersGrabberVisible = prefersGrabberVisible
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        self.preferredCornerRadius = preferredCornerRadius
        self.sheetView = sheetView
        self.onDismiss = onDismiss
    }

    func body(content: Content) -> some View {
        content.background(
            SheetPresentationController(
                presentedItem: presentedItem,
                detents: detents,
                largestUndimmedDetentIdentifier: largestUndimmedDetentIdentifier,
                prefersGrabberVisible: prefersGrabberVisible,
                prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge,
                preferredCornerRadius: preferredCornerRadius,
                sheetView: sheetView,
                onDismiss: onDismiss
            )
        )
    }
}

private struct SheetPresentationController<Item, SheetView: View>: UIViewControllerRepresentable {
    private let viewController = UIViewController()

    @Binding private var presentedItem: Item?
    private let detents: [UISheetPresentationController.Detent]
    private let largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    private let prefersGrabberVisible: Bool
    private let prefersScrollingExpandsWhenScrolledToEdge: Bool
    private let preferredCornerRadius: CGFloat
    private let sheetView: (Item) -> SheetView
    private var onDismiss: (() -> Void)?

    init(
        presentedItem: Binding<Item?>,
        detents: [UISheetPresentationController.Detent],
        largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?,
        prefersGrabberVisible: Bool,
        prefersScrollingExpandsWhenScrolledToEdge: Bool,
        preferredCornerRadius: CGFloat,
        sheetView: @escaping (Item) -> SheetView,
        onDismiss: (() -> Void)? = nil
    ) {
        self._presentedItem = presentedItem
        self.detents = detents
        self.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        self.prefersGrabberVisible = prefersGrabberVisible
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        self.preferredCornerRadius = preferredCornerRadius
        self.sheetView = sheetView
        self.onDismiss = onDismiss
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        viewController.view.backgroundColor = .clear
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        guard let presentedItem else {
            uiViewController.dismiss(animated: true)
            return
        }
        if uiViewController.presentedViewController == nil {
            let sheetViewController = SheetHostingViewController(
                detents: detents,
                largestUndimmedDetentIdentifier: largestUndimmedDetentIdentifier,
                prefersGrabberVisible: prefersGrabberVisible,
                prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge,
                preferredCornerRadius: preferredCornerRadius,
                rootView: sheetView(presentedItem)
            )
            sheetViewController.sheetPresentationController?.delegate = context.coordinator
            sheetViewController.delegate = context.coordinator
            uiViewController.present(sheetViewController, animated: true)
        } else if let hostingController = uiViewController.presentedViewController as? UIHostingController<SheetView> {
            hostingController.rootView = sheetView(presentedItem)
        }
    }

    final class Coordinator: NSObject, UISheetPresentationControllerDelegate, SheetHostingViewControllerDelegate {
        var parent: SheetPresentationController

        init(parent: SheetPresentationController) {
            self.parent = parent
        }

        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            guard parent.presentedItem != nil else {
                return
            }
            parent.presentedItem = nil
            if let onDismiss = parent.onDismiss {
                onDismiss()
            }
        }

        func sheetViewControllerDidDisappear<Content: View>(
            _ sheetViewController: SheetHostingViewController<Content>
        ) {
            parent.presentedItem = nil
            if let onDismiss = parent.onDismiss {
                onDismiss()
            }
        }
    }
}

private protocol SheetHostingViewControllerDelegate: AnyObject {
    func sheetViewControllerDidDisappear<Content: View>(
        _ sheetViewController: SheetHostingViewController<Content>
    )
}

private class SheetHostingViewController<Content: View>: UIHostingController<Content> {
    weak var delegate: SheetHostingViewControllerDelegate?

    private let detents: [UISheetPresentationController.Detent]
    private let largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    private let prefersGrabberVisible: Bool
    private let prefersScrollingExpandsWhenScrolledToEdge: Bool
    private let preferredCornerRadius: CGFloat

    init(
        detents: [UISheetPresentationController.Detent],
        largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?,
        prefersGrabberVisible: Bool,
        prefersScrollingExpandsWhenScrolledToEdge: Bool,
        preferredCornerRadius: CGFloat,
        rootView: Content
    ) {
        self.detents = detents
        self.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        self.prefersGrabberVisible = prefersGrabberVisible
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        self.preferredCornerRadius = preferredCornerRadius
        super.init(rootView: rootView)
    }
    
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        if let sheetPresentationController {
            sheetPresentationController.detents = detents
            sheetPresentationController.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
            sheetPresentationController.prefersGrabberVisible = prefersGrabberVisible
            sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
            sheetPresentationController.preferredCornerRadius = preferredCornerRadius
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isBeingDismissed {
            delegate?.sheetViewControllerDidDisappear(self)
        }
    }
}

private struct SheetPresentationPreviewView : View {
    @State private var presentedItem: String?

    var body: some View {
        VStack {
            Button {
                if presentedItem == nil {
                    presentedItem = "Hello world!"
                } else {
                    presentedItem = nil
                }
            } label: {
                  if presentedItem != nil {
                      Text("Dismiss Sheet")
                  } else {
                      Text("Present Sheet")
                  }
            }
        }
        .sheetPresentation(presentedItem: $presentedItem) { presentedItem in
            ZStack {
                Color.white
                Text(presentedItem)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    SheetPresentationPreviewView()
}
