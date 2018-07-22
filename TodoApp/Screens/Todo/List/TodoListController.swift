import UIKit

protocol ITodoListView {
    func setTodos(_ todos: [Todo]) -> Void
}

class TodoListController: TodoBaseController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate let todoListConfigurator: ITodoListConfigurator = TodoListConfigurator()
    fileprivate var todos:[Todo] = []
    var todoListPresenter: ITodoListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoListConfigurator.configure(self)
        tableView.register(UINib(nibName: TodoListTableViewCell.className(), bundle: nil), forCellReuseIdentifier: TodoListTableViewCell.className())
        todoListPresenter.getTodos()
    }
    
    override func setButtons() {
        super.setButtons()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(onAddButton))
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
        self.navigationItem.rightBarButtonItems?.forEach({ (barButton) in
            barButton.isEnabled = !editing
        })
    }
    
    @objc
    fileprivate func onAddButton() -> Void {
        let addController: TodoAddController = TodoAddController()
        addController.delegate = self
        self.navigationController?.present(TodoNavigationController(rootViewController: addController), animated: true, completion: nil)
    }
    
}

extension TodoListController: TodoAddControllerProtocol {
    
    func save(form: TodoAddControllerForm) {
        if let todo: Todo = self.todoListPresenter.saveTodo(withPriority: form.priority, withStatus: form.status, withTitle: form.title, withDescription: form.description) {
            self.todos.insert(todo, at: 0)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        }
    }
}

extension TodoListController: ITodoListView {
    
    func setTodos(_ todos: [Todo]) -> Void{
        self.todos = todos
        self.tableView.reloadData()
    }
}

extension TodoListController: ITodoListTableViewCell {
    
    func todoListTableViewCell(_ cell: TodoListTableViewCell, didChangeStatus status: Int) {
        self.todoListPresenter.update(todo: cell.todo!, withStatus: status)
    }
}

extension TodoListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TodoListTableViewCell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.className(), for: indexPath) as! TodoListTableViewCell
        let selectedItem: Todo = todos[indexPath.row];
        cell.loadCellData(withTodo: selectedItem)
        cell.delegate = self
        return cell
    }
}

extension TodoListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard todos.count > indexPath.row else {
            return
        }
        guard editingStyle == .delete else {
            return
        }
        self.todoListPresenter.removeTodo(todos[indexPath.row])
        self.todos.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
}
