//
//  ViewController.swift
//  calender
//
//  Created by shishir sapkota on 1/2/18.
//  Copyright © 2018 ccr. All rights reserved.
//

import UIKit
import FSCalendar
import CoreGraphics


class ViewController: UIViewController {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calenderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var dateWithEvents = [("2018-01-03", "loshar"), ("2018-01-04", "Dashain") ,("2018-01-05", "Laxmi Puja") , ("2018-01-06", "maghe sankranti"), ("2018-01-07", "prajatantra diwas"), ("2018-01-08", "Topi diwas")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.scrollDirection = .horizontal
        calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
        let today = Date()
        calendar.today = today
        calendar.currentPage = today
        calendar.delegate = self
//        tableView.delegate = self
//        tableView.dataSource = self
    }
    
    
    func minimumDateForCalendar(calendar: FSCalendar!) -> NSDate! {
        return calendar.date(withYear: 2015, month: 1, day: 1) as NSDate
    }
    
    func maximumDateForCalendar(calendar: FSCalendar!) -> NSDate! {
        return calendar.date(withYear: 2050, month: 10, day: 31) as NSDate
    }
    
    func calendar(calendar: FSCalendar!, numberOfEventsForDate date: NSDate!) -> Int {
        let day = calendar.day(of: date as Date)
        return day % 5 == 0 ? day/5 : 0;
    }
    
    func calendarCurrentPageDidChange(calendar: FSCalendar!) {
        
        NSLog("change page to \(calendar.formatter.string(from: calendar.currentPage)))")
    }
    
    func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {
        NSLog("calendar did select date \(calendar.formatter.string(from: date as Date))")
    }
    
    func calendarCurrentScopeWillChange(calendar: FSCalendar!, animated: Bool) {
        calenderHeightConstraint.constant = calendar.sizeThatFits(CGSize.zero).height
        view.layoutIfNeeded()
    }
    
    func calendar(calendar: FSCalendar!, imageForDate date: NSDate!) -> UIImage! {
       
        return  [13,14].contains(calendar.day(of: date as Date)) ? UIImage(named: "icon_cat") : nil
    }
    
    
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        var result = 0
        let dateString = DateFormatter.stringFrom(date: date)
        if let valid = self.dateWithEvents.filter({$0.0 == dateString}).first {
            result = 1
        }
        return result
    }
    
    func dateLiesInThisMonth(dateString: String) -> Bool {
        if let date = DateFormatter.DateFrom(string: dateString) {
            let dateComponent = calendar.components.calendar?.dateComponents([.month, .day], from: date)
            let today = calendar.components.calendar?.dateComponents([.month, .day], from: Date())
            if today?.month == dateComponent?.month && today?.year == dateComponent?.year {
                return true
            }
        }
        return false
    }
}


extension ViewController: UITableViewDelegate {
    
    
}
extension ViewController: FSCalendarDelegate {
    
    
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let result = dateWithEvents.filter({ self.dateLiesInThisMonth(dateString: $0.0)})
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let event = self.dateWithEvents[indexPath.row]
        cell.textLabel?.text = event.1
        return cell
    }
}


extension DateFormatter {
    class func stringFrom(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    class func DateFrom(string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string)
    }
}

