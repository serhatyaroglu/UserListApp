//
//  AlertButton.swift
//  User List App
//
//  Created by serhat yaroglu on 7.02.2025.
//

import UIKit

public class AlertButton : NSObject{
    public init(title: String = "Okay", style : UIAlertAction.Style = .default , completion: @escaping () -> ()) {
        self.title = title
        self.completion = completion
        self.style = style
    }
    public var title = String()
    public var completion: () -> ()
    public var style : UIAlertAction.Style = .default
}
