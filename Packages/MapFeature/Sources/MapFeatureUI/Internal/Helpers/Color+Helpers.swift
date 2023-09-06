import MapFeatureDomain
import SwiftUI

extension Color {
    init(_ rating: MapPOI.Color) {
        switch rating {
        case .black:
            self = .black
        case .red:
            self = .red
        case .orange:
            self = .orange
        case .yellow:
            self = .yellow
        case .green:
            self = .green
        case .blue:
            self = .blue
        }
    }
}
