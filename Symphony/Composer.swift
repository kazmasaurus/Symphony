//
//  Composer.swift
//  Symphony
//
//  Created by Jeff Boek on 12/31/15.
//  Copyright © 2015 Spilt Cocoa. All rights reserved.
//

import UIKit

/// A type that manages the presentation of one or many Composables
public protocol Composer: class {

    /// The ViewController type that the composer will use to contain
    /// and present the viewControllers of it's children
    associatedtype ContainerViewController: UIViewController

    /// The viewController instance that the composer will use to contain
    /// and present the viewControllers of it's children
    var containerViewController: ContainerViewController { get }

    /// A reference to the currently presented composable.
    /// This is generally only necissary for memory management,
    /// and shouldn't need to be messed with.
    var currentComposable: Composable? { get set }
}

// MARK: - Convenience API for Composers using UIKit `UIViewController`s

public extension Composer where ContainerViewController: UIViewController {

    public func presentComposable(composable: Composable, animated: Bool = false) {
        currentComposable = composable
        containerViewController.presentViewController(composable.viewController, animated: animated, completion: nil)
    }

    public func dismissComposableAnimated(animated: Bool = false) {
        containerViewController.dismissViewControllerAnimated(animated, completion: nil)
    }
}

public extension Composer where ContainerViewController: UINavigationController {

    public func pushComposable(composable: Composable, animated: Bool = false) {
        currentComposable = composable
        containerViewController.pushViewController(composable.viewController, animated: animated)
    }

    public func popComposable(animated: Bool = false) {
        containerViewController.popViewControllerAnimated(animated)
    }

    public func setComposables(composables: [Composable], animated: Bool = false) {
        currentComposable = composables.last
        containerViewController.setViewControllers(composables.map { $0.viewController }, animated: animated)
    }
}
