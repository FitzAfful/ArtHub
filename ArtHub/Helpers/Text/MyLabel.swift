//
//  MyLabel.swift
//  ArtHub
//
//  Created by Fitzgerald Afful on 16/05/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class MyLabel: UIView
{
    private var _text: String = "SampleText"
    private var _color: UIColor = UIColor.white
    private var _stroke: UIColor = UIColor.black
    private var _strokeWidth: CGFloat = 2.0
    private var _font: UIFont = UIFont(name: "Helvetica Neue", size: 18)!
    private var _widgetColor: UIColor = UIColor(red: 0, green: 0.5, blue: 1.0, alpha: 1.0)
    private var _paraStyle = NSMutableParagraphStyle()

    private var borderLayer: CAShapeLayer!

    /// Whether the user is currently resizing the view or not.
    private var isResizing: Bool = false

    private let TEXT_MARGIN: CGFloat = 5
    private let HANDLE_WIDTH: CGFloat = 20
    private let MIN_FRAME_WIDTH: CGFloat = 60
    private let MIN_FRAME_HEIGHT: CGFloat = 40

    enum Edge {
        case topLeft, topRight, bottomLeft, bottomRight, none
    }

    static var edgeSize: CGFloat = 44.0
    private typealias `Self` = MyLabel

    var currentEdge: Edge = .none
    var touchStart = CGPoint.zero

    @IBInspectable
    public var text: String
    {
        get {
            return _text
        }
        set(value) {
            _text = value
            setNeedsDisplay()
        }
    }

    @IBInspectable
    public var color: UIColor
    {
        get {
            return _color
        }
        set(value) {
            _color = value
            setNeedsDisplay()
        }
    }

    @IBInspectable
    public var stroke: UIColor
    {
        get {
            return _stroke
        }
        set(value) {
            _stroke = value
            setNeedsDisplay()
        }
    }

    @IBInspectable
    public var paragraphStyle: NSMutableParagraphStyle
    {
        get {
            return _paraStyle
        }
        set(value) {
            _paraStyle = value
            setNeedsDisplay()
        }
    }

    @IBInspectable
    public var strokeWidth: CGFloat
    {
        get {
            return _strokeWidth
        }
        set(value) {
            _strokeWidth = value
            setNeedsDisplay()
        }
    }

    public var font: UIFont
    {
        get {
            return _font
        }
        set(value) {
            _font = value
            setNeedsDisplay()
        }
    }

    @IBInspectable
    public var widgetColor: UIColor
    {
        get {
            return _widgetColor
        }
        set(value) {
            _widgetColor = value
            setNeedsDisplay()
        }
    }


    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first {

            touchStart = touch.location(in: self)

            currentEdge = {
                if self.bounds.size.width - touchStart.x < Self.edgeSize && self.bounds.size.height - touchStart.y < Self.edgeSize {
                    return .bottomRight
                } else if touchStart.x < Self.edgeSize && touchStart.y < Self.edgeSize {
                    return .topLeft
                } else if self.bounds.size.width-touchStart.x < Self.edgeSize && touchStart.y < Self.edgeSize {
                    return .topRight
                } else if touchStart.x < Self.edgeSize && self.bounds.size.height - touchStart.y < Self.edgeSize {
                    return .bottomLeft
                }
                return .none
            }()
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            let previous = touch.previousLocation(in: self)

            let originX = self.frame.origin.x
            let originY = self.frame.origin.y
            let width = self.frame.size.width
            let height = self.frame.size.height

            let deltaWidth = currentPoint.x - previous.x
            let deltaHeight = currentPoint.y - previous.y

            switch currentEdge {
            case .topLeft:
                self.frame = CGRect(x: originX + deltaWidth, y: originY + deltaHeight, width: width - deltaWidth, height: height - deltaHeight)
            case .topRight:
                self.frame = CGRect(x: originX, y: originY + deltaHeight, width: width + deltaWidth, height: height - deltaHeight)
            case .bottomRight:
                self.frame = CGRect(x: originX, y: originY, width: width + deltaWidth, height: height + deltaWidth)
            case .bottomLeft:
                self.frame = CGRect(x: originX + deltaWidth, y: originY, width: width - deltaWidth, height: height + deltaHeight)
            default:
                self.center = CGPoint(x: self.center.x + currentPoint.x - touchStart.x,
                                      y: self.center.y + currentPoint.y - touchStart.y)
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentEdge = .none
    }

    private func setup()
    {
        isUserInteractionEnabled = true
        clipsToBounds = false
    }

    private func updateBorder(_ rect: CGRect)
    {
        let borderRect = CGRect(
            x: 0,
            y: 0,
            width: rect.width - HANDLE_WIDTH / 2,
            height: rect.height - HANDLE_WIDTH / 2
        )
        let border = UIBezierPath(roundedRect: borderRect, cornerRadius: 3)
        borderLayer = CAShapeLayer()
        borderLayer.path = border.cgPath
        borderLayer.strokeColor = widgetColor.cgColor
        borderLayer.lineDashPattern = [4,2]
        borderLayer.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
    }

    override func draw(_ rect: CGRect)
    {
        ///Draw the bounding dashed border
        if let borderLayer = borderLayer {
            borderLayer.removeFromSuperlayer()
        }
        updateBorder(rect)
        self.layer.addSublayer(borderLayer)

        let s: NSString = text as NSString

        let attributes = [
            NSAttributedString.Key.strokeWidth: _strokeWidth * -1,
            NSAttributedString.Key.strokeColor: _stroke,
            NSAttributedString.Key.foregroundColor: _color,
            NSAttributedString.Key.paragraphStyle: _paraStyle,
            NSAttributedString.Key.obliqueness: 0.0,
            NSAttributedString.Key.font: _font
            ] as [NSAttributedString.Key : Any]

        let textRect = CGRect(
            x: TEXT_MARGIN,
            y: TEXT_MARGIN,
            width: rect.width - HANDLE_WIDTH - TEXT_MARGIN,
            height: rect.height - HANDLE_WIDTH / 2 - TEXT_MARGIN
        )

        s.draw(in: textRect, withAttributes: attributes)
    }
}

