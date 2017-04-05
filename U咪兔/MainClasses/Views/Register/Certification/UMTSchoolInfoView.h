//
//  UMTSchoolInfoView.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/5.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol chooseSchoolDelegate <NSObject>

- (void)chooseSchool;

@end

@interface UMTSchoolInfoView : UIView

@property (nonatomic,copy) NSString *schoolName;
@property (nonatomic,weak)id<chooseSchoolDelegate>delegate;

@end
