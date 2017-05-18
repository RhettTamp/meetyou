//
//  UMTSimpleActivityView.h
//  U咪兔
//
//  Created by 谭培 on 2017/5/9.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMTSimpleActivityView : UIView

@property (nonatomic,strong) NSString *timeString;
@property (nonatomic,assign) NSInteger limitPerson;
@property (nonatomic,assign) NSInteger joinedPerson;
@property (nonatomic,strong) NSString *state;

@end
