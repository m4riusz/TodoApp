import Foundation

protocol ITodoListPresenter {
    func getTodos() -> Void
}

class TodoListPresenter: ITodoListPresenter {
    
    fileprivate let todoListView: ITodoListView
    
    init(withView todoListView: ITodoListView) {
        self.todoListView = todoListView
    }
    
    func getTodos() {
        self.todoListView.setTodos([])
    }
    
}
