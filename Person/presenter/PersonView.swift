//
//  PersonView.swift
//  Person
//
//  Created by Vansa Pha on 24/11/17.
//  Copyright © 2017 Vansa Pha. All rights reserved.
//
import UIKit
import CoreData

protocol PersonView: class {
    func didRead(people: [PersonModel], error: Error?)
    func didSave(error: Error?)
}

protocol PersonViewPresenter {
    //init(view: PersonView?)
    func doSave(person: Person)
    func doRead()
}

struct PersonPresenter: PersonViewPresenter {
    weak var delegate: PersonView?
    var people = [PersonModel]()
//    init(view: PersonView?){
//        self.view = view
//    }


    func doSave(person: Person) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        let personModel = PersonModel(context: context)
        personModel.id = person.id
        personModel.name = person.name
        personModel.age = person.age
        do {
            try context.save()
            delegate?.didSave(error: nil)
        }catch {
            debugPrint("Can not insert.")
            delegate?.didSave(error: error)
        }
    }
    
    func doRead() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonModel")
        do {
            let people = try context.fetch(fetchRequest) as? [PersonModel] ?? []
            delegate?.didRead(people: people, error: nil)
        }catch {
            debugPrint("Can not fetch data.")
            delegate?.didRead(people: [], error: error)
        }
    }
}
