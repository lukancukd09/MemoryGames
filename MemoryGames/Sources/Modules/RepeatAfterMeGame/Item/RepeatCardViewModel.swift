

import Foundation

final class RepeatCardViewModel: ObservableObject, Identifiable {
    let id: UUID
    let image: String
    @Published var isFaceUp: Bool
    @Published var isVisible: Bool

    init(id: UUID, image: String, isFaceUp: Bool, isVisible: Bool) {
        self.id = id
        self.image = image
        self.isFaceUp = isFaceUp
        self.isVisible = isVisible
    }
}
