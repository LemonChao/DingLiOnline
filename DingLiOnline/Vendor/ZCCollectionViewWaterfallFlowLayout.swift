//
//  ZCCollectionViewWaterfallFlowLayout.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/30.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

@objc protocol ZCWaterfallFlowLayoutDataSource: NSObjectProtocol {
    
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, numberOfColumnInSection section: NSInteger) -> Int
    
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, _ itemWidth: CGFloat,  heightForItemAtIndexPath: IndexPath) -> CGFloat
    
    /// Column spacing between columns
    @objc optional func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    
    /// The spacing between rows and rows
    @objc optional func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    
    @objc optional func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    
    @objc optional func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    
    @objc optional func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, referenceSizeForFooterInSection section: Int) -> CGSize

}



class ZCWaterfallFlowLayout: UICollectionViewLayout {
    var minimumLineSpacing: CGFloat = 0
    var minimumInteritemSpacing: CGFloat = 0
    var sectionHeadersPinToVisibleBounds: Bool = false
    var dataSource: ZCWaterfallFlowLayoutDataSource?
    
    // privete instance
    var itemLayoutAttributes: [[UICollectionViewLayoutAttributes]] = []
    var headerLayoutAttributes: [UICollectionViewLayoutAttributes] = []
    var footerLayoutAttributes: [UICollectionViewLayoutAttributes] = []
    var heightOfSections: [CGFloat] = []
    var contentHeight: CGFloat = 0
    
    
    
    
    
    
    override func prepare() {
        super.prepare()
        assert(self.dataSource != nil, "CollectionViewWaterfallFlowLayout.dataSource cann't be nil.")
        
        // 注释掉 防止刷新不及时
//        if self.collectionView!.isDragging || self.collectionView!.isDragging {
//            return
//        }
        
        contentHeight = 0.0
        itemLayoutAttributes = []
        headerLayoutAttributes = []
        footerLayoutAttributes = []
        heightOfSections = []
        
        let collectionView = self.collectionView!
        let numberOfSections = collectionView.numberOfSections
        let contentInset = collectionView.contentInset
        let contentWidth = collectionView.bounds.width - contentInset.left - contentInset.right
        
        for section in 0..<numberOfSections {
            
            let columnOfSection = self.dataSource!.collectionView(collectionView, self, numberOfColumnInSection: section)
            assert(columnOfSection > 0, "collectionView(_:_:numberOfColumnInSection:) must be greater than 0.")
            
            let contentInsetOfSection = self.contentInsetForSection(section)
            let minimumLineSpacing = self.minimumLineSpacingForSection(section)
            let minimumInteritemSpacing = self.minimumInteritemSpacingForSection(section)
            let contentWidthOfSection = contentWidth - contentInsetOfSection.left - contentInsetOfSection.right
            let itemWidth = (contentWidthOfSection - CGFloat(columnOfSection - 1) * minimumInteritemSpacing) / CGFloat(columnOfSection)
            let numberOfItems = collectionView.numberOfItems(inSection: section)
            
            // Per section header
            var headerHeight: CGFloat = 0.0
            
            if self.dataSource != nil && (self.dataSource?.responds(to: #selector(self.dataSource?.collectionView(_:_:referenceSizeForHeaderInSection:))))! {
                headerHeight = (self.dataSource?.collectionView?(collectionView, self, referenceSizeForHeaderInSection: section).height)!
            }
            let headerLayoutAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(item: 0, section: section))
            headerLayoutAttribute.frame = CGRect(x: 0, y: contentHeight, w: contentWidth, h: headerHeight)
            headerLayoutAttributes.append(headerLayoutAttribute)
            
            // The current section's offset for per column.
            var offsetOfColumns = Array(repeating: CGFloat(0), count: columnOfSection)
            for i in 0..<columnOfSection {
                offsetOfColumns[i] = headerHeight + contentInsetOfSection.top
            }
            
            var layoutAttributeOfSection: [UICollectionViewLayoutAttributes] = []
            for item in 0..<numberOfItems {
                // Find minimum offset and fill to it.
                var currentColumn: Int = 0
                for i in 1..<columnOfSection {
                    if offsetOfColumns[currentColumn] > offsetOfColumns[i] {
                        currentColumn = i
                    }
                }
                
                let indexPath: IndexPath = IndexPath(item: item, section: section)
                let itemHeight = self.dataSource?.collectionView(collectionView, self, itemWidth, heightForItemAtIndexPath: indexPath)
                let x = contentInsetOfSection.left + itemWidth * CGFloat(currentColumn) + minimumInteritemSpacing * CGFloat(currentColumn)
                let y = offsetOfColumns[currentColumn] + (item >= columnOfSection ? minimumLineSpacing : 0.0)
                let layoutAttbiture = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                layoutAttbiture.frame = CGRect(x: x, y: y + contentHeight, w: itemWidth, h: itemHeight!)
                layoutAttributeOfSection.append(layoutAttbiture)
                
                // Update y offset in current column
                offsetOfColumns[currentColumn] = y + itemHeight!
            }
            itemLayoutAttributes.append(layoutAttributeOfSection)
            
            // Get current section height from offset record.
            var maxOffsetValue = offsetOfColumns.reduce(offsetOfColumns[0]) { max($0, $1) }
            maxOffsetValue += contentInsetOfSection.bottom
            
            // Per section footer
            var footerHeader: CGFloat = 0.0
            if self.dataSource != nil && (self.dataSource?.responds(to: #selector(self.dataSource?.collectionView(_:_:referenceSizeForHeaderInSection:))))! {
                footerHeader = (self.dataSource?.collectionView?(collectionView, self, referenceSizeForFooterInSection: section).height)!
            }
            let footerLayoutAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: IndexPath(item: 0, section: section))
            footerLayoutAttribute.frame = CGRect(x: 0, y: contentHeight + maxOffsetValue, w: contentWidth, h: footerHeader)
            footerLayoutAttributes.append(footerLayoutAttribute)
            
            /** Update UICollectionView content height.
             Section height contain from the top of the headerView to the bottom of the footerView. */
            let currentSectionHeight = maxOffsetValue + footerHeader
            heightOfSections.append(currentSectionHeight)
            
            contentHeight += currentSectionHeight
        }
        
        
//        var section: Int = 0
//        while section < numberOfSections {
//            let columnOfSection = self.dataSource!.collectionView(collectionView, self, numberOfColumnInSection: section)
//            assert(columnOfSection > 0, "collectionView(_:_:numberOfColumnInSection:) must be greater than 0.")
//
//            let contentInsetOfSection = self.contentInsetForSection(section)
//            let minimumLineSpacing = self.minimumLineSpacingForSection(section)
//            let minimumInteritemSpacing = self.minimumInteritemSpacingForSection(section)
//            let contentWidthOfSection = contentWidth - contentInsetOfSection.left - contentInsetOfSection.right
//            let itemWidth = (contentWidthOfSection - CGFloat(columnOfSection - 1) * minimumInteritemSpacing) / CGFloat(columnOfSection)
//            let numberOfItems = collectionView.numberOfItems(inSection: section)
//
//            // Per section header
//            var headerHeight: CGFloat = 0.0
//
//            if self.dataSource != nil && (self.dataSource?.responds(to: #selector(self.dataSource?.collectionView(_:_:referenceSizeForHeaderInSection:))))! {
//                headerHeight = (self.dataSource?.collectionView?(collectionView, self, referenceSizeForHeaderInSection: section).height)!
//            }
//            let headerLayoutAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(item: 0, section: section))
//            headerLayoutAttribute.frame = CGRect(x: 0, y: contentHeight, w: contentWidth, h: headerHeight)
//            headerLayoutAttributes.append(headerLayoutAttribute)
//
//            // The current section's offset for per column.
//            var offsetOfColumns = Array(repeating: CGFloat(0), count: columnOfSection)
//
//            var indexOfColumns = 0
//            while indexOfColumns < columnOfSection {
//                offsetOfColumns[indexOfColumns] = headerHeight + contentInsetOfSection.top
//                indexOfColumns += 1
//            }
//
//            var layoutAttributeOfSection: [UICollectionViewLayoutAttributes] = []
//            for item in 0...numberOfItems {
//                // Find minimum offset and fill to it.
//                var currentColumn: Int = 0
//                for i in 1..<columnOfSection {
//                    if offsetOfColumns[currentColumn] > offsetOfColumns[i] {
//                        currentColumn = i
//                    }
//                }
//
//                let indexPath: IndexPath = IndexPath(item: item, section: section)
//                let itemHeight = self.dataSource?.collectionView(collectionView, self, itemWidth, heightForItemAtIndexPath: indexPath)
//                let x = contentInsetOfSection.left + itemWidth * CGFloat(currentColumn) + minimumInteritemSpacing * CGFloat(currentColumn)
//                let y = offsetOfColumns[currentColumn] + (item>=columnOfSection ? minimumLineSpacing : 0.0)
//                let layoutAttbiture = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//                layoutAttbiture.frame = CGRect(x: x, y: y + contentHeight, w: itemWidth, h: itemHeight!)
//                layoutAttributeOfSection.append(layoutAttbiture)
//
//                // Update y offset in current column
//                offsetOfColumns[currentColumn] = y + itemHeight!
//            }
//            itemLayoutAttributes.append(layoutAttributeOfSection)
//
//            // Get current section height from offset record.
//            var maxOffsetValue = offsetOfColumns.reduce(0) {max($0, $1) }
//            maxOffsetValue += contentInsetOfSection.bottom
//
//            // Per section footer
//            var footerHeader: CGFloat = 0.0
//            if self.dataSource != nil && (self.dataSource?.responds(to: #selector(self.dataSource?.collectionView(_:_:referenceSizeForHeaderInSection:))))! {
//                footerHeader = (self.dataSource?.collectionView?(collectionView, self, referenceSizeForFooterInSection: section).height)!
//            }
//            let footerLayoutAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: IndexPath(item: 0, section: section))
//            footerLayoutAttribute.frame = CGRect(x: 0, y: contentHeight + maxOffsetValue, w: contentWidth, h: footerHeader)
//            footerLayoutAttributes.append(footerLayoutAttribute)
//
//            /** Update UICollectionView content height.
//             Section height contain from the top of the headerView to the bottom of the footerView. */
//            let currentSectionHeight = maxOffsetValue + footerHeader
//            heightOfSections.append(currentSectionHeight)
//
//            contentHeight += currentSectionHeight
//            section += 1
//        }
        
        
    }
    
    
    
    override var collectionViewContentSize: CGSize {
        get {
            let contentInset = self.collectionView!.contentInset
            let width = self.collectionView!.bounds.width - contentInset.left - contentInset.right
            let height = max(self.collectionView!.bounds.height, contentHeight)
            return CGSize(width: width, height: height)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var result: [UICollectionViewLayoutAttributes] = []
        for layoutAttributeOfSection in itemLayoutAttributes {
            for attribute in layoutAttributeOfSection {
//                if rect.intersects(attribute.frame) {
//                    result.append(attribute)
//                }
                if rect.intersects(attribute.frame) {
                    result.append(attribute)
                }

            }
        }
        
        for attribute in headerLayoutAttributes {
            if attribute.frame.height != 0 && rect.intersects(attribute.frame) {
                result.append(attribute)
            }
        }
        
        for attribute in footerLayoutAttributes {
            if attribute.frame.height != 0 && rect.intersects(attribute.frame) {
                result.append(attribute)
            }
        }

        //Header view hover.
        if sectionHeadersPinToVisibleBounds {
            for attriture in result {
                if attriture.representedElementKind == UICollectionView.elementKindSectionHeader {
                    let section = attriture.indexPath.section
                    let contentInsetOfSection = self.contentInsetForSection(section)
                    let firstIndexPath = IndexPath(item: 0, section: section)
                    let itemAttribute = self.layoutAttributesForItem(at: firstIndexPath)
                    let headerHeight = attriture.frame.height
                    var frame = attriture.frame
                    frame.origin.y = min(max((self.collectionView?.contentOffset.y)!,
                                             itemAttribute!.frame.midY - headerHeight - contentInsetOfSection.top),
                                         itemAttribute!.frame.minY + heightOfSections[section])
                    attriture.frame = frame
                    attriture.zIndex = (NSIntegerMax/2)+section
                }
            }
        }
        
        return result
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return itemLayoutAttributes[indexPath.section][indexPath.row]
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == UICollectionView.elementKindSectionHeader {
            return headerLayoutAttributes[indexPath.item]
        }
        
        if elementKind == UICollectionView.elementKindSectionFooter {
            return footerLayoutAttributes[indexPath.item]
        }
        return nil
    }
    
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }
    
    /// private
    private func contentInsetForSection(_ section: Int) -> UIEdgeInsets {
        if self.dataSource != nil && (self.dataSource?.responds(to: #selector(self.dataSource?.collectionView(_:_:insetForSectionAt:))))! {
            return (self.dataSource?.collectionView?(self.collectionView!, self, insetForSectionAt: section))!
        }else {
            return UIEdgeInsets.zero
        }
    }
    
    private func minimumLineSpacingForSection(_ section: Int) -> CGFloat {
        if self.dataSource != nil && (self.dataSource?.responds(to: #selector(self.dataSource?.collectionView(_:_:minimumLineSpacingForSectionAt:))))! {
            return (self.dataSource?.collectionView?(self.collectionView!, self, minimumLineSpacingForSectionAt: section))!
        }else {
            return self.minimumLineSpacing
        }
    }

    private func minimumInteritemSpacingForSection(_ section: Int) -> CGFloat {
        if self.dataSource != nil && (self.dataSource?.responds(to: #selector(self.dataSource?.collectionView(_:_:minimumInteritemSpacingForSectionAt:))))! {
            return (self.dataSource?.collectionView?(self.collectionView!, self, minimumInteritemSpacingForSectionAt: section))!
        }else {
            return self.minimumInteritemSpacing
        }

    }

    
}
