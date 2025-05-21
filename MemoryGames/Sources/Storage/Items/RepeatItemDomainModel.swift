
import Foundation
import RealmSwift

final class RepeatItemDomainModel: Object {
    @Persisted(primaryKey: true)  var id: UUID = .init()
    @Persisted var title: String = ""
    @Persisted var image: String = ""
    @Persisted var level: Int = 0
    @Persisted var isResolved: Bool = false
        
    convenience init(
        id: UUID = .init(),
        level: Int,
        title: String,
        image: String,
        isResolved: Bool
    ) {
        self.init()
        self.id = id
        self.title = title
        self.image = image
        self.level = level
        self.isResolved = isResolved
    }
}
