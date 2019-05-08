//
//  MessageLogController.swift
//  LocalMarketplace
//
//  Created by user153533 on 4/28/19.
//  Copyright © 2019 Andrew Yuen All rights reserved.
//

import UIKit
import Firebase

class MessageLogController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    var currentUser: User! {
        didSet {
            observeMessages()
        }
    }
    var receiver: String!
    
    // Create text field
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    let cellId = "cellId"
    var messages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = receiver
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        
        setupInput()
    }
    
    func observeMessages() {
        let ref = Database.database().reference().child("messages")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            for messageSnap in snapshot.children {
                let message = Message(snapshot: messageSnap as! DataSnapshot)
                
                if (message.to == self.currentUser.username && message.from == self.receiver) || (message.from == self.currentUser.username && message.to == self.receiver) {
                    self.messages.append(message.text!)
                }
            }
            
            self.collectionView.reloadData()
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        
        let message = messages[indexPath.row]
        cell.textView.text = message
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    // Set up text field and send button area
    func setupInput() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: UIControl.State())
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(send), for: .touchUpInside)
        containerView.addSubview(sendButton)

        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        containerView.addSubview(inputTextField)

        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1.0)
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorLineView)
        
        separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    @objc func send() {
        if inputTextField.text != "" {
            let newMessage = Message(to: receiver, text: inputTextField.text, from: currentUser.username)
            let ref = Database.database().reference().child("messages").childByAutoId()

            let values = ["to": newMessage.to, "text": newMessage.text, "from": newMessage.from]
            ref.updateChildValues(values as [AnyHashable : Any])
            
            inputTextField.text = ""
        }
    }
}
