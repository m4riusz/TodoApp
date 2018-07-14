import Foundation

protocol ITodoListConfigurator {
    func configure(_ controller: TodoListController) -> Void
}

class TodoListConfigurator: ITodoListConfigurator {
    
    func configure(_ controller: TodoListController) {
        let todoListView: ITodoListView = controller
        let todoListPresenter: ITodoListPresenter = TodoListPresenter(withView: todoListView)
        
        controller.todoListPresenter = todoListPresenter
    }
    
}
