//
//  CollegeObject.swift
//  MMHS_FavoriteColleges
//
//  Created by Mobile Makers on 7/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

import UIKit

class CollegeObject: NSObject
{
    var name : String = ""
    var location : String = ""
    var numberOfStudents : Int = 0
    var image  = UIImage()

    convenience init (name: String, location: String, numberOfStudents: Int, image: UIImage)
    {
        self.init()
        self.name = name
        self.location = location
        self.numberOfStudents = numberOfStudents
        self.image = image
    }
}
