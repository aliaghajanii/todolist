//
//  CategoryViewController.swift
//  Todolist
//
//  Created by ali aghajani on 5/28/19.
//  Copyright © 2019 ali aghajani. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        tableView.separatorStyle = .none
        
    }

    // MARK: - Table view data source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let category = categoryArray?[indexPath.row] {
            Cell.textLabel?.text = category.name
            guard let categoryColor = UIColor(hexString: category.color ) else {fatalError()}
            Cell.backgroundColor = categoryColor
            Cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
            //        cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        }
        return Cell
    }
    
    // MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestinationVC = segue.destination as! TodoListVewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            DestinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    
    
    
    // MARK: - Data Manipulation Methods
    
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving Categoy \(error)")
        }
        tableView.reloadData()
    }

    
    func loadCategories() {
        
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    override func updateData(at indexpath: IndexPath) {
        
        if let rowForDeletation = self.categoryArray?[indexpath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(rowForDeletation)
                }
            } catch {
                print("delet and update row Failed \(error)")
            }
            tableView.reloadData()
        }
    }
    
    
    
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textfield.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textfield = field
            textfield.placeholder = "Add New Category"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}



