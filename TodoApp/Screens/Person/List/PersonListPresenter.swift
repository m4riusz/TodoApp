import Foundation

protocol IPersonListPresenter {
    func getPersons() -> Void
}

class PersonListPresenter: IPersonListPresenter {
    
    fileprivate let personListView: IPersonListView;
    
    init(withView personListView: IPersonListView) {
        self.personListView = personListView
    }
    
    func getPersons() -> Void {
        self.personListView.setPersons([])
    }
    
}
