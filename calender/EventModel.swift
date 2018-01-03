//
//  EventModel.swift
//  calender
//
//  Created by shishir sapkota on 1/3/18.
//  Copyright © 2018 ccr. All rights reserved.
//

import Foundation


class EventModel {
    var name: String?
    var date: String?
    
    init(name: String, date: String) {
        self.name = name
        self.date = date
    }
}
