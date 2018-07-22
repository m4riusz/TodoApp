import UIKit

struct TodoAddControllerForm {
    let priority: Int
    let status: Int
    let title: String
    let description: String
}

protocol TodoAddControllerProtocol {
    func save(form: TodoAddControllerForm)
}

class TodoAddController: TodoBaseController {

    @IBOutlet weak var prioritySegmentControll: UISegmentedControl!
    @IBOutlet weak var statusSegmentControll: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    var delegate: TodoAddControllerProtocol?
    
    override func setButtons() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelButton))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButton))
    }
    
    // MARK - Actions
    
    @objc
    func onCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func onDoneButton() {
        self.dismiss(animated: true) {
            self.delegate?.save(form: TodoAddControllerForm(
                priority: self.prioritySegmentControll.selectedSegmentIndex,
                status: self.statusSegmentControll.selectedSegmentIndex,
                title: self.titleTextField.text!,
                description: self.descriptionTextField.text)
            )
        }
    }
}
