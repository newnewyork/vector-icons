//
//  IconView.swift
//  Icons
//
//  Created by Alejandro on 4/30/17.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import UIKit
import SwiftExtensions

public class IconView: UIView {
    
    public enum IconType {
        case none, plus, minus, tick, cross, chevronLeft, chevronRight, chevronUp, chevronDown
    }
    
    public var type = IconType.none
    
    public var drawBorder = true {
        didSet {
            setNeedsDisplay()
        }
    }
    public var lineWidth: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    public var color: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    public var showGrid = false {
        didSet {
            setNeedsDisplay()
        }
    }
    private let iconSize: CGFloat = 0.7 // percent of width
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
    }
    
    public convenience init(frame: CGRect, type: IconType) {
        self.init(frame: frame)
        self.type = type
        setNeedsDisplay()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setLineWidth(lineWidth)
        ctx.setStrokeColor(color.cgColor)
        
        // circle
        if drawBorder {
            let circle = CGRect(x: lineWidth/2, y: lineWidth/2, width: bounds.size.width - lineWidth, height: bounds.size.height - lineWidth)
            //            let circle = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
            ctx.setLineWidth(lineWidth)
            ctx.addEllipse(in: circle)
            ctx.strokePath()
        }
        
        let c = bounds.center
        //        print("Bounds: \(bounds)\tCenter: \(c)")
        var w = (bounds.size.width - 2 * lineWidth) * iconSize
        if drawBorder == false {
            w = (bounds.size.width) * iconSize
        }
        
        let sideInC = w / sqrt(2) // side of the square inscribed on a the circle defined by w
        
        switch type {
        case .none:
            break
        case .plus:
            // plus
            let p1 = CGPoint(x: c.x - w/2, y: c.y)
            let p2 = CGPoint(x: c.x + w/2, y: c.y)
            ctx.addLines(between: [p1, p2])
            
            let p3 = CGPoint(x: c.x, y: c.y - w/2)
            let p4 = CGPoint(x: c.x, y: c.y + w/2)
            ctx.addLines(between: [p3, p4])
            ctx.strokePath()
        case .minus:
            // plus
            let p1 = CGPoint(x: c.x - w/2 , y: c.y)
            let p2 = CGPoint(x: c.x + w/2, y: c.y)
            ctx.addLines(between: [p1, p2])
            ctx.strokePath()
        case .tick:
            let p1 = CGPoint(x: c.x + sideInC * 0.6 , y: c.y - sideInC * 0.5)
            let p2 = nextPoint(start: p1, angle: 3 * CGFloat.pi/4, lenght: w/1.05)
            let p3 = nextPoint(start: p2, angle: -1 * 3 * CGFloat.pi/4, lenght: w/2.75)
            ctx.addLines(between: [p1, p2, p3])
            ctx.strokePath()
        case .cross:
            let factor: CGFloat = 2.8
            let p1 = CGPoint(x: c.x + w/factor, y: c.y - w/factor)
            let p2 = CGPoint(x: c.x - w/factor, y: c.y + w/factor)
            ctx.addLines(between: [p1, p2])
            
            let p3 = CGPoint(x: c.x - w/factor, y: c.y - w/factor)
            let p4 = CGPoint(x: c.x + w/factor, y: c.y + w/factor)
            ctx.addLines(between: [p3, p4])
            
            ctx.strokePath()
        case .chevronRight:
            let p1 = CGPoint(x: c.x - w/2 + w/4, y: c.y - w/2)
            let p2 = nextPoint(start: p1, angle: CGFloat.pi/4, lenght: (w/2) * sqrt(2))
            let p3 = nextPoint(start: p2, angle: 3 * CGFloat.pi/4, lenght: (w/2) * sqrt(2))
            ctx.addLines(between: [p1, p2, p3])
            ctx.strokePath()
        case .chevronLeft:
            let p1 = CGPoint(x: c.x + w/2 - w/4, y: c.y - w/2)
            let p2 = nextPoint(start: p1, angle: 3 * CGFloat.pi/4, lenght: (w/2) * sqrt(2))
            let p3 = nextPoint(start: p2, angle: CGFloat.pi/4, lenght: (w/2) * sqrt(2))
            ctx.addLines(between: [p1, p2, p3])
            ctx.strokePath()
        case .chevronUp:
            let p1 = CGPoint(x: c.x - w/2, y: c.y + w/2 - w/4)
            let p2 = nextPoint(start: p1, angle: -1 * CGFloat.pi/4, lenght: (w/2) * sqrt(2))
            let p3 = nextPoint(start: p2, angle: CGFloat.pi/4, lenght: (w/2) * sqrt(2))
            ctx.addLines(between: [p1, p2, p3])
            ctx.strokePath()
        case .chevronDown:
            let p1 = CGPoint(x: c.x - w/2, y: c.y - w/2 + w/4)
            let p2 = nextPoint(start: p1, angle: CGFloat.pi/4, lenght: (w/2) * sqrt(2))
            let p3 = nextPoint(start: p2, angle: -1 * CGFloat.pi/4, lenght: (w/2) * sqrt(2))
            ctx.addLines(between: [p1, p2, p3])
            ctx.strokePath()

        default:
            return
        }
        
        if showGrid == false {
            return
        }
        
        //        ctx.setFillColor(UIColor.cyan.cgColor)
        //
        //        var c1 = CGRect(origin: bounds.center, size: CGSize(width: 10, height: 10))
        //        ctx.fill(c1)
        //        c1.origin.x -= 10
        //        c1.origin.y -= 10
        //        ctx.fill(c1)
        
        ctx.setStrokeColor(UIColor.cyan.cgColor)
        ctx.setLineWidth(1)
        
        let p1 = CGPoint(x: 0, y: c.y)
        let p2 = CGPoint(x: bounds.size.width, y: c.y)
        ctx.strokeLineSegments(between: [p1, p2])
        let p3 = CGPoint(x: c.x, y: 0)
        let p4 = CGPoint(x: c.x, y: bounds.size.height)
        ctx.strokeLineSegments(between: [p3, p4])
        
        let p5 = CGPoint(x: bounds.size.width/2 - w/2, y: 0)
        let p6 = CGPoint(x: bounds.size.width/2 - w/2, y: bounds.size.height)
        ctx.strokeLineSegments(between: [p5, p6])
        let p7 = CGPoint(x: bounds.size.width/2 + w/2, y: 0)
        let p8 = CGPoint(x: bounds.size.width/2 + w/2, y: bounds.size.height)
        ctx.strokeLineSegments(between: [p7, p8])
        
        let p9 = CGPoint(x: 0, y: bounds.center.y - w/2)
        let p10 = CGPoint(x: bounds.size.width, y: bounds.center.y - w/2)
        ctx.strokeLineSegments(between: [p9, p10])
        let p11 = CGPoint(x: 0, y: bounds.center.y + w/2)
        let p12 = CGPoint(x: bounds.size.width, y: bounds.center.y + w/2)
        ctx.strokeLineSegments(between: [p11, p12])
        
        // circle
        let c1 = CGRect(x: c.x - w/2, y: c.y - w/2, width: w, height: w)
        ctx.addEllipse(in: c1)
        ctx.strokePath()
        
        // square inscribed on the circle
        let s1 = CGPoint(x: c.x - sideInC/2, y: c.y - sideInC/2)
        let s2 = CGPoint(x: c.x + sideInC/2, y: c.y - sideInC/2)
        let s3 = CGPoint(x: c.x + sideInC/2, y: c.y + sideInC/2)
        let s4 = CGPoint(x: c.x - sideInC/2, y: c.y + sideInC/2)
        //        ctx.addLines(between: [s1,s2,s3,s4])
        ctx.strokeLineSegments(between: [s1,s2, s2, s3, s3, s4, s4, s1])
    }
    
    func nextPoint(start: CGPoint, angle a: CGFloat, lenght l: CGFloat) -> CGPoint {
        return CGPoint(x: start.x + l * cos(a), y: start.y + l * sin(a))
    }
    
}
