//
//  TableViewCell.swift
//  calender
//
//  Created by shishir sapkota on 1/2/18.
//  Copyright © 2018 ccr. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!

    var event: EventModel?
    var selectedDate: String?
    
    func setup() {
        self.eventLabel.text = self.event?.name
        self.dateLabel.text = self.event?.date
        if selectedDate == event?.date {
            let color = UIColor.red
            self.dateLabel.textColor = color
            self.eventLabel.textColor = color
        }else {
            let color = UIColor.black
            self.dateLabel.textColor = color
            self.eventLabel.textColor = color        }
    }
}
