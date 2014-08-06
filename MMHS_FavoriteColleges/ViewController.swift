//
//  ViewController.swift
//  MMHS_FavoriteColleges
//
//  Created by Richard Fellure on 7/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!

    var colleges : [CollegeObject] = []


    override func viewDidLoad()
    {
        super.viewDidLoad()

        //Using the CollegeObject's custom initializers to create four given Universities. Students can customize for their own top four favorites
        let missouri = CollegeObject(name: "University of Missouri", location: "Columbia, MO", numberOfStudents: 34658, image: UIImage(named: "Missouri_Image"), webAddress: "http://missouri.edu/")
        let illinois = CollegeObject(name: "University of Dayton", location: "Dayton, OH", numberOfStudents: 10000, image: UIImage(named: "Dayton_Image"), webAddress: "http://www.udayton.edu/")
        let iowa = CollegeObject(name: "University of Iowa", location: "Iowa City, IA", numberOfStudents: 31065, image: UIImage(named: "Iowa_Image"), webAddress: "http://www.uiowa.edu")
        let indiana = CollegeObject(name: "Indiana University", location: "Bloomington, IN", numberOfStudents: 110436, image: UIImage(named: "Indiana_Image"), webAddress: "http://www.indiana.edu/")

        //Add the CollegeObjects into the Array so they can be used to populate the TableView
        colleges = [missouri, illinois, iowa, indiana]

        //Tag will be used in the IBAction to decipher whether the TableView will be in editing mode or not when the button is pressed
        editBarButton.tag = 0
    }

    //Using the TableViewDataSource method for creating the number of rows we want to display
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return colleges.count
    }

    //Using the TableViewDataSource method for adding properties to the TableViewCell, set the name of the college as the textLabel for the cell
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID") as UITableViewCell

        cell.textLabel.text = colleges[indexPath.row].name

        return cell
    }

    //TableViewDelegate method that allows for the swipe left to present the delete button on the TableView, so rows can be deleted
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            colleges.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }

    //TableViewDataSource method that returns that returns a boolean to decide whether the cells can be moved or not
    func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
        return true
    }

    //TableViewDataSource method that allows us to change the index of the cell that we wish to move
    func tableView(tableView: UITableView!, moveRowAtIndexPath sourceIndexPath: NSIndexPath!, toIndexPath destinationIndexPath: NSIndexPath!)
    {
        let college = colleges[sourceIndexPath.row]

        colleges.removeAtIndex(sourceIndexPath.row)
        colleges.insert(college, atIndex: destinationIndexPath.row)
    }

    //Action that controls the TableView's editing mode, specifically if it is in editing mode or not depending on the tap of the BarButtonItem
    @IBAction func enterEditingOnButtonPressed(sender: UIBarButtonItem)
    {
        //if the tag is 0 when the button is pressed we want to be able to edit the TableView, and change the tag so when it is tapped again we can exit editing mode
        if sender.tag == 0
        {
            tableView.setEditing(true, animated: true)
            sender.tag = 1
        }
        else
        {
            tableView.setEditing(false, animated: true)
            sender.tag = 0
        }
    }

    //Action for the second BarButtonItem to present the AlertController for adding an additional school
    @IBAction func addCollegeOnButtonPressed(sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Add another college!", message: nil, preferredStyle: UIAlertControllerStyle.Alert)

        alert.addTextFieldWithConfigurationHandler({textfield in
            textfield.placeholder = "Add the College's name here"
            })
        alert.addTextFieldWithConfigurationHandler({textfield in
            textfield.placeholder = "Add the College's location here"
            })
        alert.addTextFieldWithConfigurationHandler({textfield in
            textfield.placeholder = "Add the College's webAddress here"
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancelAction)

        let addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default, handler: {action in

            let nameTextfield = alert.textFields[0] as UITextField
            let locationTextfield = alert.textFields[1] as UITextField
            let webAddressTextField = alert.textFields[2] as UITextField

            let college = CollegeObject(name: nameTextfield.text, location: locationTextfield.text, numberOfStudents: 0, image: UIImage(named: "Default_Image"), webAddress: webAddressTextField.text)

            self.colleges += [college]

            self.tableView.reloadData()
            })

        alert.addAction(addAction)

        presentViewController(alert, animated: true, completion: nil)
    }

    //prepareForSegue method for pushing data through the segue
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)
    {
        let detailVC = segue.destinationViewController as DetailViewController
        detailVC.college = colleges[tableView.indexPathForSelectedRow().row]
    }
}

