//
//  ViewController.swift
//  MyScrum
//
//  Created by Jesse Tellez on 4/25/16.
//  Copyright © 2016 Inspiright. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var iip = [NSIndexPath]()
    var dip = [NSIndexPath]()
    var ins: NSIndexSet?
    var des: NSIndexSet?
    
    var fetchedResultsCont:NSFetchedResultsController!
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        attemptFetch()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(true)
        attemptFetch()
        collectionView.reloadData()
    }
    
    
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
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        if let sections = fetchedResultsCont.sections
        {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("boardCell", forIndexPath: indexPath) as! boardCell
        
        configcell(cell, indexPath: indexPath)
        
        return cell
        
        
    }
    
    func configcell(cell: boardCell, indexPath: NSIndexPath)
    {
        
        if let subject = fetchedResultsCont.objectAtIndexPath(indexPath) as? Board
        {
            cell.configCell(subject)
        }
        
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        if controller == fetchedResultsCont {
            switch(type) {
                
            case .Insert:
                if let newIP = newIndexPath {
                    iip.append(newIP)
                }
            case .Delete:
                if let normIP = indexPath {
                    dip.append(normIP)
                }
            case .Update:
                if let normIP = indexPath {
                    self.collectionView!.reloadItemsAtIndexPaths([normIP])
                }
            default:
                break
                
            }
        }
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
        self.collectionView!.performBatchUpdates({ 
            self.collectionView!.insertItemsAtIndexPaths(self.iip)
            self.collectionView!.deleteItemsAtIndexPaths(self.dip)
            if self.ins != nil {
                self.collectionView!.insertSections(self.ins!)
            }
            if self.des != nil {
                self.collectionView!.deleteSections(self.des!)
                
            }
            
            }, completion:  { completed in
                
                self.iip.removeAll(keepCapacity: false)
                self.dip.removeAll(keepCapacity: false)
                self.ins = nil
                self.des = nil
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toBoardDetails" {
            let vc = segue.destinationViewController as! BoardDetailsVC
            vc.selectedBoard = sender as? Board
        }
    }
    
    
    func generateTestData() {
        
        let board = NSEntityDescription.insertNewObjectForEntityForName("Board", inManagedObjectContext: appDelegate.managedObjectContext) as! Board
        board.title = "Dancing"
        
        let board2 = NSEntityDescription.insertNewObjectForEntityForName("Board", inManagedObjectContext: appDelegate.managedObjectContext) as! Board
        board2.title = "Game Developement"
        
        let board3 = NSEntityDescription.insertNewObjectForEntityForName("Board", inManagedObjectContext: appDelegate.managedObjectContext) as! Board
        board3.title = "3D Animation"
        
        let board4 = NSEntityDescription.insertNewObjectForEntityForName("Board", inManagedObjectContext: appDelegate.managedObjectContext) as! Board
        board4.title = "Programming"
        
    }

}

