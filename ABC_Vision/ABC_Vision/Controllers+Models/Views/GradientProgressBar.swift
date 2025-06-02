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
    
    var colors: [UIColor] = [.red, .blue, .green] {
        didSet {
            updateGradientColors()
        }
    }
    
    private var progress: CGFloat = 0 {
        didSet {
            animateProgress()
        }
    }
    
    public func addToProgress(timesCorrect: Int){
        //made this so the progress bar would look like its filling up after each correct word
        switch timesCorrect {
        case 1: progress = 0.35
        case 2: progress = 0.67
        case 3: progress = 1.00
        default: progress = 0
        }
    }
    
    public func resetProgress(){
        progress = 0
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
        animateProgress()
    }
    
    private func updateGradientColors() {
        gradientLayer.colors = colors.map { $0.cgColor }
    }
    
    private func animateProgress() {
        // Calculate the target width
        let width = bounds.width * progress
        
        // Animate the frame of the progress layer
        UIView.animate(withDuration: 3.0) { [weak self] in
            self?.progressLayer.frame = CGRect(x: 0, y: 0, width: width, height: self?.bounds.height ?? 0)
        }
    }
}
