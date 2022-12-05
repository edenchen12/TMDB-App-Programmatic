//
//  Constants.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

enum Images {
    static let placeholder                  = UIImage(systemName: "mountain.2")
    static let cellPlaceholder              = UIImage(systemName: "mountain.2.circle.fill")
    static let emptyStateLogo               = UIImage(systemName: "mountain.2.fill")
}


enum ScreenSize {
    static let width                        = UIScreen.main.bounds.size.width
    static let height                       = UIScreen.main.bounds.size.height
    static let maxLength                    = max(ScreenSize.width, ScreenSize.height)
    static let minLength                    = min(ScreenSize.width, ScreenSize.height)
}


enum DeviceTypes {
    static let idiom                        = UIDevice.current.userInterfaceIdiom
    static let nativeScale                  = UIScreen.main.nativeScale
    static let scale                        = UIScreen.main.scale
    
    static let isiPhoneSE                   = idiom == .phone && ScreenSize.maxLength == 667.0
    static let isiPhone8Standard            = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed              = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard        = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed          = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                    = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr           = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPhone11AndProMax          = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPhone11ProAnd12Mini       = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhone11Pro                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhone12MiniAnd13Mini      = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhone12And12Pro           = idiom == .phone && ScreenSize.maxLength == 844.0
    static let isiPhone13And13ProAnd14      = idiom == .phone && ScreenSize.maxLength == 844.0
    static let isiPhone12Or13ProMaxOr14Plus = idiom == .phone && ScreenSize.maxLength == 926.0
    static let isiPhone14Pro                = idiom == .phone && ScreenSize.maxLength == 852.0
    static let isiPhone14ProMax             = idiom == .phone && ScreenSize.maxLength == 932.0
    
    static let isiPad                       = idiom == .pad && ScreenSize.maxLength >= 1024.0
    
    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}


