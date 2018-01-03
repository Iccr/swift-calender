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
    
    // MARK: Outlets
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calenderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    let allEvent = ["Asian Film Awards[1]", "Beijing Pop Festival", "Being Globally Responsible Conference", "China Baseball League", "China Digital Entertainment Expo & Conference"]
    
    var events: [EventModel]? = [
        EventModel.init(name: "Asian Film Awards[1]" , date: "2018-01-03"),
        EventModel.init(name: "Beijing Pop Festival" , date: "2018-01-04"),
        EventModel.init(name: "Being Globally Responsible Conference" , date: "2018-01-05"),
        EventModel.init(name: "China Baseball League" , date: "2018-01-04"),
        EventModel.init(name: "Entertainment Expo & Conference" , date: "2018-01-04"),
        ]

    
    var selectedDate: String? {didSet {self.filter()}}
    var fileteredDateWithEvents: [EventModel]? {didSet {self.tableView.reloadData()}}
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.scrollDirection = .horizontal
        calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
        let today = Date()
        calendar.today = today
        calendar.currentPage = today
        calendar.delegate = self
        calendar.dataSource = self
        fileteredDateWithEvents = events
        self.selectedDate = DateFormatter.stringFrom(date: Date())
        self.navigationItem.title = "Calender"
        createEvents()
    }
    
    // MARK: Other Functions
    
    private func createEvents() {
        
    }
    
    private func filter() {
        fileteredDateWithEvents = events?.filter({dateLiesInGivenMonth(dateString: $0.date, month: DateFormatter.DateFrom(string: selectedDate ?? ""))})
    }
    
    private func dateLiesInGivenMonth(dateString: String?, month: Date?) -> Bool {
        guard let dateString = dateString,  let date = DateFormatter.DateFrom(string: dateString), let month = month else {return false }
        let dateComponent = calendar.components.calendar?.dateComponents([.month, .day], from: date)
        let today = calendar.components.calendar?.dateComponents([.month, .day], from: month)
        if today?.month == dateComponent?.month && today?.year == dateComponent?.year {
            return true
        }
        return false
    }
}

// MARK: Extensions

extension ViewController: FSCalendarDataSource {
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
}

extension ViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.selectedDate = DateFormatter.stringFrom(date: date)    
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.selectedDate = DateFormatter.stringFrom(date: calendar.currentPage)
    }
    
    func calendarCurrentScopeWillChange(calendar: FSCalendar!, animated: Bool) {
        calenderHeightConstraint.constant = calendar.sizeThatFits(CGSize.zero).height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        var result = 0
        let dateString = DateFormatter.stringFrom(date: date)
        if let valid = self.events?.filter({$0.date == dateString}).first {result = 1}

        return result
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let result = fileteredDateWithEvents?.filter({ self.dateLiesInGivenMonth(dateString: $0.date, month: DateFormatter.DateFrom(string: selectedDate ?? ""))})
        return result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell") as! CalendarTableViewCell
        let event = self.fileteredDateWithEvents?[indexPath.row]
        cell.event = self.events?[indexPath.row]
        cell.selectedDate = self.selectedDate
        cell.setup()
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
}
