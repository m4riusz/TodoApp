import UIKit

protocol IPersonListView {
    func setPersons(_ persons: [Person]) -> Void
}

class PersonListController: PersonBaseController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var persons: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className())
    }
}

extension PersonListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.className(), for: indexPath)
        cell.textLabel?.text = persons[indexPath.row].name
        return cell
    }
}

extension PersonListController: UITableViewDelegate {
    
}
