

import Foundation

enum Category {
    case pairs
    case repeatMe
}

struct Level: Identifiable, Hashable {
    let id: String
    let title: String
    let image: String
    var level: Int 
    var pairs: Int
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Level, rhs: Level) -> Bool {
        return lhs.id == rhs.id &&
            lhs.image == rhs.image &&
            lhs.title == rhs.title &&
            lhs.level == rhs.level
    }
}

final class LevelListViewModel: ObservableObject {
    var category: Category
    var levels: [Level] = []
    
    init(category: Category) {
        self.category = category
    }
    
    func reloadData() {
        let gameStorage: GameDomainModelStorage = .init()
        
        if category == .pairs {
            let levelItems: [Level] = gameStorage.read().first?.findPairsItems
                .compactMap { makeCellViewModel(for: $0) } ?? []
            
            levels = levelItems
        } else {
            let levelItems: [Level] = gameStorage.read().first?.repeatItems
                .compactMap { makeRepeatCellViewModel(for: $0) } ?? []
            
            levels = levelItems
        }
    }
    
    func makeCellViewModel(
        for model: FindPairsItemDomainModel
    ) -> Level? {
        return .init(id: model.id.uuidString, title: model.title, image: model.image, level: model.level, pairs: model.pairs)
    }
    
    func makeRepeatCellViewModel(
        for model: RepeatItemDomainModel
    ) -> Level? {
        return .init(id: model.id.uuidString, title: model.title, image: model.image, level: model.level, pairs: 0)
    }
}
