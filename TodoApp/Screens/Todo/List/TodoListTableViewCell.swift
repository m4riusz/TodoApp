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
    
    // MARK - Actions
    
    @IBAction func onSegmentValueChanged(_ sender: Any) {
        guard delegate != nil else {
            return
        }
        delegate?.todoListTableViewCell(self, didChangeStatus: self.statusSegmentControl.selectedSegmentIndex)
    }
}

