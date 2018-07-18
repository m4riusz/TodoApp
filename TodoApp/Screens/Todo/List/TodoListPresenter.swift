import Foundation
import CoreData

protocol ITodoListPresenter {
    func getTodos() -> Void
    func saveTodo(withTitle title: String, withDescription description: String) -> Todo?
    func removeTodo(_ todo: Todo) -> Void
    func update(todo: Todo, withStatus status: Int) -> Void
}

class TodoListPresenter: ITodoListPresenter {
    fileprivate let todoListView: ITodoListView
    fileprivate let persistenceContainer: NSPersistentContainer
    fileprivate let privateContext: NSManagedObjectContext
    
    init(withView todoListView: ITodoListView) {
        self.todoListView = todoListView
        self.persistenceContainer = NSPersistentContainer(name: "TodoApp")
        self.privateContext = self.persistenceContainer.newBackgroundContext()
         self.persistenceContainer.loadPersistentStores { (descriptions, error) in
            if let err = error {
                fatalError("Unable to load persistent stores: \(err)")
            }
        }
        
    }
    
    func getTodos() -> Void {
        let asyncRequest: NSAsynchronousFetchRequest = NSAsynchronousFetchRequest<Todo>(fetchRequest: Todo.fetchRequest()) { (result) in
            DispatchQueue.main.async {
                self.todoListView.setTodos(result.finalResult ?? [])
            }
        }
        try! self.privateContext.execute(asyncRequest)
    }
    
    func saveTodo(withTitle title: String, withDescription description: String) -> Todo? {
        let entity: Todo = Todo(context: self.privateContext)
        entity.createDate = Date()
        entity.modifyDate = Date()
        entity.note = description
        entity.title = title
        try! self.privateContext.save()
        return entity
    }
    
    func removeTodo(_ todo: Todo) -> Void {
        self.privateContext.delete(todo)
        try! self.privateContext.save()
    }
    
    func update(todo: Todo, withStatus status: Int) -> Void {
        let statusEntity: Status = Status(context: self.privateContext)
        statusEntity.status = Int16(status)
        todo.status = statusEntity
        try! self.privateContext.save()
    }
}
