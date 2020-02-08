//
//  PageContentViewController.swift
//  PagesAndPages
//
//  Copyright (C) 2020 Dan Poggi
//
//  This software may be modified and distributed under the terms
//  of the MIT license. See the LICENSE file for details.
//

import UIKit

private let loremIpsumParagraphs = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Amet consectetur adipiscing elit ut. Tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum. Quam vulputate dignissim suspendisse in est ante in. Proin sagittis nisl rhoncus mattis rhoncus urna. Amet est placerat in egestas erat imperdiet sed. Erat pellentesque adipiscing commodo elit. Donec adipiscing tristique risus nec feugiat in fermentum posuere. Cursus in hac habitasse platea. Metus aliquam eleifend mi in. Quis imperdiet massa tincidunt nunc pulvinar sapien et. Odio eu feugiat pretium nibh ipsum consequat nisl vel. Molestie nunc non blandit massa enim nec dui nunc. Tincidunt dui ut ornare lectus sit amet est placerat. Nibh nisl condimentum id venenatis a condimentum vitae sapien pellentesque. Velit egestas dui id ornare arcu odio ut sem. Mi sit amet mauris commodo quis.",
    "Gravida quis blandit turpis cursus in hac habitasse platea. Amet purus gravida quis blandit. Dui faucibus in ornare quam viverra orci sagittis eu volutpat. Fusce id velit ut tortor. Interdum consectetur libero id faucibus nisl. Donec massa sapien faucibus et molestie ac. Faucibus pulvinar elementum integer enim. Placerat in egestas erat imperdiet sed euismod nisi. Quis varius quam quisque id. Commodo viverra maecenas accumsan lacus vel facilisis volutpat. Amet mattis vulputate enim nulla aliquet porttitor lacus luctus accumsan. Massa tincidunt nunc pulvinar sapien et. Tristique sollicitudin nibh sit amet commodo nulla facilisi. Massa vitae tortor condimentum lacinia quis vel eros donec ac.",
    "Congue nisi vitae suscipit tellus mauris a diam. Senectus et netus et malesuada fames ac. Tempor orci dapibus ultrices in iaculis nunc sed. Sit amet cursus sit amet dictum sit amet justo. Consequat id porta nibh venenatis. Condimentum id venenatis a condimentum vitae sapien pellentesque. Sociis natoque penatibus et magnis dis. Congue nisi vitae suscipit tellus. Platea dictumst vestibulum rhoncus est pellentesque elit. Nec ullamcorper sit amet risus nullam eget.",
    "Egestas pretium aenean pharetra magna ac placerat. Tincidunt arcu non sodales neque sodales ut etiam. Mollis nunc sed id semper risus. Non arcu risus quis varius quam quisque id diam vel. Id eu nisl nunc mi ipsum faucibus vitae aliquet nec. Nibh tortor id aliquet lectus proin nibh nisl. Metus vulputate eu scelerisque felis imperdiet proin fermentum leo. Sed velit dignissim sodales ut eu sem integer vitae justo. Justo eget magna fermentum iaculis eu non diam phasellus. Laoreet sit amet cursus sit amet dictum. Enim ut sem viverra aliquet eget sit amet. Nunc sed augue lacus viverra. Sed lectus vestibulum mattis ullamcorper velit sed ullamcorper.",
    "Dui faucibus in ornare quam viverra orci sagittis. Vitae tortor condimentum lacinia quis vel eros donec. Quisque id diam vel quam elementum. Nulla facilisi morbi tempus iaculis. Eleifend quam adipiscing vitae proin sagittis. Neque sodales ut etiam sit amet nisl purus in mollis. Convallis convallis tellus id interdum velit laoreet id donec. Ultrices gravida dictum fusce ut placerat orci nulla. Imperdiet proin fermentum leo vel orci porta non pulvinar neque. Eget nulla facilisi etiam dignissim. Aliquet nibh praesent tristique magna sit amet purus. Amet consectetur adipiscing elit pellentesque habitant. Feugiat vivamus at augue eget arcu. Euismod elementum nisi quis eleifend quam adipiscing vitae proin sagittis. Elementum curabitur vitae nunc sed velit. Mi bibendum neque egestas congue. At quis risus sed vulputate odio. Nec feugiat nisl pretium fusce id. Urna id volutpat lacus laoreet non.",
]

private let loremIpsumAttributes: [NSAttributedString.Key : Any] = {
    let font: UIFont = .preferredFont(forTextStyle: .body)
    return [
        .font: font,
        .foregroundColor: UIColor.label,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.paragraphSpacing = font.pointSize
            return paragraphStyle.copy()
        }(),
    ]
}()

final class PageContentViewController: UIViewController {

    private static var loremIpsumParagraphIndexDividend: Int = 0

    @IBOutlet private var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstLoremIpsumParagraphIndex = Self.loremIpsumParagraphIndexDividend % loremIpsumParagraphs.endIndex
        Self.loremIpsumParagraphIndexDividend += 1
        let secondLoremIpsumParagraphIndex = Self.loremIpsumParagraphIndexDividend % loremIpsumParagraphs.endIndex

        var loremIpsum = loremIpsumParagraphs[firstLoremIpsumParagraphIndex]
        loremIpsum += "\u{2029}"
        loremIpsum += loremIpsumParagraphs[secondLoremIpsumParagraphIndex]

        textView.attributedText = NSAttributedString(string: loremIpsum, attributes: loremIpsumAttributes)
    }
}
