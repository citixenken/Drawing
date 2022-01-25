//
//  ContentView.swift
//  Drawing
//
//  Created by Ken Muyesu on 24/01/2022.
//

import SwiftUI

//struct Triangle: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
//
//        return path
//
//    }
//}
//
//struct Arc: InsettableShape {
//    var startAngle: Angle
//    var endAngle: Angle
//    var clockwise: Bool
//
//    var insetAmount = 0.0
//
//    func inset(by amount: CGFloat) -> some InsettableShape {
//        var arc = self
//        arc.insetAmount += amount
//        return arc
//    }
//
//    func path (in rect: CGRect) -> Path {
//        let rotationAdjustment = Angle.degrees(90)
//        let modifiedStart = startAngle - rotationAdjustment
//        let modifiedEnd = endAngle - rotationAdjustment
//
//        var path = Path()
//        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
//
//        return path
//    }
//}

struct Flower: Shape {
    //How much to move this petal away from the center
    var petalOffset: Double = -20
    
    //How wide to make each petal
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        //The path that will hold all petals
        var path = Path()
        
        //Count from 0 upto pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            //rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)
            
            //move the petal to the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            //create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            
            //apply our rotation/position transfromation to the petal
            let rotatedPetal = originalPetal.applying(position)
            
            //add it to our main path
            path.addPath(rotatedPetal)
        }
        //send the main path back
        return path
    }
}

struct ContentView: View {
    
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        
        
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                //.stroke(.cyan, lineWidth: 2)
                .fill(.mint, style: FillStyle(eoFill: true))
            
            Text("Offset: \(petalOffset)")
            Slider(value: $petalOffset, in: -100...100)
                .padding([.horizontal, .bottom])
            
            Text("Width: \(petalWidth)")
            Slider(value: $petalWidth, in: 0...200)
                .padding([.horizontal, .bottom])
        }
//        Circle()
//            .stroke(.brown, lineWidth: 50)
            
//        Triangle()
//            .stroke(.cyan, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
//            .frame(width: 300, height: 300)
        
//        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
//            .strokeBorder(.cyan, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
//            .frame(width: 300, height: 300)
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
