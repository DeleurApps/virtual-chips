//
//  InGameViewController.swift
//  VirtualChips
//
//  Created by David Valdez on 11/16/17.
//  Copyright © 2017 company. All rights reserved.
//
//Stiven Deleur, Anubhav Garg, Valerie Gomez, David Valdez, Rohan Shastri
import UIKit
import Starscream
class InGameViewController: UIViewController {
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("the socket has connected!!")
        
        //case for login
        
        let jsonEncoder = JSONEncoder()
        
        do {
            if let jsonData = try? jsonEncoder.encode(message1) {
                if let jsonString = String(data: jsonData, encoding: .utf8){
                    socket.write(string: jsonString)
                    print("below is the jsonString")
                    print(jsonString)
                    print("has tried to write the data")
                }
                else{
                    print ("encoding failed")
                }
            }
            else {
                print ("encoding failed")
                return
            }
        }
        //case for register
        //case for startgaem
        
    }
    
   
    @IBOutlet weak var FoldButton: UIButton!
    @IBOutlet weak var RaiseField: UITextField!
    @IBOutlet weak var CallButton: UIButton!
    @IBOutlet weak var CheckButton: UIButton!
    @IBOutlet weak var RaiseButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        RaiseField.isHidden = true
    }
    
    let currentCallAmount = 0
    let currentMaxBet = 0
    let currentMinBet = 0
    let currentPotSize = 0
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("below is the text from the server")
        print(text)
        
        let jsonData = text.data(using: .utf8)!
        let decoder = JSONDecoder()
        let receivedMessage = try! decoder.decode(ReceivedMessage.self, from: jsonData)
        print ("This is the recieved message")
        print (receivedMessage)
        
        if (receivedMessage.event == "moveOptions"){
            if (receivedMessage.params["canCheck"] == "true"){
                //display the check option for the user
                CheckButton.isHidden = false;
            }
            else{
                CheckButton.isHidden = true;
            }
            if (receivedMessage.params["canRaise" == "true"]){
                //display the option for raising to the user
                RaiseButton.isHidden = false;
            }
            else {
                RaiseButton.isHidden = true;
            }
            if (receivedMessage.params["canCall" == "true"]){
                //display the option for raising to the user
                CallButton.isHidden = true;
            }
            else{
                CallButton.isHidden = false;
            }
            currentCallAmount = Int (receivedMessage.params["callAmount"])
            currentMaxBet = Int (receivedMessage.params["maxRaise"])
            currentMinBet = Int (receivedMessage.params["minRaise"])
            currentPotSize = Int (receivedMessage.params["potSize"])
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func raiseClicked(_ sender: Any) {
        RaiseField.isHidden = false
    }
    

}
