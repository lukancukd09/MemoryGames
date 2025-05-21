

import Foundation
import RealmSwift

struct GameDomainModel {
    var id: UUID
    var findPairsItems: List<FindPairsItemDomainModel>
    var repeatItems: List<RepeatItemDomainModel>
    

    init(id: UUID = .init(), findPairsItems: List<FindPairsItemDomainModel>, repeatItems: List<RepeatItemDomainModel>) {
        self.id = id
        self.findPairsItems = findPairsItems
        self.repeatItems = repeatItems
    }
}
