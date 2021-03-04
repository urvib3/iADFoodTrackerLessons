//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Urvi Bhuwania on 2/18/21.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    //MARK: Properties
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleMeals()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
                fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            }

        
        
        //Configure the cell
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.RatingControl.rating = meal.rating
        
        
        return cell
    }

    
    //MARK: Private Methods
    private func loadSampleMeals(){
        
        // load images
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        // make meals
        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating:4) else {
            fatalError("Unable to instantiate meal")
        }
        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
            fatalError("Unable to instantiate meal")
        }
        guard let meal3 = Meal(name: "pasta with meatballs", photo: photo3, rating:3) else {
            fatalError("Unable to instantiate meal")
        }
        
        meals += [meal1, meal2, meal3]
        
    }
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: meals.count, section: 0)
            
            meals.append(meal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

}
