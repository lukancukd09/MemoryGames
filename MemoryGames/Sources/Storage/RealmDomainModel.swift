

import Foundation
import RealmSwift

final class RealmDomainModel: Object {
    @Persisted(primaryKey: true)  var id: UUID = .init()
    @Persisted var findPairsItems: List<FindPairsItemDomainModel>
    @Persisted var repeatItems: List<RepeatItemDomainModel>

    convenience init(
        id: UUID = .init(),
        findPairsItems: List<FindPairsItemDomainModel>,
        repeatItems: List<RepeatItemDomainModel>
    ) {
        self.init()
        self.id = id
        self.findPairsItems = findPairsItems
        self.repeatItems = repeatItems
    }
}
