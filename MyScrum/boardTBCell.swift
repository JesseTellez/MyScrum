//
//  boardTBCell.swift
//  MyScrum
//
//  Created by Jesse Tellez on 5/6/16.
//  Copyright © 2016 Inspiright. All rights reserved.
//

import UIKit

class boardTBCell: UITableViewCell {
    
    @IBOutlet weak var titleTextView: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var goalsLabel: UILabel!
    @IBOutlet weak var tasksLabel: UILabel!
    
    func configTBCell(board: Board) {
        
        titleTextView.text = board.title
        percentageLabel.text = "\(board.progress)%"
        goalsLabel.text = board.currentGoal
        
    }

}
