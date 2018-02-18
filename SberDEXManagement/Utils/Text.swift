//
// Created by Timofey on 10/27/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

protocol Text {

    func toAttributedString() -> NSAttributedString

    func toString() -> String

}

class EmptyText: Text {

    func toAttributedString() -> NSAttributedString {
        return NSAttributedString(string: self.toString())
    }

    func toString() -> String {
        return String()
    }

}

class MultiLineTexts: Text {

    private let textLines: [Text]
    init(textLines: [Text]) {
        self.textLines = textLines
    }

    //FIXME: Use joined() instead of this wtf
    private lazy var attributedString: NSAttributedString = {
        let string: NSMutableAttributedString = self.textLines.dropLast().reduce(NSMutableAttributedString()) { attributedString, line in
            attributedString.append(
                line.toAttributedString()
            )
            attributedString.append(
                NSAttributedString(string: "\n")
            )
            return attributedString
        }
        if let last = self.textLines.last {
            string.append(last.toAttributedString())
        }
        return string
    }()

    func toAttributedString() -> NSAttributedString {
        return attributedString
    }

    func toString() -> String {
        var string: String = self.textLines.dropLast().reduce("") { string, line in
            return string + line.toString() + "\n"
        }
        if let last = self.textLines.last {
            string += last.toString()
        }
        return string
    }

}

class InlineTexts: Text {

    private let inlineTexts: [Text]
    init(inlineTexts: [Text]) {
        self.inlineTexts = inlineTexts
    }

    private lazy var attributedString: NSAttributedString = {
        return self.inlineTexts.reduce(NSMutableAttributedString()) { string, text in
            string.append(text.toAttributedString())
            return string
        }
    }()

    func toAttributedString() -> NSAttributedString {
        return attributedString
    }

    func toString() -> String {
        return inlineTexts.reduce("") { $0 + $1.toString() }
    }

}

class SimpleText: Text {

    private let string: String
    private var attributes: [NSAttributedStringKey : Any]

    private init(string: String, attributes: [NSAttributedStringKey : Any]) {
        self.string = string
        self.attributes = attributes
    }

    convenience init(string: String, font: UIFont, color: UIColor) {
        self.init(
            string: string,
            attributes: [
                NSAttributedStringKey.font : font,
                NSAttributedStringKey.foregroundColor : color
            ]
        )
    }

    convenience init(string: String, font: UIFont) {
        self.init(
            string: string,
            attributes: [
                NSAttributedStringKey.font : font
            ]
        )
    }

    //TODO: Ensure caching is not consistent with `with` functions and it recomputed if attributes were changed
    private lazy var cachedAttributedString: NSAttributedString = {
        return NSAttributedString(
            string: self.string,
            attributes: attributes
        )
    }()
    func toAttributedString() -> NSAttributedString {
        return cachedAttributedString
    }

    func toString() -> String {
        return string
    }

    func with(letterSpacing: Double) -> Self {
        self.attributes[.kern] = letterSpacing
        return self
    }

}
