//
//  MainViewController.swift
//  PagesAndPages
//
//  Copyright (C) 2020 Dan Poggi
//
//  This software may be modified and distributed under the terms
//  of the MIT license. See the LICENSE file for details.
//

import Pageboy
import UIKit

private let _storyboard = UIStoryboard(name: "Main", bundle: nil)

final class MainViewController: UIViewController {

    private static let pageCount = 20

    @IBOutlet private var bottomView: UIView!
    @IBOutlet private var previousButton: UIButton!
    @IBOutlet private var currentPageLabel: UILabel!
    @IBOutlet private var nextButton: UIButton!

    private weak var pageViewController: PageboyViewController?

    private var pages: [PageboyViewController.PageIndex : UIViewController] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        previousButton.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        currentPageLabel.font = .preferredFont(forTextStyle: .title3)
        nextButton.titleLabel?.font = .preferredFont(forTextStyle: .title3)

        updateButtons(pageIndex: 0, animated: false)
        updateCurrentPageLabel(pageIndex: 0, animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PageboyViewController {
            pageViewController = destination
            pageViewController?.dataSource = self
            pageViewController?.delegate = self
        }
    }

    @IBAction private func scrollToPreviousPage() {
        pageViewController?.scrollToPage(.previous, animated: true)
    }

    @IBAction private func scrollToNextPage() {
        pageViewController?.scrollToPage(.next, animated: true)
    }

    private func updateButtons(pageIndex: PageboyViewController.PageIndex, animated: Bool) {
        guard let previousButton = previousButton, let nextButton = nextButton else { return }

        performControlsUpdate(animated: animated) {
            previousButton.isEnabled = pageIndex > 0
            nextButton.isEnabled = pageIndex < Self.pageCount - 1
        }
    }

    private func updateCurrentPageLabel(pageIndex: PageboyViewController.PageIndex, animated: Bool) {
        guard let currentPageLabel = currentPageLabel else { return }

        performControlsUpdate(animated: animated) {
            currentPageLabel.text = "\(pageIndex + 1)"
        }
    }

    private func performControlsUpdate(animated: Bool, handler: @escaping () -> Void) {
        if animated {
            UIView.transition(with: bottomView, duration: 0.3, options: [.transitionCrossDissolve], animations: handler)
        } else {
            handler()
        }
    }
}

extension MainViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return Self.pageCount
    }

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        if pages.index(forKey: index) == nil {
            pages[index] = _storyboard.instantiateViewController(withIdentifier: "PageContent")
        }

        return pages[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .first
    }
}

extension MainViewController: PageboyViewControllerDelegate {
    func pageboyViewController(_ pageboyViewController: PageboyViewController, willScrollToPageAt index: PageboyViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        updateButtons(pageIndex: index, animated: true)
    }

    func pageboyViewController(_ pageboyViewController: PageboyViewController, didCancelScrollToPageAt index: PageboyViewController.PageIndex, returnToPageAt previousIndex: PageboyViewController.PageIndex) {
        updateButtons(pageIndex: previousIndex, animated: true)
    }

    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: PageboyViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        updateCurrentPageLabel(pageIndex: index, animated: true)
    }

    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollTo position: CGPoint, direction: PageboyViewController.NavigationDirection, animated: Bool) {}
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didReloadWith currentViewController: UIViewController, currentPageIndex: PageboyViewController.PageIndex) {}
}
