import Foundation
import CoreData

protocol ITodoListPresenter {
    func getTodos() -> Void
    func saveTodo(withTitle title: String, withDescription description: String) -> Void
}

class TodoListPresenter: ITodoListPresenter {
    
    fileprivate let todoListView: ITodoListView
    fileprivate let persistenceContainer: NSPersistentContainer
    fileprivate let privateContext: NSManagedObjectContext
    
    init(withView todoListView: ITodoListView) {
        self.todoListView = todoListView
        self.persistenceContainer = NSPersistentContainer(name: "TodoApp")
        self.persistenceContainer.loadPersistentStores { (descriptions, error) in
            if let err = error {
                fatalError("Unable to load persistent stores: \(err)")
            }
        }
        self.privateContext = self.persistenceContainer.newBackgroundContext()
    }
    
    func getTodos() -> Void {
        do {
            let asyncRequest: NSAsynchronousFetchRequest = NSAsynchronousFetchRequest<Todo>(fetchRequest: Todo.fetchRequest()) { (result) in
                DispatchQueue.main.async {
                    self.todoListView.setTodos(result.finalResult ?? [])
                }
            }
           try self.privateContext.execute(asyncRequest)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func saveTodo(withTitle title: String, withDescription description: String) -> Void {
        do {
            let entity: Todo = Todo(context: self.privateContext)
            entity.createDate = NSDate()
            entity.modifyDate = NSDate()
            entity.note = description
            entity.title = title
            try self.privateContext.save()
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
}
