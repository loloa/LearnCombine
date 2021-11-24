//
//  ViewController.swift
//  LearnCombine
//
//  Created by Lilia Lashin on 24/11/2021.
//

import UIKit
import Combine

extension Notification.Name {
    static let example = Notification.Name("example")
}

class ViewController: UIViewController {

    
    var cancellable: AnyCancellable?
    var tcancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cancellable = NotificationCenter.Publisher(center: .default, name: .example, object: nil)
            .sink { notification in
                print(notification)
            }
        
        //post notification
//        NotificationCenter.default.post(name: .example, object: nil)
        
        // start automatically
        
         
        var secondsStart = 0
        
        self.tcancellable = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .sink { [unowned self] date in
 
                secondsStart += 1
                
                if secondsStart <= 2 {
                    print(secondsStart)
                    NotificationCenter.default.post(name: .example, object: nil)
                } else {
                    self.tcancellable?.cancel()
                    self.cancellable?.cancel()
                }
                
               
            }
        
    }


}

