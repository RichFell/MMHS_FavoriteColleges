//
//  DetailViewController.swift
//  MMHS_FavoriteColleges
//
//  Created by Richard Fellure on 7/31/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate
{
    var college : CollegeObject!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var numberOfStudentsLabel: UILabel!
    @IBOutlet weak var editLocationTextField: UITextField!
    @IBOutlet weak var editNumberOfStudentsTextField: UITextField!
    @IBOutlet weak var editLocationButton: UIButton!
    @IBOutlet weak var editNumberOfStudentsButton: UIButton!


    override func viewDidLoad()
    {
        super.viewDidLoad()

        locationLabel.text = college.location
        numberOfStudentsLabel.text = "\(college.numberOfStudents)"
        imageView.image = college.image
        navigationItem.title = college.name

        editNumberOfStudentsTextField.hidden = true
        editLocationTextField.hidden = true

        editLocationTextField.delegate = self
        editNumberOfStudentsTextField.delegate = self
    }

    @IBAction func editLocationOnButtonPressed(sender: UIButton)
    {
        sender.hidden = true
        editLocationTextField.hidden = false
        locationLabel.hidden = true
    }

    @IBAction func editNumberOfStudentsOnButtonPressed(sender: UIButton)
    {
        sender.hidden = true
        editNumberOfStudentsTextField.hidden = false
        numberOfStudentsLabel.hidden = true
    }

    @IBAction func websiteButtonTapped(sender: UIButton)
    {
        
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        if textField == editLocationTextField
        {
            college.location = editLocationTextField.text
            locationLabel.text = editLocationTextField.text

            locationLabel.hidden = false
            editLocationTextField.hidden = true
            editLocationButton.hidden = false
        }
        else if textField == editNumberOfStudentsTextField
        {
            college.numberOfStudents = editNumberOfStudentsTextField.text.toInt()!
            numberOfStudentsLabel.text = editNumberOfStudentsTextField.text

            editNumberOfStudentsTextField.hidden = true
            numberOfStudentsLabel.hidden = false
            editNumberOfStudentsButton.hidden = false
        }

        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)
    {
        let webviewVC = segue.destinationViewController as WebViewController
        webviewVC.college = college
    }
}
