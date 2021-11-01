//
//  StoryboardInit.swift
//  Randomco
//
//  Created by Víctor Jimenez on 31/10/21.
//

import UIKit

public protocol StoryboardViewController {
    static var storyboardName: String { get }
}

extension StoryboardViewController where Self: UIViewController {
    public static func initFromStoryboard() -> Self {
        guard let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController() else {
            fatalError()
        }
        
        return viewController as! Self
    }
}
