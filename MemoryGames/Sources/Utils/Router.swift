
import Foundation

enum Router: Hashable {
    case root
    case main
    case levels(Category)
    case info
    case profile
    case settigs
    case game1(Level)
    case game2(Level)
}
