//
//  ContentView.swift
//  Drawing
//
//  Created by Ken Muyesu on 24/01/2022.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path

    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    var insetAmount = 0.0

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    func path (in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
}

struct ContentView: View {
    var body: some View {
        
//        Circle()
//            .stroke(.brown, lineWidth: 50)
            
//        Triangle()
//            .stroke(.cyan, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
//            .frame(width: 300, height: 300)
        
        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
            .strokeBorder(.cyan, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
            .frame(width: 300, height: 300)
//
//        Path { path in
//            path.move(to: CGPoint(x: 200, y: 100))
//            path.addLine(to: CGPoint(x: 100, y: 300))
//            path.addLine(to: CGPoint(x: 300, y: 300))
//            path.addLine(to: CGPoint(x: 200, y: 100))
//            //path.closeSubpath()
//
//        }
//        .stroke(.cyan, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
