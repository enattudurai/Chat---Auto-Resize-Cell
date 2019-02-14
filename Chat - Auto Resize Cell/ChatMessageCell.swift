//
//  ChatMessageCell.swift
//  Chat - Auto Resize Cell
//
//  Created by Naattudurai Eswaramurthy on 14/02/19.
//  Copyright © 2019 Naattudurai Eswaramurthy. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {

    let messageLabel = UILabel()
    let chatBackgroundView = UIView()
    var leadingConstraintAnchor  :NSLayoutConstraint!
    var trailingConstraintAnchor  :NSLayoutConstraint!
    
    var chatMessage : ChatMessage! {
        didSet
        {
            messageLabel.text = chatMessage.message
            chatBackgroundView.backgroundColor = chatMessage.isOwnMsg ? .green : .white
            if (chatMessage.isOwnMsg)
            {
                leadingConstraintAnchor.isActive = false
                trailingConstraintAnchor.isActive = true
            }
            else
            {
                leadingConstraintAnchor.isActive = true
                trailingConstraintAnchor.isActive = false
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        chatBackgroundView.backgroundColor = .red
        chatBackgroundView.layer.cornerRadius = 10
        addSubview(chatBackgroundView)
        
        addSubview(messageLabel)
        messageLabel.numberOfLines = 0
        
        messageLabel.text = "Nattudurai Eswaramurthy Priya Marimuthu Sarnika Nattudurai Mounik Sharvanth Nattudurai"
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        chatBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant : 16),
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant : -32),
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
        
        chatBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant : -16),
        chatBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant : -16),
        chatBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant : 16),
        chatBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant : 16)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraintAnchor = messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant : 32)
        trailingConstraintAnchor = messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant : -32)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
