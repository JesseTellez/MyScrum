//
//  boardCell.swift
//  MyScrum
//
//  Created by Jesse Tellez on 4/29/16.
//  Copyright © 2016 Inspiright. All rights reserved.
//

import UIKit

class boardCell: UICollectionViewCell {

    @IBOutlet weak var boardTitleLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var progressPercentLabel: UILabel!
    
    func configCell(board: Board) {
        boardTitleLabel.text = board.title
        
        
        //TODO: Set up goal label formating
        
        //goalLabel.text = board.goals
        //progressPercentLabel.text = board.totalPoints
    }
    
    
    
}
