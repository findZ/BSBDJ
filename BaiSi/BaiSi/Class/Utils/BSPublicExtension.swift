//
//  BSPublicExtension.swift
//  BaiSi
//
//  Created by wzh on 2019/4/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import Foundation



//屏幕尺寸
let Screen_height : CGFloat = UIScreen.main.bounds.height
let Screen_width : CGFloat = UIScreen.main.bounds.width
let Screen_bounds = UIScreen.main.bounds

//主题色
let ThemeColor = UIColor.withRGB(255, 47, 86)


//iPhone X
let iPhoneX = Screen_height >= 812.0 ? true : false
//状态栏高度
let STATUS_BAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height
//导航栏高度
let NAVIGATION_BAR_HEIGHT = CGFloat(iPhoneX ? 88.0 : 64.0)
// tabBar高度
let TAB_BAR_HEIGHT = CGFloat(iPhoneX ? (49.0 + 34.0) : 49.0)
// home indicator
let HOME_INDICATOR_HEIGHT  = CGFloat(iPhoneX ? 34.0 : 0.0)

//主窗口
let KKeyWindow = UIApplication.shared.keyWindow

func DLog<N>(message:N,fileName:String = #file,methodName:String = #function,lineNumber:Int = #line){
    #if DEBUG
    let dformatter = DateFormatter()
    dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = dformatter.string(from: Date.init())
    let file = (fileName as NSString).lastPathComponent
    print("\(date) \(file) \(methodName) line[\(lineNumber)]：\(message)");
    
    #endif
}

/// 获取颜色的方法
extension UIColor {
    
    /**
     获取颜色，通过16进制色值字符串，e.g. #ff0000， ff0000
     - parameter hexString  : 16进制字符串
     - parameter alpha      : 透明度，默认为1，不透明
     - returns: RGB
     */
    static func withHex(hexString hex: String, alpha:CGFloat = 1) -> UIColor {
        // 去除空格等
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        // 去除#
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        // 必须为6位
        if (cString.count != 6) {
            return UIColor.gray
        }
        // 红色的色值
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        // 字符串转换
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    /**
     获取颜色，通过16进制数值
     - parameter hexInt : 16进制数值
     - parameter alpha  : 透明度
     - returns : 颜色
     */
    static func withHex(hexInt hex:Int32, alpha:CGFloat = 1) -> UIColor {
        let r = CGFloat((hex & 0xff0000) >> 16) / 255
        let g = CGFloat((hex & 0xff00) >> 8) / 255
        let b = CGFloat(hex & 0xff) / 255
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    /**
     获取颜色，通过rgb
     - parameter red    : 红色
     - parameter green  : 绿色
     - parameter blue   : 蓝色
     - returns : 颜色
     */
    static func withRGB(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat) -> UIColor {
        return UIColor.withRGBA(red, green, blue, 1)
    }
    
    static func randomColor() -> UIColor {
        return UIColor.withRGBA(CGFloat(arc4random()%255), CGFloat(arc4random()%255), CGFloat(arc4random()%255), 1)
    }
    
    /**
     获取颜色，通过rgb
     - parameter red    : 红色
     - parameter green  : 绿色
     - parameter blue   : 蓝色
     - parameter alpha  : 透明度
     - returns : 颜色
     */
    static func withRGBA(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat, _ alpha:CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
}
//MARK: - UIDevice延展
public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch (5 Gen)"
        case "iPod7,1":   return "iPod Touch 6"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":   return "iPhone 5"
        case  "iPhone5,2":  return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3":  return "iPhone 5c (GSM)"
        case "iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1":  return "iPhone 5s (GSM)"
        case "iPhone6,2":  return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1":   return "国行、日版、港行iPhone 7"
        case "iPhone9,2":  return "港行、国行iPhone 7 Plus"
        case "iPhone9,3":  return "美版、台版iPhone 7"
        case "iPhone9,4":  return "美版、台版iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":   return "iPhone 8"
        case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":   return "iPhone X"
            
        case "iPad1,1":   return "iPad"
        case "iPad1,2":   return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":   return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":   return "Apple TV 4"
        case "i386", "x86_64":   return "Simulator"
        default:  return identifier
        }
    }
}

extension String {
    
    var unicodeStr:String {
        let tempStr1 = self.replacingOccurrences(of:"\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of:"\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        let tempData = tempStr3.data(using: .utf8)
        var returnStr:String = ""
        do {
            
            returnStr = try PropertyListSerialization.propertyList(from: tempData!, options:[], format: nil) as! String
        } catch {
            print(error)
        }
        return returnStr.replacingOccurrences(of:"\\r\\n", with: "\n")
    }
}

extension UIBarButtonItem {
    
    static  func rightItem(normalTitle: String ,disabledTitle: String, target: Any?, action: Selector?) -> UIBarButtonItem {
        let button = UIButton.init()
        button.setTitle(normalTitle, for: .normal)
        button.setTitle(disabledTitle, for: .disabled)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightText, for: .highlighted)
        button.setTitleColor(UIColor.gray, for: .disabled)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.sizeToFit()
        button.addTarget(target, action: action!, for: .touchUpInside)
        return UIBarButtonItem.init(customView: button)
    }
    
    static func leftItem(normalImageName: String, highlightedImageName: String, target: Any?, action: Selector?) -> UIBarButtonItem{
        let button = UIButton.init()
        button.setImage(UIImage.init(named: normalImageName), for: .normal)
        button.setImage(UIImage.init(named: highlightedImageName), for: .highlighted)
        button.contentMode = .left
        button.bounds.size = (UIImage.init(named: normalImageName)?.size)!
        button.addTarget(target, action: action!, for: .touchUpInside)
        return UIBarButtonItem.init(customView: button)
    }
}

extension UIView {
    
    func height(height: CGFloat) -> Void {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: height)
    }
    
    func width(width: CGFloat) -> Void {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: self.frame.size.height)
    }
    
    func height() -> CGFloat {
        return self.frame.size.height
    }
    func width() -> CGFloat {
        return self.frame.size.width
    }
    
    /// 圆角
    ///
    /// - Parameter radius: 半径
    func circularBeadWithRadius(radius: CGFloat)  {
        
        let path = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: radius)
        let layer = CAShapeLayer.init()
        layer.frame = self.bounds
        layer.path = path.cgPath
        self.layer.mask = layer
    }
    
}

extension CGFloat {
    
    static func heightAdapter(height: CGFloat) -> CGFloat {
        let newHeight = height/667 * Screen_height
        
        return CGFloat(newHeight)
    }
    
    static func widthAdapter(width: CGFloat) -> CGFloat {
        let newWidth = width/375 * Screen_width
        
        return CGFloat(newWidth)
    }
}

extension UIFont {
    
   /// 苹方-简 细体
   static func pingFangSCLight(size: CGFloat) -> UIFont {
        if let font = UIFont.init(name:"PingFangSC-Light", size: size) {
            return font
        }else{
            return UIFont.systemFont(ofSize: size)
        }
    }
    /// 苹方-简 常规体
    static func pingFangSCRegular(size: CGFloat) -> UIFont {
        if let font = UIFont.init(name:"PingFangSC-Regular", size: size) {
            return font
        }else{
            return UIFont.systemFont(ofSize: size)
        }
    }
}
