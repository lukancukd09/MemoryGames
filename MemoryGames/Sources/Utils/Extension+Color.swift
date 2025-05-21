
import Foundation
import SwiftUI

extension Color {
    init(redd: Double, greenn: Double, bluee: Double, opacity: Double = 1.0) {
        self.init(
            red: redd / 255,
            green: greenn / 255,
            blue: bluee / 255,
            opacity: opacity
        )
    }
}
