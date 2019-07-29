//
//  ZCCircleNavigationBar.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/27.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCCircleNavigationBar: ZCBaseView {

    var titles: [String]! {
        didSet {
            self.rootScrollView.contentSize = CGSize(width: SCREEN_WIDTH*CGFloat(titles.count), height: CGFloat(contentViewHeight))
        }
    }
    var viewControllers: [ZCBaseViewController]! {
        didSet {
            self.rootScrollView.contentSize = CGSize(width: SCREEN_WIDTH*CGFloat(viewControllers.count), height: CGFloat(contentViewHeight))
        }
    }
    var contentViewHeight: CGFloat = 0.0
    var parentViewController: ZCBaseViewController!
    var delegate: AnyObject?
    var lineEdgeInsets = UIEdgeInsets(top: 40, left: 4, bottom: 2, right: 4)
    
    
    var currentIndex = 0
    lazy var rootScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, w:SCREEN_WIDTH, h: SCREEN_HEIGHT))
        scrollView.backgroundColor = UIColor.white
        scrollView.isPagingEnabled = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 34
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, w: 0, h: 0), collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.register(ZCCircleNavigationBarCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZCCircleNavigationBarCell.self))
        view.backgroundColor = UIColor.white
        return view
    }()

    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = GeneralRedColor
        return view
    }()
    
    

    init(frame aFrame: CGRect, parent aParent: UIViewController) {
        super.init(frame: aFrame)
        contentViewHeight = SCREEN_HEIGHT - NavBarHeight - TabBarHeight
        collectionView.frame = CGRect(x: 0, y: 0, w: frame.width, h: frame.height)
        rootScrollView.frame = CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: contentViewHeight)
        lineView.frame = CGRect(x: lineEdgeInsets.left, y: lineEdgeInsets.top, w: 38-lineEdgeInsets.left-lineEdgeInsets.right, h: frame.height-lineEdgeInsets.top-lineEdgeInsets.bottom)
        parentViewController = aParent as? ZCBaseViewController
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.rootScrollView.delegate = self
        
        self.addSubview(self.collectionView)
        self.addSubview(self.lineView)
        self.parentViewController.view.addSubview(self.rootScrollView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /** 调用此方法来绘制界面,required*/
    func reloadPages() {
        assert(self.titles.count == self.viewControllers.count, "titles' count is not equal to controllerNames' count")

        self.collectionView.reloadData()
        self.addChildViewController()
    }
    
    /// 将子viewController添加到scrollView上
    func addChildViewController() {
        let viewController = viewControllers[currentIndex]
        let startX = self.rootScrollView.frame.width * CGFloat(currentIndex)
        if viewController.parent == nil {
            self.parentViewController.addChild(viewController)
            var rect = self.rootScrollView.bounds
            rect.x = startX
            viewController.view.frame = rect
            self.rootScrollView.addSubview(viewController.view)
            viewController.didMove(toParent: self.parentViewController)
        }
        
        self.rootScrollView.setContentOffset(CGPoint(x: startX, y: 0), animated: false)
        
        //TODO delegate
    }
    
    /// 手动设置cursor选中item
    ///
    /// - Parameter index: 选中的index
    func selectItemAtIndex(_ index: NSInteger)  {
        let indexPath = IndexPath(item: index, section: 0)
        self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
        
        var rect = cell?.frame
        if (cell == nil) {
            rect = self.collectionView.layoutAttributesForItem(at: indexPath)?.frame
        }
        self.resizeLineViewWihtCell(withFrame: rect ?? CGRect(x: 0, y: 0, w: 0, h: 0), animated: true)
        self.addChildViewController()
    }
    
    /// 手动设置bar取消选中item
    ///
    /// - Parameter index: 取消选中的index
    func deselectItemAtIndex(_ index: NSInteger) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.deselectItem(at: indexPath, animated: false)
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = false

    }
    
    
    /// 设置标识线的frame
    func resizeLineViewWihtCell(withFrame frame: CGRect, animated animate: Bool)  {
        let rect = CGRect(x: frame.x+lineEdgeInsets.left,
                          y: lineEdgeInsets.top,
                          w: frame.width-lineEdgeInsets.left-lineEdgeInsets.right,
                          h: self.bounds.height-lineEdgeInsets.top-lineEdgeInsets.bottom)
        if animate {
            UIView.animate(withDuration: 0.2) {
                self.lineView.frame = rect
            }
        }else {
            self.lineView.frame = rect
        }
        
    }
    
}

extension ZCCircleNavigationBar: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 38, height: 44)
    }
}


extension ZCCircleNavigationBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ZCCircleNavigationBarCell.self), for: indexPath) as! ZCCircleNavigationBarCell
        cell.button.setTitle(titles[indexPath.row], for: .normal)
        cell.button.setTitle(titles[indexPath.row], for: .selected)

        if currentIndex == indexPath.row { //默认选中
            self.selectItemAtIndex(currentIndex)
        }
        return cell
    }
    
    
}


extension ZCCircleNavigationBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == currentIndex {
            return
        }
        currentIndex = indexPath.row
        self.selectItemAtIndex(currentIndex)
    }
    
}


extension ZCCircleNavigationBar: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.rootScrollView.isEqual(scrollView) {
            let offsetX = scrollView.contentOffset.x
            if offsetX >= 0.0 {
                let index = NSInteger(offsetX / self.rootScrollView.bounds.width)
                if index != self.currentIndex {
                    self.currentIndex = index
                    self.selectItemAtIndex(self.currentIndex)
                }
            }
        }
    }
    
    
    
}

