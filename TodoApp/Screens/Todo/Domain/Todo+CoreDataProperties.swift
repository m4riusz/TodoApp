import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var createDate: NSDate?
    @NSManaged public var modifyDate: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var note: String?
    @NSManaged public var done: Bool
    @NSManaged public var owner: Person?
    @NSManaged public var priority: Priority?

}
