//
//  ViewController.swift
//  MyScrum
//
//  Created by Jesse Tellez on 4/25/16.
//  Copyright © 2016 Inspiright. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    var someGoal: String! = "This is a basic place holder for the current goal I hope this is enough text"
    
    var fetchedResultsCont:NSFetchedResultsController!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        attemptFetch()
        
        //generateTestData()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(true)
        attemptFetch()
        myTableView.reloadData()
    }
    
    //Pragma Mark - Generate Test Data
    
    func generateTestTasks() {
        
        generateTestData()
        
    }
    
    func generateTestData() {
        
        let board = NSEntityDescription.insertNewObjectForEntityForName("Board", inManagedObjectContext: appDelegate.managedObjectContext) as! Board
        board.title = "Dancing"
        board.progress = NSNumber(int: 47)
        board.currentGoal = someGoal
        
        
        let board2 = NSEntityDescription.insertNewObjectForEntityForName("Board", inManagedObjectContext: appDelegate.managedObjectContext) as! Board
        board2.title = "Game Developement"
        board2.progress = NSNumber(int: 89)
        board2.currentGoal = someGoal
        
        let board3 = NSEntityDescription.insertNewObjectForEntityForName("Board", inManagedObjectContext: appDelegate.managedObjectContext) as! Board
        board3.title = "3D Animation"
        board3.progress = NSNumber(int: 15)
        board3.currentGoal =  someGoal
        
        let board4 = NSEntityDescription.insertNewObjectForEntityForName("Board", inManagedObjectContext: appDelegate.managedObjectContext) as! Board
        board4.title = "Programming"
        board4.progress = NSNumber(int: 29)
        board4.currentGoal = someGoal
        
        appDelegate.saveContext()
    }
    
    //Pragma Mark - CoreData Fetching
    
    
    func attemptFetch()
    {
        setFetchedResults()
        
        do {
            try self.fetchedResultsCont.performFetch()
        } catch {
            let error = error as NSError
            print("\(error), \(error.userInfo)")
        }
        
    }
    
    func setFetchedResults()
    {
        let fetchRequest = NSFetchRequest(entityName: "Board")
        let section: String? = "title"
        
        let sortDescrp = NSSortDescriptor(key: "totalPoints", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescrp]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.managedObjectContext, sectionNameKeyPath: section, cacheName: nil)
        
        controller.delegate = self
        
        fetchedResultsCont = controller
    }
    
    func configcell(cell: boardTBCell, indexPath: NSIndexPath)
    {
        
        if let subject = fetchedResultsCont.objectAtIndexPath(indexPath) as? Board
        {
            cell.configTBCell(subject)
        }
        
    }
    
    
    //PRAGMA MARK - TABLEVIEW METHODS
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = fetchedResultsCont.sections {
            
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
            
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let objects = fetchedResultsCont.fetchedObjects where objects.count > 0 {
            let boardToPass = objects[indexPath.row] as! Board
            performSegueWithIdentifier("selectExistingBoard", sender: boardToPass)
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCellWithIdentifier("boardCell", forIndexPath: indexPath) as! boardTBCell
        
        configcell(cell, indexPath: indexPath)
        return cell
        
        
    }
    
    //Pragma Mark - NSFetchController Methods
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        myTableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        if controller == fetchedResultsCont {
            switch(type) {
                
            case .Insert:
                if let newIP = newIndexPath {
                    myTableView.insertRowsAtIndexPaths([newIP], withRowAnimation: .Fade)
                }
                break
            case .Delete:
                if let normIP = indexPath {
                    myTableView.deleteRowsAtIndexPaths([normIP], withRowAnimation: .Fade)
                }
                break
            case .Update:
                if let normIP = indexPath {
                    let cell = myTableView.cellForRowAtIndexPath(normIP) as! boardTBCell
                    configcell(cell, indexPath: normIP)
                }
                break
            case .Move:
                if let normIP = indexPath {
                    myTableView.deleteRowsAtIndexPaths([normIP], withRowAnimation: .Fade)
                }
                
                if let newIp = newIndexPath {
                    myTableView.insertRowsAtIndexPaths([newIp], withRowAnimation: .Fade)
                }
                break
            }
        }
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        myTableView.endUpdates()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toBoardDetails" {
            let vc = segue.destinationViewController as! BoardDetailsVC
            vc.selectedBoard = sender as? Board
        }
    }
    

}

