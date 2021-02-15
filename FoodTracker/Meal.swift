//
//  Meal.swift
//  FoodTracker
//
//  Created by Urvi Bhuwania on 2/11/21.
//

import UIKit

class Meal {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
           
        //Fail initialization if there's no name or rating is out of bounds
        if name.isEmpty || rating < 0 || rating > 5 {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
