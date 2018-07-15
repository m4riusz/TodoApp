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
    
    override func setButtons() {
        super.setButtons()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(onAddButton))
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    @objc
    fileprivate func onAddButton() -> Void {
        let alertController: UIAlertController = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Notes"
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            let title: String = alertController.textFields?.first?.text ?? "Title"
            let description: String = alertController.textFields?.last?.text ?? ""
            self.todoListPresenter.saveTodo(withTitle: title, withDescription: description)
            
        }))
        self.navigationController?.present(alertController, animated: true, completion: nil)
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
