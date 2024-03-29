//
//  ZCCityPickerView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/3.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

@objc public protocol ZCCityPickerViewDelegate {
    @objc optional func addressPickerViewArea(province: String?, city: String?, area: String?)
//     @objc optional func addressPickerViewCity(province: String?, city: String?)
//     @objc optional func addressPickerViewProvince(province: String?)
}

enum ZCAddressPickerType: Int {
    /// 只显示省
    case province = 1
    /// 显示省份和城市
    case city = 2
    /// 显示省份和城市和区域
    case area = 3
}



public class ZCCityPickerView: UIView {
    
    public weak var dataDelegate: ZCCityPickerViewDelegate?
    //MARK: -外部参数
    /// pickerView的字体大小
    public var pickerLabelFont: UIFont?{
        willSet{
            pickerView.reloadAllComponents()
        }
    }
    /// pickerView的字体颜色
    public var pickerLabelTextCoclor: UIColor?{
        willSet{
            pickerView.reloadAllComponents()
        }
    }
    
    // 设置取消、确定按钮的字体大小
    public var titleToolBarFont: UIFont?{
        willSet{
            sureButton.titleLabel?.font = newValue
            cancleButton.titleLabel?.font = newValue
        }
    }
    // 设置取消按钮的颜色
    public var cancleButtonCoclor: UIColor?{
        willSet{
            cancleButton.setTitleColor(newValue, for: .normal)
        }
    }
    // 设置确定按钮的颜色
    public var sureButtonCoclor: UIColor?{
        willSet{
            sureButton.setTitleColor(newValue, for: .normal)
        }
    }
    //设置titleToolBar的背景颜色
    public var titleToolBarBackgroundColor: UIColor?{
        willSet{
            titleToolBar.backgroundColor = newValue
        }
    }
    
    //设置pickView的背景颜色
    public var pickerViewBackgroundColor: UIColor?{
        willSet{
            pickerView.backgroundColor = newValue
        }
    }
    //MARK: -内部参数
    // 接收参数的数据
    var dataSource = [Dictionary<String, Dictionary<String, Dictionary<String,[String]>>>]() // Array<Any>()
    // 一共显示多少列
    var columnCount: Int?
    // 省
    var provinceArray = [String]()
    // 市
    var cityArray = [String]()
    // 区
    var areaArray = [String]()
    // 默认选中省
    var selectedProvince: String?
    // 默认选中市
    var selectedCity: String?
    // 默认选中区
    var selectedArea: String?
    // 记录省份选中的位置
    var selectedProvinceIndex: Int = 0
    
    //设置选中的类型
    var showType: ZCAddressPickerType = .area {
        willSet{
            columnCount = newValue.rawValue
            pickerView.reloadAllComponents()
        }
    }
    // 回调函数
    // 区域block
    var selectedAreaBlock:((_ province:String, _ city:String, _ area:String)->())?
    // 省份block
    var selectedProvinceBlock:((_ province:String)->())?
    // 城市block
    var selectedCityBlock:((_ province:String, _ city:String)->())?
    
    //MARK: -懒加载
    /// 创建城市选择器
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y:
            FitWidth(50), width:SCREEN_WIDTH , height: FitWidth(220)))//270-55+IndicatorHomeHeight
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        return pickerView
    }()
    
    /// 创建容器
    lazy var containView: UIView = {
        let containView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT, width:SCREEN_WIDTH , height: FitWidth(270)+IndicatorHomeHeight))
        containView.backgroundColor = UIColor.white
        containView.addCorner(roundedRect: CGRect(x: 0, y: 0, width:SCREEN_WIDTH , height: FitWidth(270)+IndicatorHomeHeight), roundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue|UIRectCorner.topRight.rawValue), cornerRadii: CGSize(width: FitWidth(8), height: FitWidth(8)))
        return containView
    }()
    
    /// 创建容器中的titleToolBar
    lazy var titleToolBar: UIView = {
        let titleToolBar = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FitWidth(50)))
        titleToolBar.backgroundColor = UIColor.white
        let line = UIView(frame: CGRect(x: 0, y: FitWidth(50)-1, w: SCREEN_WIDTH, h: 1))
        line.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        titleToolBar.addSubview(line)
        return titleToolBar
    }()
    
    /// 创建确定按钮
    lazy var sureButton: UIButton = {
        let sureButton = UIButton(frame: CGRect(x: SCREEN_WIDTH - FitWidth(65), y: 0, width: FitWidth(65), height: FitWidth(50)))
        sureButton.setTitle("确定", for: .normal)
        sureButton.addTarget(self, action: #selector(addressButtonOnclik), for: .touchUpInside)
        sureButton.setTitleColor(GeneralRedColor, for: .normal)
        sureButton.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        sureButton.tag = 1
        return sureButton
    }()
    
    /// 创建取消按钮
    lazy var cancleButton: UIButton = {
        let cancleButton = UIButton(frame: CGRect(x: 0, y: 0, width: FitWidth(65), height: FitWidth(50)))
        //        let cancleButton = UIButton()
        cancleButton.setTitle("取消", for: .normal)
        cancleButton.setTitleColor(RGBA(153, 153, 153, 1), for: .normal)
        cancleButton.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        cancleButton.addTarget(self, action: #selector(addressButtonOnclik), for: .touchUpInside)
        return cancleButton
    }()
    
    //MARK: - 系统方法
    /// 系统初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 设置界面
        kl_setView()
        
        //设置数据
        //        kl_layoutSubviws()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -界面初始化
    /// 初始化界面
    func kl_setView(){
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        // 添加容器
        addSubview(containView)
        // 添加titleToolBar
        containView.addSubview(titleToolBar)
        // 添加pickerView
        containView.addSubview(pickerView)
        // 添加确定按钮
        titleToolBar.addSubview(sureButton)
        // 添加取消按钮
        titleToolBar.addSubview(cancleButton)
    }
    
    
    //MARK: -获取数据
    func kl_getData(){
        print(Bundle.main)
        //        let path = Bundle.main.path(forResource: "city", ofType: "plist")
        let path = Bundle(for: self.classForCoder).path(forResource: "Dingli_city", ofType: "plist")
        self.dataSource = NSArray(contentsOfFile: path!) as! [Dictionary<String, Dictionary<String, Dictionary<String,[String]>>>]
        //获取省份
        var tempProvinceArray = [String]()
        for tempArray in self.dataSource {
            for province in tempArray.keys {
                tempProvinceArray.append(province)
            }
        }
        // 设置省份
        provinceArray = tempProvinceArray
        
        // 设置市
        cityArray = getCityNameFromProvinceIndex(provinceIndex: 0)
        
        // 设置区
        self.areaArray = getAreanamesFromProvinceIndex(provinceIndex: 0, cityIndex: 0)
        
        // 如果没有传入默认值默认选中第一个
        if selectedProvince == nil {
            selectedProvince = provinceArray.first
        }
        
        if selectedCity == nil {
            selectedCity = cityArray.first
        }
        
        if selectedArea == nil {
            selectedArea = areaArray.first
        }
        
        
        //根据省市县赋值
        var currentProvinceIndex: Int = 0
        var currentCityIndex: Int = 0
        var currentAreaIndex: Int = 0
        
        for i in (0 ... provinceArray.count - 1) {
            let province = provinceArray[i]
            if province == selectedProvince {
                selectedProvinceIndex = i
                currentProvinceIndex = i
                //获取当前城市
                cityArray = getCityNameFromProvinceIndex(provinceIndex: currentProvinceIndex)
                for j in (0 ... cityArray.count - 1){
                    let city = cityArray[j]
                    
                    if city == selectedCity {
                        currentCityIndex = j;
                        areaArray = getAreanamesFromProvinceIndex(provinceIndex: currentProvinceIndex, cityIndex: currentCityIndex)
                        for k in (0 ... areaArray.count - 1){
                            let area = areaArray[k]
                            if area == selectedArea {
                                currentAreaIndex = k
                            }
                        }
                    }
                }
            }
        }
        
        //滚动到固定的行
        if showType == .province {
            pickerView.selectRow(currentProvinceIndex, inComponent: 0, animated: true)
        } else if showType == .city {
            pickerView.selectRow(currentProvinceIndex, inComponent: 0, animated: true)
            pickerView.selectRow(currentCityIndex, inComponent: 1, animated: true)
        } else if showType == .area {
            pickerView.selectRow(currentProvinceIndex, inComponent: 0, animated: true)
            pickerView.selectRow(currentCityIndex, inComponent: 1, animated: true)
            pickerView.selectRow(currentAreaIndex, inComponent: 2, animated: true)
        }
        
        // self.pickerView.reloadAllComponents()
    }
    //MARK: -自定义方法
    @objc func addressButtonOnclik(currentButton: UIButton){
        //隐藏界面
        hideView()
        if currentButton.tag == 1{
            if (selectedProvinceBlock != nil) {
                selectedProvinceBlock?(selectedProvince!)
            }
            if (selectedCityBlock != nil) {
                selectedCityBlock?(selectedProvince!,selectedCity!)
            }
            if (selectedAreaBlock != nil){
                selectedAreaBlock?(selectedProvince!,selectedCity!,selectedArea!)
            }
            if dataDelegate != nil {
                //
                //                dataDelegate?.addressPickerViewProvince!(province:selectedProvince , city:selectedCity, area: selectedArea)
                dataDelegate?.addressPickerViewArea?(province: selectedProvince, city: selectedCity, area: selectedArea)
                //                dataDelegate?.addressPickerViewProvince?(province:selectedProvince)
                //                dataDelegate?.addressPickerViewCity?(province: selectedProvince, city: selectedCity)
            }
        }
    }
    /// 获取市
    /// - Parameter provinceIndex: 省份的id
    /// - Returns: 返回某个省份对应的市
    func getCityNameFromProvinceIndex(provinceIndex: Int)->([String]){
        let tempCityArray = self.dataSource[provinceIndex][self.provinceArray[provinceIndex]]
        
        var tempArray = [String]()
        for cityDic in (tempCityArray?.values)! {
            for city in cityDic.keys {
                tempArray.append(city)
            }
        }
        print(tempArray)
        return tempArray
    }
    
    ///  获取区
    /// - Parameters:
    ///   - provinceIndex: 省份的id
    ///   - cityIndex: 市的id
    /// - Returns: 返回某个省份对应的市对应的区
    func getAreanamesFromProvinceIndex(provinceIndex: Int, cityIndex: Int)->[String]{
        let tempCityArray = self.dataSource[provinceIndex][self.provinceArray[provinceIndex]]!
        
        var areaArray = [[String:[String]]]()
        
        for areaDic in tempCityArray.values {
            areaArray.append(areaDic)
        }
        
        let tempareaDic = areaArray[cityIndex]
        
        let currentAreaArra = tempareaDic[self.cityArray[cityIndex]]
        
        return currentAreaArra ?? []
    }
    
    /// 显示view
    func showView() {
        UIApplication.shared.keyWindow?.addSubview(self)
        backgroundColor = UIColor.clear
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = RGBA(0, 0, 0, 0.3)
            self.containView.bottom = SCREEN_HEIGHT
        }
    }
    
    /// 隐藏View
    func hideView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = UIColor.clear
            self.containView.y =  SCREEN_HEIGHT
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
    
    //MARK: - 初始化
    /// 显示省份
    /// - Parameter addressBlock: 回调返回省份
    public func provincePickerViewWithProvinceBlock(addressBlock:((String)->())?){
        addressPickerViewWithProvince(province: nil, city: nil, area: nil, provinceBlock: addressBlock, cityBlock: nil, areaBlock: nil, showType: .province)
    }
    
    /// 显示省份
    /// - Parameters:
    ///   - province: 传入选中的省份
    ///   - addressBlock: 回调返回省份
    public func provincePickerViewWithProvince(province: String?, addressBlock:((String)->())?){
        addressPickerViewWithProvince(province: province, city: nil, area: nil, provinceBlock: addressBlock, cityBlock: nil, areaBlock: nil, showType: .province)
    }
    
    /// 显示省份和城市
    ///
    /// - Parameter addressBlock: 返回省份和城市
    public func cityPickerViewWithCityBlock(addressBlock:((String, String)->())?) {
        addressPickerViewWithProvince(province: nil, city: nil, area: nil, provinceBlock: nil, cityBlock: addressBlock, areaBlock: nil, showType: .city)
    }
    
    /// 显示省份城市
    ///
    /// - Parameters:
    ///   - procvince: 传入选中的省份
    ///   - city: 传入选中的城市
    ///   - addressBlock: 返回选中的省份和城市
    public func cityPickerViewWithProvince(procvince: String?, city: String?, addressBlock:((String, String)->())?){
        addressPickerViewWithProvince(province: procvince, city: city, area: nil, provinceBlock: nil, cityBlock: addressBlock, areaBlock: nil, showType: .city)
    }
    
    /// 显示省份市和区域
    /// - Parameter province: 回调省份市和区域
    public func areaPickerViewWithareaBlock(addressBlock:((String, String, String)->())?){
        addressPickerViewWithProvince(province: nil, city: nil, area: nil, provinceBlock: nil, cityBlock: nil, areaBlock: addressBlock, showType: .area)
    }
    
    /// 显示省份城市和区域
    ///
    /// - Parameters:
    ///   - province: 选中的省份
    ///   - city: 选中的城市
    ///   - area: 选中的区域
    ///   - addressBlock: 回调省市区域
    func areaPickerViewWithProvince(province: String?, city: String?, area: String?, addressBlock:((String, String, String)->())?){
        addressPickerViewWithProvince(province: province, city: city, area: area, provinceBlock: nil, cityBlock: nil, areaBlock: addressBlock, showType: .area)
    }
    
    //MARK: - 基本方法
    func addressPickerViewWithProvince(province: String?, city: String?, area: String?, provinceBlock:((String)->())?, cityBlock:((String, String)->())?, areaBlock:((String, String, String)->())?, showType: ZCAddressPickerType){
        selectedProvince = province
        selectedCity = city
        selectedArea = area
        selectedProvinceBlock = provinceBlock
        selectedCityBlock = cityBlock
        selectedAreaBlock = areaBlock
        self.showType = showType
        // 设置数据
        kl_getData()
        showView()
    }
}

//MARK: -UIPickerViewDataSource, UIPickerViewDelegate 方法
extension ZCCityPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.columnCount ?? 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.provinceArray.count
        } else if component == 1 {
            return self.cityArray.count
        }else if component == 2 {
            return self.areaArray.count
        }
        return 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = view as? UILabel
        if label == nil {
            label = UILabel(frame: CGRect(x: 0, y: 0, width: width/3, height: 30))
            label?.adjustsFontSizeToFitWidth = true
            label?.textAlignment = .center
            label?.textColor = pickerLabelTextCoclor == nil ? HexColor("0x666666"): pickerLabelTextCoclor
            label?.font = pickerLabelFont == nil ? UIFont.systemFont(ofSize: 17) : pickerLabelFont
        }
        
        if component == 0 {
            label?.text =  self.provinceArray[row]
        } else if component == 1 {
            label?.text =  self.cityArray[row]
        } else if component == 2 {
            label?.text =  self.areaArray[row]
        }
        return label!
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 { // 选择省份
            selectedProvinceIndex = row
            switch showType {
            case .province:
                selectedProvince = provinceArray[row]
                selectedCity = ""
                selectedArea = ""
            case .city:
                cityArray = getCityNameFromProvinceIndex(provinceIndex: row)
                pickerView.selectRow(0, inComponent: 1, animated: true)
                pickerView.reloadComponent(1)
                selectedProvince = provinceArray[row]
                selectedCity = cityArray[0]
                selectedArea = ""
            case .area:
                cityArray = getCityNameFromProvinceIndex(provinceIndex: row)
                areaArray = getAreanamesFromProvinceIndex(provinceIndex: row, cityIndex: 0)
                pickerView.reloadComponent(1)
                selectedProvince = provinceArray[row]
                pickerView.selectRow(0, inComponent: 1, animated: true)
                pickerView.reloadComponent(2)
                pickerView.selectRow(0, inComponent: 2, animated: true)
                selectedCity = cityArray[0]
                selectedArea = areaArray[0]
            }
            
        } else if component == 1 {
            switch showType {
            case .city:
                selectedCity = cityArray[row]
                selectedArea = ""
            case .area:
                areaArray = getAreanamesFromProvinceIndex(provinceIndex: selectedProvinceIndex, cityIndex: row)
                pickerView.reloadComponent(2)
                pickerView.selectRow(0, inComponent: 2, animated: true)
                
                selectedCity = cityArray[row]
                selectedArea = areaArray[0]
            case .province:
                break
            }
            
        }else if component == 2 {
            switch showType {
            case .province,.city:
                break
            case .area:
                selectedArea = areaArray[row]
            }
            
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
}

// MARK: - 代理方式传值
extension ZCCityPickerView {
    
    //初始化方法
    public func areaPickerViewProvince(delegate:ZCCityPickerViewDelegate){
        dataDelegate = delegate
        addressPickerViewWithProvince(province: nil, city: nil, area: nil, provinceBlock: nil, cityBlock: nil, areaBlock: nil, showType: .province)
    }
    
    public func areaPickerViewProvince(provine:String?, delegate:ZCCityPickerViewDelegate){
        dataDelegate = delegate
        addressPickerViewWithProvince(province: provine, city: nil, area: nil, provinceBlock: nil, cityBlock: nil, areaBlock: nil, showType: .province)
    }
    
    
    public func areaPickerViewCity(delegate:ZCCityPickerViewDelegate){
        dataDelegate = delegate
        addressPickerViewWithProvince(province: nil, city: nil, area: nil, provinceBlock: nil, cityBlock: nil, areaBlock: nil, showType: .city)
    }
    
    public func areaPickerViewCity(provine: String?, city: String?, delegate: ZCCityPickerViewDelegate){
        dataDelegate = delegate
        addressPickerViewWithProvince(province: provine, city: city, area: nil, provinceBlock: nil, cityBlock: nil, areaBlock: nil, showType: .city)
    }
    
    public func areaPickerViewArea(delegate:ZCCityPickerViewDelegate){
        dataDelegate = delegate
        addressPickerViewWithProvince(province: nil, city: nil, area: nil, provinceBlock: nil, cityBlock: nil, areaBlock: nil, showType: .area)
    }
    
    public func areaPickerViewArea(provine: String?, city: String?, area: String?, delegate:ZCCityPickerViewDelegate){
        dataDelegate = delegate
        addressPickerViewWithProvince(province: provine, city: city, area: area, provinceBlock: nil, cityBlock: nil, areaBlock: nil, showType: .area)
    }
}

