//
//  UMTPublicInfoView.h
//  U咪兔
//
//  Created by 谭培 on 2017/4/4.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol publickInfoViewDelegate <NSObject>

- (void)sexItemClicked;
- (void)labelItemClicked;

@end

@interface UMTPublicInfoView : UIView

@property (nonatomic,copy) NSString *nikName;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *label;
@property (nonatomic,weak) id <publickInfoViewDelegate>delegate;

@end
