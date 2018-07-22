import UIKit

protocol ITodoListTableViewCell: NSObjectProtocol {
    func todoListTableViewCell(_ cell: TodoListTableViewCell, didChangeStatus status: Int) -> Void
}

class TodoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priorityColor: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusSegmentControl: UISegmentedControl!
    weak var delegate: ITodoListTableViewCell?
    var todo: Todo?
    
    func loadCellData(withTodo todo: Todo) -> Void {
        self.todo = todo
        self.titleLabel.text = todo.title
        self.descriptionLabel.text = todo.note
        self.statusSegmentControl.selectedSegmentIndex = Int(todo.status)
        self.priorityColor.backgroundColor = [UIColor.green, UIColor.yellow, UIColor.red][Int(todo.priority)]
    }
    
    // MARK - Actions
    
    @IBAction func onSegmentValueChanged(_ sender: Any) {
        guard delegate != nil else {
            return
        }
        delegate?.todoListTableViewCell(self, didChangeStatus: self.statusSegmentControl.selectedSegmentIndex)
    }
}

