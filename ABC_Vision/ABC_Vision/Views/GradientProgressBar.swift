//
//  GradientProgressBar.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 12/15/24.
//

import Foundation
import UIKit

class GradientProgressBar: UIView {
    
    private let gradientLayer = CAGradientLayer()
    private let progressLayer = CALayer()
    
    var colors: [UIColor] = [.red, .orange, .yellow] {
        didSet {
            updateGradientColors()
        }
    }
    
    var progress: CGFloat = 0 {
        didSet {
            updateProgress()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Configure gradient layer
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = 5 // Optional: for rounded edges
        layer.addSublayer(gradientLayer)
        
        // Configure progress layer
        progressLayer.backgroundColor = UIColor.black.cgColor
        gradientLayer.mask = progressLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        updateProgress()
    }
    
    private func updateGradientColors() {
        gradientLayer.colors = colors.map { $0.cgColor }
    }
    
    private func updateProgress() {
        let width = bounds.width * progress
        progressLayer.frame = CGRect(x: 0, y: 0, width: width, height: bounds.height)
    }
}
