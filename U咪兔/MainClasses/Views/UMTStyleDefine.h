//
//  UMTStyleDefine.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/6.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#ifndef UMTStyleDefine_h
#define UMTStyleDefine_h

#define kFont(x) [UIFont systemFontOfSize:x]
#define Hex(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])
#define kCommonGreenColor Hex(0x48c277)
#define kCommonLightGreenColor Hex(0x57d980)
#define kCommonItemHeight 44
#define kCommonbackColor Hex(0xf4f4f4)
#define klightGray Hex(0xf3f3f3)
#define kLineColor Hex(0xdedfe0)
#define kGrayFontColor Hex(0x8f8e94)
#define kCommonGray_Color Hex(0xeaeaea)
#define kCircleOrangeColor Hex(0xFFB33A)

#define kTagRedColor [UIColor colorWithRGB:240 green:67 blue:109]
#define kTagGreenColor kCommonGreenColor
#define kTagOrangeColor [UIColor colorWithRGB:240 green:113 blue:58]
#define kTagBlueColor Hex(0x129fdb)
#define kTagPurpleColor Hex(0x862ea)

#define kStandardPx(Px) round(Px/1.92 * 10)/10          //把标注转化成实际宽高

#define kDefaultFont  kFont(17)

#define kTokenKey @"userToken"

#endif /* UMTStyleDefine_h */
