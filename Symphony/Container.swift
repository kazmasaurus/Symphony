//
//  Container.swift
//  Symphony
//
//  Created by Jeff Boek on 1/7/16.
//  Copyright © 2016 Spilt Cocoa. All rights reserved.
//

public protocol ContainerType { }

extension UINavigationController: ContainerType {}
extension ContainerViewController: ContainerType {}


// A completely unadorned viewController container.
// i.e. no TabBar, NavigationBar, etc.. It just hot swaps children.
// Easy to swap other ViewControllers into with state changes.
public class ContainerViewController: UIViewController {

    // MARK: - Properties
    private var childViewController: UIViewController?

    // MARK: - Init
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    // MARK: - ViewContoller Containment
    override public func childViewControllerForStatusBarStyle() -> UIViewController? {
        return childViewController
    }

    func showViewController(viewController: UIViewController) {
        if let existingVC = childViewController {
            existingVC.willMoveToParentViewController(nil)
            existingVC.view.removeFromSuperview()
            existingVC.removeFromParentViewController()
        }

        childViewController = viewController
        addChildViewController(viewController)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        viewController.didMoveToParentViewController(self)
        setNeedsStatusBarAppearanceUpdate()
    }
}