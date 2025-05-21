
import Foundation
import RealmSwift

final class FirstOnboardingViewModel: ObservableObject {
    func loadData() {
        let gameStorage: GameDomainModelStorage = .init()
        
        guard gameStorage.read().isEmpty else { return }
        
        let pairsList = List<FindPairsItemDomainModel>()
        let repeatList = List<RepeatItemDomainModel>()
        
        pairsList.append(.init(level: 1, title: "Level 1", image: "lvl1", pairs: 3, isResolved: false))
        pairsList.append(.init(level: 2, title: "Level 2", image: "lvl2", pairs: 4, isResolved: false))
        pairsList.append(.init(level: 3, title: "Level 3", image: "lvl3", pairs: 4, isResolved: false))
        pairsList.append(.init(level: 4, title: "Level 4", image: "lvl4", pairs: 8, isResolved: false))
        pairsList.append(.init(level: 5, title: "Level 5", image: "lvl2", pairs: 8, isResolved: false))
        pairsList.append(.init(level: 6, title: "Level 6", image: "lvl3", pairs: 10, isResolved: false))
        pairsList.append(.init(level: 7, title: "Level 7", image: "lvl1", pairs: 10, isResolved: false))
        pairsList.append(.init(level: 8, title: "Level 8", image: "lvl4", pairs: 10, isResolved: false))
        pairsList.append(.init(level: 9, title: "Level 9", image: "lvl1", pairs: 10, isResolved: false))
        pairsList.append(.init(level: 10, title: "Level 10", image: "lvl2", pairs: 10, isResolved: false))
    
        repeatList.append(.init(level: 1, title: "Level 1", image: "lvl2", isResolved: false))
        repeatList.append(.init(level: 2, title: "Level 2", image: "lvl1", isResolved: false))
        repeatList.append(.init(level: 3, title: "Level 3", image: "lvl3", isResolved: false))
        repeatList.append(.init(level: 4, title: "Level 4", image: "lvl4", isResolved: false))
        repeatList.append(.init(level: 5, title: "Level 5", image: "lvl1", isResolved: false))
        repeatList.append(.init(level: 6, title: "Level 6", image: "lvl2", isResolved: false))
        repeatList.append(.init(level: 7, title: "Level 7", image: "lvl3", isResolved: false))
        repeatList.append(.init(level: 8, title: "Level 8", image: "lvl4", isResolved: false))
        repeatList.append(.init(level: 9, title: "Level 9", image: "lvl2", isResolved: false))
        repeatList.append(.init(level: 10, title: "Level 10", image: "lvl1", isResolved: false))
        
        gameStorage.store(item: .init(findPairsItems: pairsList, repeatItems: repeatList))
    }
}
