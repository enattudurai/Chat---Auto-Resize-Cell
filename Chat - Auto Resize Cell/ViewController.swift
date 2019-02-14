//
//  ViewController.swift
//  Chat - Auto Resize Cell
//
//  Created by Naattudurai Eswaramurthy on 14/02/19.
//  Copyright © 2019 Naattudurai Eswaramurthy. All rights reserved.
//

import UIKit

struct ChatMessage {
    let message : String
    let isOwnMsg : Bool
    let msgDate : Date
}

extension Date
{
    static func dateFromCustomString(customString : String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm/dd/yyyy"
        
        return dateFormatter.date(from: customString) ?? Date()
    }
    
}

class DateHeaderLabel : UILabel
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize
    {
        let originalSize = super.intrinsicContentSize
        let height = originalSize.height + 12
        
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return CGSize(width: originalSize.width + 20, height: height)
    }
    
}

class ViewController: UITableViewController {

    fileprivate let cellId = "identifier"
    var chatMessages = [[ChatMessage]]()
    
    let messagesFromServer = [ChatMessage(message: "This is Nattudurai Eswaramurthy", isOwnMsg: true, msgDate : Date.dateFromCustomString(customString:     "24/09/2018")),
                              ChatMessage(message: "This is the sample app for chat application where we can see the dynamic cell depedns on the text size", isOwnMsg: true,  msgDate : Date.dateFromCustomString(customString: "24/09/2018")),
                              ChatMessage(message: "This is the sample app for chat application where we can see the dynamic cell depedns on the text size jadksbjkdasbcskjcbskcbskdcvbskdcvbaskdjvbksjdvbaskdjvbaksdvbkasdvskbdv", isOwnMsg: false,  msgDate : Date.dateFromCustomString(customString: "24/09/2018")),
                              ChatMessage(message: "This is Priya Nattudurai", isOwnMsg: false, msgDate : Date.dateFromCustomString(customString: "16/10/2018")),
                               ChatMessage(message: "This is the sample app for chat application where we can see the dynamic cell depedns on the text size", isOwnMsg: true,  msgDate : Date.dateFromCustomString(customString: "16/10/2018")),
                               ChatMessage(message: "This is the sample app for chat application where we can see the dynamic cell depedns on the text size jadksbjkdasbcskjcbskcbskdcvbskdcvbaskdjvbksjdvbaskdjvbaksdvbkasdvskbdv", isOwnMsg: false,  msgDate : Date.dateFromCustomString(customString: "16/10/2018")),
                               ChatMessage(message: "This is Sarnika Nattudurai", isOwnMsg: true, msgDate : Date.dateFromCustomString(customString: "31/10/2018")),
                               ChatMessage(message: "This is the sample app for chat application where we can see the dynamic cell depedns on the text size", isOwnMsg: false,  msgDate : Date.dateFromCustomString(customString: "31/10/2018")),
                               ChatMessage(message: "This is the sample app for chat application where we can see the dynamic cell depedns on the text size jadksbjkdasbcskjcbskcbskdcvbskdcvbaskdjvbksjdvbaskdjvbaksdvbkasdvskbdv", isOwnMsg: true,  msgDate : Date.dateFromCustomString(customString: "31/10/2018")),
                               ChatMessage(message: "This is Mounik Sharvanth Nattudurai", isOwnMsg: true, msgDate : Date.dateFromCustomString(customString: "27/02/2019")),
                                ChatMessage(message: "This is the sample app for chat application where we can see the dynamic cell depedns on the text size", isOwnMsg: false,  msgDate : Date.dateFromCustomString(customString: "27/02/2019")),
                                ChatMessage(message: "This is the sample app for chat application where we can see the dynamic cell depedns on the text size jadksbjkdasbcskjcbskcbskdcvbskdcvbaskdjvbksjdvbaskdjvbaksdvbkasdvskbdv", isOwnMsg: true,  msgDate : Date.dateFromCustomString(customString: "27/02/2019")),
                               ]

    
    fileprivate func groupDatabyDate()
    {
        let gropedMessages = Dictionary(grouping: messagesFromServer) { (element) -> Date in
            return element.msgDate
        }
        
        let sortedKeys = gropedMessages.keys.sorted()
        sortedKeys.forEach { (key) in
            let values = gropedMessages[key]
            
            chatMessages.append(values ?? [])
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        groupDatabyDate()
        self.title = "Messages"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.tableView.separatorStyle = .none
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm/dd/yyyy"
        if let content = chatMessages[section].first
        {
            return dateFormatter.string(from: content.msgDate)
        }
        return dateFormatter.string(from: Date())
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm/dd/yyyy"
        let content = chatMessages[section].first
        
        let dateLabel  = DateHeaderLabel()
        dateLabel.text = dateFormatter.string(from: (content?.msgDate) ?? Date())
        
        let containerView = UIView()
        containerView.addSubview(dateLabel)
        containerView.layer.cornerRadius = 10
        dateLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        return containerView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        //cell.textLabel?.text = "Nattudurai Eswaramurthy"
        let chatMessage = chatMessages[indexPath.section][indexPath.row];
        cell.chatMessage = chatMessage
        
        return cell
    }

}

