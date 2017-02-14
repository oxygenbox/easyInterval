//
//  Paths.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 2/14/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import Foundation
import UIKit


class Paths {
    static var walkingBody: UIBezierPath {
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 257.81, y: 168.25))
        bezier2Path.addLine(to: CGPoint(x: 221.65, y: 145.77))
        bezier2Path.addLine(to: CGPoint(x: 183.19, y: 89.91))
        bezier2Path.addCurve(to: CGPoint(x: 183.12, y: 89.82), controlPoint1: CGPoint(x: 183.17, y: 89.88), controlPoint2: CGPoint(x: 183.14, y: 89.85))
        bezier2Path.addCurve(to: CGPoint(x: 182.62, y: 89.12), controlPoint1: CGPoint(x: 182.96, y: 89.58), controlPoint2: CGPoint(x: 182.79, y: 89.35))
        bezier2Path.addCurve(to: CGPoint(x: 182.47, y: 88.91), controlPoint1: CGPoint(x: 182.57, y: 89.05), controlPoint2: CGPoint(x: 182.52, y: 88.98))
        bezier2Path.addCurve(to: CGPoint(x: 182.44, y: 88.87), controlPoint1: CGPoint(x: 182.46, y: 88.9), controlPoint2: CGPoint(x: 182.45, y: 88.89))
        bezier2Path.addCurve(to: CGPoint(x: 181.76, y: 88.06), controlPoint1: CGPoint(x: 182.22, y: 88.59), controlPoint2: CGPoint(x: 182, y: 88.33))
        bezier2Path.addCurve(to: CGPoint(x: 181.53, y: 87.8), controlPoint1: CGPoint(x: 181.68, y: 87.97), controlPoint2: CGPoint(x: 181.61, y: 87.88))
        bezier2Path.addCurve(to: CGPoint(x: 181.49, y: 87.77), controlPoint1: CGPoint(x: 181.52, y: 87.79), controlPoint2: CGPoint(x: 181.5, y: 87.78))
        bezier2Path.addCurve(to: CGPoint(x: 180.82, y: 87.11), controlPoint1: CGPoint(x: 181.28, y: 87.54), controlPoint2: CGPoint(x: 181.05, y: 87.33))
        bezier2Path.addCurve(to: CGPoint(x: 180.49, y: 86.81), controlPoint1: CGPoint(x: 180.71, y: 87.01), controlPoint2: CGPoint(x: 180.6, y: 86.9))
        bezier2Path.addCurve(to: CGPoint(x: 180.45, y: 86.78), controlPoint1: CGPoint(x: 180.48, y: 86.8), controlPoint2: CGPoint(x: 180.47, y: 86.79))
        bezier2Path.addCurve(to: CGPoint(x: 179.88, y: 86.31), controlPoint1: CGPoint(x: 180.27, y: 86.62), controlPoint2: CGPoint(x: 180.07, y: 86.46))
        bezier2Path.addCurve(to: CGPoint(x: 179.86, y: 86.3), controlPoint1: CGPoint(x: 179.87, y: 86.31), controlPoint2: CGPoint(x: 179.87, y: 86.3))
        bezier2Path.addCurve(to: CGPoint(x: 179.37, y: 85.93), controlPoint1: CGPoint(x: 179.7, y: 86.17), controlPoint2: CGPoint(x: 179.54, y: 86.05))
        bezier2Path.addCurve(to: CGPoint(x: 179.32, y: 85.89), controlPoint1: CGPoint(x: 179.35, y: 85.91), controlPoint2: CGPoint(x: 179.33, y: 85.9))
        bezier2Path.addCurve(to: CGPoint(x: 178.74, y: 85.51), controlPoint1: CGPoint(x: 179.13, y: 85.76), controlPoint2: CGPoint(x: 178.94, y: 85.64))
        bezier2Path.addCurve(to: CGPoint(x: 178.71, y: 85.49), controlPoint1: CGPoint(x: 178.73, y: 85.51), controlPoint2: CGPoint(x: 178.72, y: 85.5))
        bezier2Path.addCurve(to: CGPoint(x: 178.19, y: 85.17), controlPoint1: CGPoint(x: 178.53, y: 85.38), controlPoint2: CGPoint(x: 178.36, y: 85.27))
        bezier2Path.addCurve(to: CGPoint(x: 178.09, y: 85.12), controlPoint1: CGPoint(x: 178.15, y: 85.15), controlPoint2: CGPoint(x: 178.12, y: 85.14))
        bezier2Path.addCurve(to: CGPoint(x: 177.52, y: 84.82), controlPoint1: CGPoint(x: 177.9, y: 85.01), controlPoint2: CGPoint(x: 177.71, y: 84.92))
        bezier2Path.addCurve(to: CGPoint(x: 177.49, y: 84.81), controlPoint1: CGPoint(x: 177.51, y: 84.81), controlPoint2: CGPoint(x: 177.5, y: 84.81))
        bezier2Path.addCurve(to: CGPoint(x: 176.94, y: 84.53), controlPoint1: CGPoint(x: 177.31, y: 84.71), controlPoint2: CGPoint(x: 177.12, y: 84.62))
        bezier2Path.addCurve(to: CGPoint(x: 176.78, y: 84.47), controlPoint1: CGPoint(x: 176.88, y: 84.51), controlPoint2: CGPoint(x: 176.83, y: 84.49))
        bezier2Path.addCurve(to: CGPoint(x: 176.51, y: 84.34), controlPoint1: CGPoint(x: 176.69, y: 84.43), controlPoint2: CGPoint(x: 176.6, y: 84.38))
        bezier2Path.addCurve(to: CGPoint(x: 176.13, y: 84.21), controlPoint1: CGPoint(x: 176.38, y: 84.29), controlPoint2: CGPoint(x: 176.26, y: 84.26))
        bezier2Path.addCurve(to: CGPoint(x: 175.63, y: 84.03), controlPoint1: CGPoint(x: 175.97, y: 84.15), controlPoint2: CGPoint(x: 175.8, y: 84.08))
        bezier2Path.addCurve(to: CGPoint(x: 175.45, y: 83.97), controlPoint1: CGPoint(x: 175.57, y: 84.01), controlPoint2: CGPoint(x: 175.51, y: 83.99))
        bezier2Path.addCurve(to: CGPoint(x: 174.62, y: 83.73), controlPoint1: CGPoint(x: 175.18, y: 83.88), controlPoint2: CGPoint(x: 174.9, y: 83.8))
        bezier2Path.addCurve(to: CGPoint(x: 174.29, y: 83.64), controlPoint1: CGPoint(x: 174.51, y: 83.7), controlPoint2: CGPoint(x: 174.4, y: 83.67))
        bezier2Path.addCurve(to: CGPoint(x: 174.1, y: 83.61), controlPoint1: CGPoint(x: 174.23, y: 83.63), controlPoint2: CGPoint(x: 174.16, y: 83.62))
        bezier2Path.addCurve(to: CGPoint(x: 173.18, y: 83.43), controlPoint1: CGPoint(x: 173.8, y: 83.54), controlPoint2: CGPoint(x: 173.49, y: 83.48))
        bezier2Path.addCurve(to: CGPoint(x: 172.92, y: 83.39), controlPoint1: CGPoint(x: 173.09, y: 83.42), controlPoint2: CGPoint(x: 173.01, y: 83.4))
        bezier2Path.addCurve(to: CGPoint(x: 172.72, y: 83.37), controlPoint1: CGPoint(x: 172.85, y: 83.38), controlPoint2: CGPoint(x: 172.79, y: 83.38))
        bezier2Path.addCurve(to: CGPoint(x: 171.78, y: 83.29), controlPoint1: CGPoint(x: 172.41, y: 83.33), controlPoint2: CGPoint(x: 172.09, y: 83.31))
        bezier2Path.addCurve(to: CGPoint(x: 171.52, y: 83.27), controlPoint1: CGPoint(x: 171.69, y: 83.28), controlPoint2: CGPoint(x: 171.61, y: 83.27))
        bezier2Path.addCurve(to: CGPoint(x: 171.3, y: 83.27), controlPoint1: CGPoint(x: 171.45, y: 83.27), controlPoint2: CGPoint(x: 171.38, y: 83.27))
        bezier2Path.addCurve(to: CGPoint(x: 170.42, y: 83.28), controlPoint1: CGPoint(x: 171.01, y: 83.26), controlPoint2: CGPoint(x: 170.72, y: 83.27))
        bezier2Path.addCurve(to: CGPoint(x: 170.13, y: 83.28), controlPoint1: CGPoint(x: 170.32, y: 83.28), controlPoint2: CGPoint(x: 170.22, y: 83.28))
        bezier2Path.addCurve(to: CGPoint(x: 169.84, y: 83.31), controlPoint1: CGPoint(x: 170.03, y: 83.29), controlPoint2: CGPoint(x: 169.94, y: 83.3))
        bezier2Path.addCurve(to: CGPoint(x: 169.09, y: 83.39), controlPoint1: CGPoint(x: 169.59, y: 83.33), controlPoint2: CGPoint(x: 169.34, y: 83.36))
        bezier2Path.addCurve(to: CGPoint(x: 168.73, y: 83.43), controlPoint1: CGPoint(x: 168.97, y: 83.4), controlPoint2: CGPoint(x: 168.85, y: 83.42))
        bezier2Path.addCurve(to: CGPoint(x: 168.4, y: 83.5), controlPoint1: CGPoint(x: 168.62, y: 83.45), controlPoint2: CGPoint(x: 168.51, y: 83.48))
        bezier2Path.addCurve(to: CGPoint(x: 167.76, y: 83.63), controlPoint1: CGPoint(x: 168.18, y: 83.54), controlPoint2: CGPoint(x: 167.97, y: 83.58))
        bezier2Path.addCurve(to: CGPoint(x: 167.35, y: 83.72), controlPoint1: CGPoint(x: 167.62, y: 83.66), controlPoint2: CGPoint(x: 167.48, y: 83.69))
        bezier2Path.addCurve(to: CGPoint(x: 167.02, y: 83.82), controlPoint1: CGPoint(x: 167.24, y: 83.75), controlPoint2: CGPoint(x: 167.13, y: 83.79))
        bezier2Path.addCurve(to: CGPoint(x: 166.41, y: 84.01), controlPoint1: CGPoint(x: 166.82, y: 83.88), controlPoint2: CGPoint(x: 166.61, y: 83.94))
        bezier2Path.addCurve(to: CGPoint(x: 165.98, y: 84.15), controlPoint1: CGPoint(x: 166.27, y: 84.05), controlPoint2: CGPoint(x: 166.12, y: 84.1))
        bezier2Path.addCurve(to: CGPoint(x: 165.72, y: 84.26), controlPoint1: CGPoint(x: 165.89, y: 84.18), controlPoint2: CGPoint(x: 165.81, y: 84.22))
        bezier2Path.addCurve(to: CGPoint(x: 165.04, y: 84.54), controlPoint1: CGPoint(x: 165.49, y: 84.35), controlPoint2: CGPoint(x: 165.27, y: 84.44))
        bezier2Path.addCurve(to: CGPoint(x: 164.64, y: 84.72), controlPoint1: CGPoint(x: 164.91, y: 84.6), controlPoint2: CGPoint(x: 164.77, y: 84.66))
        bezier2Path.addCurve(to: CGPoint(x: 164.46, y: 84.82), controlPoint1: CGPoint(x: 164.58, y: 84.75), controlPoint2: CGPoint(x: 164.52, y: 84.78))
        bezier2Path.addCurve(to: CGPoint(x: 163.84, y: 85.15), controlPoint1: CGPoint(x: 164.25, y: 84.92), controlPoint2: CGPoint(x: 164.05, y: 85.03))
        bezier2Path.addCurve(to: CGPoint(x: 163.51, y: 85.33), controlPoint1: CGPoint(x: 163.73, y: 85.21), controlPoint2: CGPoint(x: 163.62, y: 85.26))
        bezier2Path.addLine(to: CGPoint(x: 163.27, y: 85.48))
        bezier2Path.addCurve(to: CGPoint(x: 163.14, y: 85.56), controlPoint1: CGPoint(x: 163.23, y: 85.51), controlPoint2: CGPoint(x: 163.18, y: 85.53))
        bezier2Path.addCurve(to: CGPoint(x: 163.04, y: 85.63), controlPoint1: CGPoint(x: 163.11, y: 85.58), controlPoint2: CGPoint(x: 163.08, y: 85.6))
        bezier2Path.addCurve(to: CGPoint(x: 162.87, y: 85.74), controlPoint1: CGPoint(x: 162.98, y: 85.67), controlPoint2: CGPoint(x: 162.92, y: 85.7))
        bezier2Path.addLine(to: CGPoint(x: 81.95, y: 138.13))
        bezier2Path.addLine(to: CGPoint(x: 82.44, y: 186.76))
        bezier2Path.addCurve(to: CGPoint(x: 96.43, y: 201.76), controlPoint1: CGPoint(x: 82.16, y: 194.76), controlPoint2: CGPoint(x: 88.42, y: 201.48))
        bezier2Path.addCurve(to: CGPoint(x: 111.43, y: 187.77), controlPoint1: CGPoint(x: 104.43, y: 202.04), controlPoint2: CGPoint(x: 111.15, y: 195.78))
        bezier2Path.addLine(to: CGPoint(x: 111.09, y: 153.75))
        bezier2Path.addLine(to: CGPoint(x: 148.1, y: 129.82))
        bezier2Path.addCurve(to: CGPoint(x: 131.32, y: 195.81), controlPoint1: CGPoint(x: 148.1, y: 129.82), controlPoint2: CGPoint(x: 131.33, y: 195.8))
        bezier2Path.addLine(to: CGPoint(x: 114.54, y: 268.3))
        bezier2Path.addLine(to: CGPoint(x: 72.78, y: 321.71))
        bezier2Path.addCurve(to: CGPoint(x: 76.11, y: 341.95), controlPoint1: CGPoint(x: 68.11, y: 328.22), controlPoint2: CGPoint(x: 69.6, y: 337.28))
        bezier2Path.addCurve(to: CGPoint(x: 96.35, y: 338.62), controlPoint1: CGPoint(x: 82.61, y: 346.62), controlPoint2: CGPoint(x: 91.68, y: 345.13))
        bezier2Path.addLine(to: CGPoint(x: 139.12, y: 283.92))
        bezier2Path.addCurve(to: CGPoint(x: 139.55, y: 283.37), controlPoint1: CGPoint(x: 139.27, y: 283.74), controlPoint2: CGPoint(x: 139.41, y: 283.56))
        bezier2Path.addLine(to: CGPoint(x: 139.72, y: 283.15))
        bezier2Path.addCurve(to: CGPoint(x: 139.86, y: 282.94), controlPoint1: CGPoint(x: 139.77, y: 283.08), controlPoint2: CGPoint(x: 139.81, y: 283.01))
        bezier2Path.addCurve(to: CGPoint(x: 140.38, y: 282.13), controlPoint1: CGPoint(x: 140.04, y: 282.67), controlPoint2: CGPoint(x: 140.21, y: 282.41))
        bezier2Path.addCurve(to: CGPoint(x: 140.66, y: 281.65), controlPoint1: CGPoint(x: 140.47, y: 281.97), controlPoint2: CGPoint(x: 140.57, y: 281.81))
        bezier2Path.addCurve(to: CGPoint(x: 141.03, y: 280.91), controlPoint1: CGPoint(x: 140.79, y: 281.41), controlPoint2: CGPoint(x: 140.91, y: 281.16))
        bezier2Path.addCurve(to: CGPoint(x: 141.32, y: 280.27), controlPoint1: CGPoint(x: 141.13, y: 280.7), controlPoint2: CGPoint(x: 141.23, y: 280.48))
        bezier2Path.addCurve(to: CGPoint(x: 141.56, y: 279.64), controlPoint1: CGPoint(x: 141.4, y: 280.06), controlPoint2: CGPoint(x: 141.48, y: 279.85))
        bezier2Path.addCurve(to: CGPoint(x: 141.83, y: 278.84), controlPoint1: CGPoint(x: 141.66, y: 279.37), controlPoint2: CGPoint(x: 141.75, y: 279.11))
        bezier2Path.addCurve(to: CGPoint(x: 141.93, y: 278.54), controlPoint1: CGPoint(x: 141.86, y: 278.74), controlPoint2: CGPoint(x: 141.9, y: 278.64))
        bezier2Path.addLine(to: CGPoint(x: 142, y: 278.21))
        bezier2Path.addCurve(to: CGPoint(x: 142.13, y: 277.64), controlPoint1: CGPoint(x: 142.05, y: 278.02), controlPoint2: CGPoint(x: 142.09, y: 277.83))
        bezier2Path.addLine(to: CGPoint(x: 154.07, y: 226.09))
        bezier2Path.addLine(to: CGPoint(x: 197.99, y: 263.34))
        bezier2Path.addLine(to: CGPoint(x: 209.97, y: 330.66))
        bezier2Path.addCurve(to: CGPoint(x: 224.97, y: 344.65), controlPoint1: CGPoint(x: 210.25, y: 338.67), controlPoint2: CGPoint(x: 216.96, y: 344.93))
        bezier2Path.addCurve(to: CGPoint(x: 238.96, y: 329.64), controlPoint1: CGPoint(x: 232.97, y: 344.37), controlPoint2: CGPoint(x: 239.24, y: 337.65))
        bezier2Path.addCurve(to: CGPoint(x: 224.36, y: 247.68), controlPoint1: CGPoint(x: 238.91, y: 328.26), controlPoint2: CGPoint(x: 224.36, y: 247.68))
        bezier2Path.addLine(to: CGPoint(x: 161.46, y: 194.33))
        bezier2Path.addLine(to: CGPoint(x: 177.11, y: 132.21))
        bezier2Path.addLine(to: CGPoint(x: 201.38, y: 167.45))
        bezier2Path.addLine(to: CGPoint(x: 201.47, y: 167.4))
        bezier2Path.addLine(to: CGPoint(x: 242.23, y: 192.71))
        bezier2Path.addCurve(to: CGPoint(x: 262.25, y: 188.27), controlPoint1: CGPoint(x: 248.98, y: 197.02), controlPoint2: CGPoint(x: 257.95, y: 195.03))
        bezier2Path.addCurve(to: CGPoint(x: 257.81, y: 168.25), controlPoint1: CGPoint(x: 266.56, y: 181.52), controlPoint2: CGPoint(x: 264.57, y: 172.56))
        bezier2Path.close()
        UIColor.black.setStroke()
        bezier2Path.lineWidth = 2.5
        bezier2Path.miterLimit = 4
        bezier2Path.stroke()
        return bezier2Path
    }
    
    
    static var walkingHead: UIBezierPath {
        let oval2Path = UIBezierPath(ovalIn: CGRect(x: 154.87, y: 13.32, width: 56.81, height: 56.81))
        UIColor.black.setStroke()
        oval2Path.lineWidth = 2.5
        oval2Path.stroke()
        return oval2Path
    }
    
    
    static var runningHead: UIBezierPath {
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 201.85, y: 36.5, width: 56.81, height: 56.81))
        // strokeColor.setStroke()
        ovalPath.lineWidth = 2.5
        ovalPath.stroke()
        return ovalPath
    }
    
    static var runningBody: UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 311.17, y: 143.34))
        bezierPath.addCurve(to: CGPoint(x: 292.71, y: 134.38), controlPoint1: CGPoint(x: 308.54, y: 135.77), controlPoint2: CGPoint(x: 300.28, y: 131.76))
        bezierPath.addLine(to: CGPoint(x: 236.57, y: 154.52))
        bezierPath.addLine(to: CGPoint(x: 211.57, y: 103.09))
        bezierPath.addCurve(to: CGPoint(x: 205.27, y: 95.6), controlPoint1: CGPoint(x: 210.45, y: 100.05), controlPoint2: CGPoint(x: 208.3, y: 97.36))
        bezierPath.addCurve(to: CGPoint(x: 202.52, y: 94.36), controlPoint1: CGPoint(x: 204.38, y: 95.08), controlPoint2: CGPoint(x: 203.46, y: 94.68))
        bezierPath.addLine(to: CGPoint(x: 130.32, y: 55.25))
        bezierPath.addLine(to: CGPoint(x: 123.91, y: 65.67))
        bezierPath.addCurve(to: CGPoint(x: 122.65, y: 67.49), controlPoint1: CGPoint(x: 123.45, y: 66.24), controlPoint2: CGPoint(x: 123.02, y: 66.84))
        bezierPath.addCurve(to: CGPoint(x: 121.96, y: 68.84), controlPoint1: CGPoint(x: 122.39, y: 67.93), controlPoint2: CGPoint(x: 122.16, y: 68.38))
        bezierPath.addLine(to: CGPoint(x: 118.94, y: 73.75))
        bezierPath.addLine(to: CGPoint(x: 87.53, y: 119.59))
        bezierPath.addCurve(to: CGPoint(x: 90.71, y: 139.85), controlPoint1: CGPoint(x: 82.81, y: 126.06), controlPoint2: CGPoint(x: 84.24, y: 135.14))
        bezierPath.addCurve(to: CGPoint(x: 110.98, y: 136.67), controlPoint1: CGPoint(x: 97.19, y: 144.57), controlPoint2: CGPoint(x: 106.26, y: 143.15))
        bezierPath.addLine(to: CGPoint(x: 140.25, y: 93.89))
        bezierPath.addLine(to: CGPoint(x: 179.68, y: 115.03))
        bezierPath.addLine(to: CGPoint(x: 140.46, y: 211.63))
        bezierPath.addLine(to: CGPoint(x: 79.67, y: 246.14))
        bezierPath.addLine(to: CGPoint(x: 33.74, y: 190.22))
        bezierPath.addCurve(to: CGPoint(x: 13.33, y: 188.22), controlPoint1: CGPoint(x: 28.66, y: 184.03), controlPoint2: CGPoint(x: 19.52, y: 183.13))
        bezierPath.addCurve(to: CGPoint(x: 11.33, y: 208.63), controlPoint1: CGPoint(x: 7.14, y: 193.3), controlPoint2: CGPoint(x: 6.24, y: 202.44))
        bezierPath.addLine(to: CGPoint(x: 64.61, y: 273.52))
        bezierPath.addCurve(to: CGPoint(x: 70.46, y: 278.11), controlPoint1: CGPoint(x: 66.17, y: 275.58), controlPoint2: CGPoint(x: 68.19, y: 277.14))
        bezierPath.addCurve(to: CGPoint(x: 70.79, y: 278.26), controlPoint1: CGPoint(x: 70.57, y: 278.16), controlPoint2: CGPoint(x: 70.68, y: 278.22))
        bezierPath.addCurve(to: CGPoint(x: 71.11, y: 278.37), controlPoint1: CGPoint(x: 70.9, y: 278.3), controlPoint2: CGPoint(x: 71, y: 278.33))
        bezierPath.addCurve(to: CGPoint(x: 84.31, y: 276.86), controlPoint1: CGPoint(x: 75.39, y: 279.99), controlPoint2: CGPoint(x: 80.32, y: 279.54))
        bezierPath.addLine(to: CGPoint(x: 153.6, y: 237.52))
        bezierPath.addLine(to: CGPoint(x: 221.29, y: 257.61))
        bezierPath.addLine(to: CGPoint(x: 202.95, y: 325.62))
        bezierPath.addCurve(to: CGPoint(x: 213.13, y: 343.43), controlPoint1: CGPoint(x: 200.85, y: 333.35), controlPoint2: CGPoint(x: 205.41, y: 341.32))
        bezierPath.addCurve(to: CGPoint(x: 230.94, y: 333.25), controlPoint1: CGPoint(x: 220.86, y: 345.53), controlPoint2: CGPoint(x: 228.84, y: 340.98))
        bezierPath.addLine(to: CGPoint(x: 256.81, y: 237.31))
        bezierPath.addLine(to: CGPoint(x: 232.03, y: 230.56))
        bezierPath.addLine(to: CGPoint(x: 171.19, y: 212.51))
        bezierPath.addCurve(to: CGPoint(x: 199.05, y: 143.66), controlPoint1: CGPoint(x: 181.31, y: 187.62), controlPoint2: CGPoint(x: 199.05, y: 143.66))
        bezierPath.addLine(to: CGPoint(x: 221.83, y: 190.51))
        bezierPath.addLine(to: CGPoint(x: 221.85, y: 190.57))
        bezierPath.addLine(to: CGPoint(x: 221.85, y: 190.57))
        bezierPath.addLine(to: CGPoint(x: 221.96, y: 190.78))
        bezierPath.addLine(to: CGPoint(x: 224.7, y: 189.55))
        bezierPath.addLine(to: CGPoint(x: 302.21, y: 161.79))
        bezierPath.addCurve(to: CGPoint(x: 311.17, y: 143.34), controlPoint1: CGPoint(x: 309.77, y: 159.17), controlPoint2: CGPoint(x: 313.79, y: 150.91))
        bezierPath.close()
        // strokeColor.setStroke()
        bezierPath.lineWidth = 2.5
        bezierPath.miterLimit = 4
        bezierPath.stroke()
        return bezierPath
    }
}
