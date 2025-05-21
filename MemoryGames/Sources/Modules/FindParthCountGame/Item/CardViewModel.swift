
import Foundation

final class CardViewModel: ObservableObject, Hashable {
    let id: UUID
    let image: String
    var isMatched: Bool = false
    var isFaceUp: Bool = false
    
    init(id: UUID = .init(), image: String, isMatched: Bool, isFaceUp: Bool) {
        self.id = id
        self.image = image
        self.isMatched = isMatched
        self.isFaceUp = isFaceUp
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CardViewModel, rhs: CardViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.image == rhs.image &&
            lhs.isMatched == rhs.isMatched &&
            lhs.isFaceUp == rhs.isFaceUp
    }
}
