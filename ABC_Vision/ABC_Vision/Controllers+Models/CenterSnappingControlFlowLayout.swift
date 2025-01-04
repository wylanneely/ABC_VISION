//
//  CenterSnappingControlFlowLayout.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 12/13/24.
//

import Foundation
import UIKit

class CenterSnappingFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else { return proposedContentOffset }
        
        // Calculate the center of the collection view
        let centerX = collectionView.bounds.size.width / 2
        let proposedCenterX = proposedContentOffset.x + centerX
        
        // Get all layout attributes for the visible area
        guard let attributes = self.layoutAttributesForElements(in: collectionView.bounds) else {
            return proposedContentOffset
        }
        
        // Find the attribute closest to the center
        let closest = attributes.min(by: { abs($0.center.x - proposedCenterX) < abs($1.center.x - proposedCenterX) })
        
        // Calculate new content offset to center the cell
        guard let closestCenter = closest?.center else { return proposedContentOffset }
        let offsetX = closestCenter.x - centerX
        
        return CGPoint(x: offsetX, y: proposedContentOffset.y)
    }
}
