import UIKit

protocol ITodoListView {
    func setTodos(_ todos: [Todo])
}

class TodoListController: TodoBaseController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate let todoListConfigurator: ITodoListConfigurator = TodoListConfigurator()
    fileprivate var todos:[Todo] = []
    var todoListPresenter: ITodoListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoListConfigurator.configure(self)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className())
        todoListPresenter.getTodos()
    }
    
}

extension TodoListController: ITodoListView {
    
    func setTodos(_ todos: [Todo]) {
        self.todos = todos
        self.tableView.reloadData()
    }
}

extension TodoListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.className(), for: indexPath)
        cell.textLabel?.text = todos[indexPath.row].title
        cell.detailTextLabel?.text = todos[indexPath.row].note
        return cell
    }
}

extension TodoListController: UITableViewDelegate {
    
}
