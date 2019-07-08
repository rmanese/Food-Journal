//
//  DishVC.swift
//  FoodJournal
//
//  Created by Roberto Manese III on 7/3/19.
//  Copyright © 2019 jawnyawn. All rights reserved.
//

import UIKit

class DishVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!

    let dishID = "DishCell"

    var dishes: [Dish] = [Dish(name: "Pizza"), Dish(name: "Chicken")]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Food Journal"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDish))

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: DishCell.self), bundle: nil), forCellReuseIdentifier: dishID)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dishID) as! DishCell
        cell.configure(dish: dishes[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dishes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    @objc func addDish() {
        let alertController = UIAlertController(title: "Did you just enjoy a new tasty dish?", message: "What did you eat?", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Dish Name"
        }
        alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (action) in
            guard   let textField = alertController.textFields?[0] ,
                    let dishName = alertController.textFields?[0].text else { return }
            if dishName.isEmpty {
                textField.placeholder = "Dish name cannot be empty."
                self.dismiss(animated: true, completion: nil)
                self.present(alertController, animated: true)
            } else {
                let newDish = Dish(name: dishName.capitalized)
                self.dishes.insert(newDish, at: 0)
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
        }))
        present(alertController, animated: true)
    }
}
