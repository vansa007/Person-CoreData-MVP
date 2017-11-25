//
//  ViewController.swift
//  Person
//
//  Created by Vansa Pha on 24/11/17.
//  Copyright © 2017 Vansa Pha. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    var presenter: PersonPresenter = PersonPresenter()
    var people = [PersonModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.doRead()
    }
    
    //MARK: add new person
    @IBAction func addNewPersonAction(_ sender: UIBarButtonItem) {
        let person = Person(id: "4", name: "Bong Soy", age: "67")
        presenter.doSave(person: person)
    }
    
}

extension PersonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PersonCustomCell {
            cell.pId.text = people[indexPath.row].id
            cell.pName.text = people[indexPath.row].name
            cell.pAge.text = people[indexPath.row].age
            return cell
        }
        return UITableViewCell()
    }
}

extension PersonViewController: PersonView {
    //override: save done
    func didSave(error: Error?) {
        if error == nil {
            presenter.doRead()
        }
    }
    
    //override: read done
    func didRead(people: [PersonModel], error: Error?) {
        if error == nil {
            self.people = people
            self.myTableView.reloadData()
        }
    }
}

