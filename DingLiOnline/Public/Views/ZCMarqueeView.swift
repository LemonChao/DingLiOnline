//
//  ZCMarqueeView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/28.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit


/// 跑马灯view
class ZCMarqueeView: UIView {

    init(frame: CGRect, titles:[String]) {
        super.init(frame: frame)
        titleArray = titles
        cellCount = titles.count * 100
        itemSize = frame.size
        layout.itemSize = frame.size

        let top = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        
        self.addSubview(collectionView)
        self.addConstraints([top,left,right,bottom])

    }
    
    
    /// NSLayout 布局推荐
    init(cellSize: CGSize, titles:[String]) {
        super.init(frame: CGRect.zero)
        titleArray = titles
        cellCount = titles.count * 100
        itemSize = cellSize
        layout.itemSize = cellSize
        
        let top = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        
        self.addSubview(collectionView)
        self.addConstraints([top,left,right,bottom])
        
        
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 从cell的indexPath 获取数据源对应的 index
    func indexWith(cellIndex: Int) -> Int {
        return cellIndex % titleArray.count
    }
    
    /// up:0-max, down:max-0,
    
    
    func automaticScroll() {
        if cellCount <= 0 {
            return
        }
        
        let index = self.currentIndex()
        
        if scrollStyle == .continuity { //持续滚动模式
            var offsetPoint = self.collectionView.contentOffset
            
            
            switch scrollDirection {
            case .up:
                if index >= cellCount - 1 {    //滚动到最底部，需要重置0
                    offsetPoint = CGPoint(x: 0, y: 0)
                    break
                }
                offsetPoint = CGPoint(x: collectionView.contentOffset.x, y: collectionView.contentOffset.y + itemSize.height)
            case .down:
                if index <= 0 {    //滚动到初始位置，需要重置到max
                    offsetPoint = CGPoint(x: 0, y: itemSize.height*CGFloat(cellCount-1))
                    break
                }
                offsetPoint = CGPoint(x: collectionView.contentOffset.x, y: collectionView.contentOffset.y - itemSize.height)
            case .left:
                if index >= cellCount - 1 {    //滚动到最右边，需要重置0
                    offsetPoint = CGPoint(x: 0, y: 0)
                    break
                }
                offsetPoint = CGPoint(x: collectionView.contentOffset.x + itemSize.width, y: collectionView.contentOffset.y)
            case .right:
                if index <= 0 {    //滚动到初始位置，需要重置到max
                    offsetPoint = CGPoint(x: itemSize.width*CGFloat(cellCount-1), y: 0)
                    break
                }
                offsetPoint = CGPoint(x: collectionView.contentOffset.x - itemSize.width, y: collectionView.contentOffset.y)
            }
            
            
            UIView.animate(withDuration: timeInterval-1, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                self.collectionView.setContentOffset(offsetPoint, animated: false)
            }, completion: nil)

            
            
            
            return
        }else { //间歇滚动模式
            
            switch scrollDirection {
            case .up:
                if index >= cellCount - 1 {    //滚动到最底部，需要重置0
                    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredVertically, animated: false)
                    break
                }
                self.scroll(toIndex: index+1)
            case .down:
                if index <= 0 {    //滚动到初始位置，需要重置到max
                    collectionView.scrollToItem(at: IndexPath(item: cellCount-1, section: 0), at: .centeredVertically, animated: false)
                    break
                }
                self.scroll(toIndex: index-1)
            case .left:
                if index >= cellCount - 1 {    //滚动到最右边，需要重置0
                    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
                    break
                }
                self.scroll(toIndex: index+1)
            case .right:
                if index <= 0 {    //滚动到初始位置，需要重置到max
                    collectionView.scrollToItem(at: IndexPath(item: cellCount-1, section: 0), at: .centeredHorizontally, animated: false)
                    break
                }
                self.scroll(toIndex: index-1)
            }
        }

        
    }
    
    
    
    func scroll(toIndex index:Int)  {
        
        if scrollStyle == .intermittent {
            
            switch scrollDirection {
            case .up, .down:
                collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: UICollectionView.ScrollPosition.centeredVertically, animated: true)
            case .left, .right:
                collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            }
        }else {
        }
    }
//    override func didMoveToSuperview() {
//        print(self.collectionView.bounds)
//    }
    func continuityScroll() {
        
//
//        print(self.collectionView.contentOffset)
//
        

        UIView.animate(withDuration: timeInterval, delay: 0, options: [.curveLinear], animations: {

//            let rect = CGRect(x: self.collectionView.contentOffset.x, y: self.collectionView.contentOffset.y + 32, w: self.itemSize.width, h: self.itemSize.height)
//
//
//            self.collectionView.scrollRectToVisible(rect, animated: false)


//            self.collectionView.scrollToItem(at: IndexPath(item: self.cellCount-1, section: 0), at: .centeredVertically, animated: false)

            self.collectionView.setContentOffset(CGPoint(x: self.collectionView.contentOffset.x, y: self.collectionView.contentOffset.y + self.itemSize.height), animated: false)

//
//            self.collectionView.contentOffset = CGPoint(x: self.collectionView.contentOffset.x, y: self.collectionView.contentOffset.y + 32)
        }) { (finish) in
            if finish {
                self.continuityScroll()
            }
        }
        

        
        
//        self.collectionView.setContentOffset(CGPoint(x: self.collectionView.contentOffset.x, y: self.collectionView.contentOffset.y + 32), animated: true)

//        let rect = CGRect(x: self.collectionView.contentOffset.x, y: self.collectionView.contentOffset.y + 32, w: itemSize.width, h: itemSize.height)
//
//
//        self.collectionView.scrollRectToVisible(rect, animated: false)
        

        
    }
    
    
    
    func currentIndex() -> Int {
//        if collectionView.bounds.width == 0 || collectionView.bounds.height == 0{
//            return 0
//        }
//
//        var index = 0
//
//        if layout.scrollDirection == .horizontal {
//            index = Int((collectionView.contentOffset.x + layout.itemSize.width * 0.5) / layout.itemSize.width)
//
//            print("current: \(index) = (\(collectionView.contentOffset.x) + \(layout.itemSize.width * 0.5) / \(layout.itemSize.width))")
//        }else {
//            index = Int((collectionView.contentOffset.y + layout.itemSize.height * 0.5) / layout.itemSize.height)
//            print("current: \(index) = (\(collectionView.contentOffset.y) + \(layout.itemSize.height * 0.5) / \(layout.itemSize.height))")
//        }
//
//        return max(0, index)
        
        let index = collectionView.indexPathForItem(at: collectionView.contentOffset) ?? IndexPath(item: 0, section: 0)
//        print("current: \(index.item) = (\(collectionView.contentOffset.y) + \(layout.itemSize.height * 0.5) / \(layout.itemSize.height))")

        return index.row
        
        
    }
    
    
    /// -1:invalidate, 0:stop, 1:resume(start)
    func setupTime(state: Int) {
        
        switch state {
        case -1:
            self.timer.invalidate()
        case 0:
            self.timer.fireDate = Date.distantFuture
        case 1:
            if self.timer.isValid {
//                RunLoop.current.add(timer, forMode: .common)
//                self.timer.fireDate = Date.distantPast   //timer 立即启动
            }else {
                let timer = Timer.init(timeInterval: timeInterval, repeats: true) { (newTimer) in
                    self.automaticScroll()
                }
//                timer.fireDate = Date.distantPast   //timer 立即启动
                RunLoop.current.add(timer, forMode: .common)
                self.timer = timer

            }

            self.timer.fireDate = Date.distantPast
       default:
            self.timer.invalidate()
        }
    }
    
    
    
    lazy var layout: UICollectionViewFlowLayout = {
        let lay = UICollectionViewFlowLayout()
        lay.minimumLineSpacing = 0
        lay.minimumInteritemSpacing = 0
        lay.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 32)
        lay.scrollDirection = UICollectionView.ScrollDirection.vertical
        return lay
    }()
    
    
    lazy var collectionView: UICollectionView = {
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.clear
//        collection.isScrollEnabled = false
        collection.isPagingEnabled = false
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ZCMarqueeCell.self, forCellWithReuseIdentifier: "ZCMarqueeCell_id")
//        collection.register(ZCMarqueeCell.self, forCellWithReuseIdentifier: "ZCMarqueeCell_0")
//        collection.register(ZCMarqueeCell.self, forCellWithReuseIdentifier: "ZCMarqueeCell_1")
//        collection.register(ZCMarqueeCell.self, forCellWithReuseIdentifier: "ZCMarqueeCell_2")
        return collection
    }()
    var titleArray: [String] = [] {
        willSet {
            //timer 停止，设置参数
            self.setupTime(state: 0)
            cellCount = newValue.count * 100
        }
        
        didSet {
            // timer 启动
            self.collectionView.reloadData()
            self.setupTime(state: 1)
        }
    }
    var font: UIFont = UIFont.systemFont(ofSize: 12)
    
    var textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    
    
    var cellCount: Int = 0
    
    var itemSize: CGSize = CGSize.zero
    
    var timer: Timer = Timer()
    
    /// 滚动时间间隔，或滚动速率(默认是自动轮播的)
    var timeInterval: TimeInterval = 3.0 {
        didSet {

            self.timer.invalidate()
            let timer = Timer.init(timeInterval: timeInterval, repeats: true) { (newTimer) in
                self.automaticScroll()
            }
            timer.fireDate = Date.distantPast   //timer 立即启动
            RunLoop.current.add(timer, forMode: .common)
            self.timer = timer

            
//            if scrollStyle == .continuity {
//                self.continuityScroll()
//            }else {
//                self.timer.invalidate()
//                let timer = Timer.init(timeInterval: oldValue, repeats: true) { (newTimer) in
//                    self.automaticScroll()
//                }
//                timer.fireDate = Date.distantPast   //timer 立即启动
//                RunLoop.current.add(timer, forMode: .common)
//                self.timer = timer
//            }
            
        }
    }
    
    var scrollStyle: ZCMarqueeView.ScrollStyle = ZCMarqueeView.ScrollStyle.intermittent {
        willSet {
            
        }
    }
    var scrollDirection: ZCMarqueeView.ScrollDirection = ZCMarqueeView.ScrollDirection.up {
        willSet {
            switch newValue {
            case .up,.down:
                layout.estimatedItemSize = CGSize.zero
                layout.itemSize = itemSize
                layout.scrollDirection = .vertical
//                collectionView.reloadData()
            case .left,.right:
                layout.estimatedItemSize = CGSize.zero
                layout.itemSize = itemSize
                layout.scrollDirection = .horizontal
//                collectionView.reloadData()
            }
            
        }
    }
    
    public enum ScrollDirection : Int {
        /// scroll left
        case left
        /// scroll right
        case right
        /// scroll up       default
        case up
        /// scroll down
        case down
    }

    public enum ScrollStyle : Int {
        /// 间歇性的        default
        case intermittent
        /// 持续性的 （未实现）
        case continuity
    }

}

extension ZCMarqueeView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
//        if scrollStyle == .continuity {
//            print(scrollView.contentOffset)
//        }
        
    }
    
    /// 用户拖动触发，代码设置滚动不触发
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("DidEndDecelerating \(scrollView.contentOffset)")
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        print("DidEndScrollingAnimation \(scrollView.contentOffset)")

    }
}

extension ZCMarqueeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        // 不复用cell
//        let identifier = "cellid_\(indexPath.row)"
//
//        collectionView.register(ZCMarqueeCell.self, forCellWithReuseIdentifier: identifier)
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ZCMarqueeCell
//
//        let pages = indexWith(cellIndex: indexPath.item)
//        cell.textLabel.text = titleArray[pages]
//        return cell

        
//        let cell: ZCMarqueeCell!
//
//        let pages = indexWith(cellIndex: indexPath.item)
//        switch pages {
//        case 0:
//            cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ZCMarqueeCell_0", for: indexPath) as! ZCMarqueeCell)
//        case 1:
//            cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ZCMarqueeCell_1", for: indexPath) as! ZCMarqueeCell)
//
//        case 2:
//            cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ZCMarqueeCell_2", for: indexPath) as! ZCMarqueeCell)
//
//        default:
//            cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ZCMarqueeCell_0", for: indexPath) as! ZCMarqueeCell)
//
//        }
//        cell.textLabel.text = titleArray[pages]
//        return cell

        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZCMarqueeCell_id", for: indexPath) as! ZCMarqueeCell
        let pages = indexWith(cellIndex: indexPath.item)
        cell.textLabel.text = titleArray[pages]
        cell.textLabel.font = font
        cell.textLabel.textColor = textColor
        return cell
    }
    
    
}



class ZCMarqueeCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        let width = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: frame.width)
        let height = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: frame.height)

        self.contentView.addConstraints([width,height])
        
        
//        let width = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: frame.width)
//        let height = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: frame.height)
//
//        self.contentView.addConstraint(height)

        
        let top = NSLayoutConstraint(item: textLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: textLabel, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: textLabel, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: textLabel, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        self.contentView.addSubview(textLabel)
        self.contentView.addConstraints([top,left,right,bottom])

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
//        attributes.size = self.systemLayoutSizeFitting(attributes.size, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.fittingSizeLevel)
//        
//        return attributes
//    }
    
    
    var textLabel: UILabel = UILabel()
    
}

