//
//  UMTIssueActivityController.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/21.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTIssueDetailActivityController.h"
#import "UMTAddActivityNavBar.h"
#import "UMTAddActivityItem.h"
#import "UMTAlertView.h"
#import "UMTAddActivityTimeView.h"
#import "UMTSiteViewController.h"
#import "UIResponder+Extension.h"
#import "UMTTagChooseController.h"
#import "UMTDetailActivityCellModel.h"
#import "UMTIssurActivityRequest.h"

#define kItemHeight 44


@interface UMTIssueDetailActivityController ()<UMTAddActivityNavBarDelegate,UMTAddActivityTimeViewDelegate,UITextViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UMTAlertView *typeAlert;
@property (nonatomic,strong) UITextField *titleText;
@property (nonatomic,strong) UILabel *siteLabel;
@property (nonatomic,strong) UMTAddActivityTimeView *applyTimeView;
@property (nonatomic,strong) UMTAddActivityTimeView *activityTimeView;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,strong) UIView *pickerTopView;
@property (strong, nonatomic) UIControl *backgroundControl;  /**< 背景控制板 */
@property (nonatomic,strong) UIButton *currentChoiceTimeButton;
@property (nonatomic,strong) UITextField *personLimitText;
@property (nonatomic,strong) UILabel *tagLabel;
@property (nonatomic,strong) UITextView *contentText;
@property (nonatomic,strong) NSArray *tagsArray;

@end


@implementation UMTIssueDetailActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUi];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.backgroundControl removeFromSuperview];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initUi{
    [self addNavBar];
    [self addScrollView];
//    [self addTypeView];
    [self addContentItem];
    [self addApplyItem];
    [self initPickerView];
    [self addPersonLimitView];
    [self addTagItem];
    [self addContentView];
}

- (void)initPickerView
{
    self.pickerTopView = [[UIView alloc] init];
    self.pickerTopView.backgroundColor = kCommonGray_Color;
    [[UIApplication sharedApplication].keyWindow addSubview:self.pickerTopView];
    [self.pickerTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([UIApplication sharedApplication].keyWindow.mas_bottom);
        make.left.and.right.equalTo([UIApplication sharedApplication].keyWindow);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setTitleColor:kCommonGreenColor forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(timeCommitButtonCliked) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerTopView addSubview:finishButton];
    [finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pickerTopView).with.offset(-15);
        make.centerY.equalTo(self.pickerTopView);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, kItemHeight+5, UMTScreenWidth-10, 150)];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePicker = datePicker;
    datePicker.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.pickerTopView.mas_bottom);
        make.height.mas_equalTo(160);
    }];
    
    self.backgroundControl = [[UIControl alloc] init];
    self.backgroundControl.backgroundColor = kLineColor;
    [self.backgroundControl addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundControl.alpha = 0.0f;
    [[UIApplication sharedApplication].keyWindow addSubview:self.backgroundControl];
    [self.backgroundControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo([UIApplication sharedApplication].keyWindow);
        make.bottom.equalTo(self.pickerTopView.mas_top);
    }];
    
}

- (void)addNavBar{
    UMTAddActivityNavBar *bar = [[UMTAddActivityNavBar alloc]initWithFrame:CGRectMake(0, 20, UMTScreenWidth, 44)];
    [self.view addSubview:bar];
    bar.delegate = self;
}

- (void)addScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, UMTScreenWidth, UMTScreenHeight-64)];
    scrollView.contentSize = CGSizeMake(UMTScreenWidth,kItemHeight*8+152+200+20);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIControl *control = [[UIControl alloc]initWithFrame:self.view.bounds];
    [control addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:control];
}

//- (void)addTypeView{
//    UMTAddActivityItem *typeItem = [[UMTAddActivityItem alloc]initWithFrame:CGRectMake(5, 20, UMTScreenWidth-10, kItemHeight)];
//    typeItem.numberofItems = 1;
//    typeItem.itemNames = @[@"类型"];
//    [self.scrollView addSubview:typeItem];
//    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(UMTScreenWidth-10-120, 0, 120, kItemHeight)];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(typeChoice)];
//    [rightView addGestureRecognizer:tap];
//    [typeItem addSubview:rightView];
//    
//    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Disclosure_Indicator"]];
//    imgView.frame = CGRectMake(120-26, 0, 18, 18);
//    imgView.centerY = rightView.centerY;
//    [rightView addSubview:imgView];
//    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 80, kItemHeight)];
//    label.text = @"精心计划";
//    [rightView addSubview:label];
//    self.typeLabel = label;
//    
//    
//    UMTAlertView *alert = [[UMTAlertView alloc]initWithFuncArray:@[@"精心计划",@"说走就走"]];
//    alert.delegate = self;
//    self.typeAlert = alert;
//    
//}

- (void)addContentItem{
    UMTAddActivityItem *contentItem = [[UMTAddActivityItem alloc]initWithFrame:CGRectMake(10, 20, UMTScreenWidth-20, kItemHeight*2)];
    contentItem.numberofItems = 2;
    contentItem.itemNames = @[@"标题",@"地点"];
    [self.scrollView addSubview:contentItem];
    
    UITextField *title = [[UITextField alloc]initWithFrame:CGRectMake(115, 0, 150, kItemHeight)];
    title.placeholder = @"请输入活动标题";
    [contentItem addSubview:title];
    self.titleText = title;
    
    UIView *siteView = [[UIView alloc]initWithFrame:CGRectMake(UMTScreenWidth-20-150, kItemHeight, 150, kItemHeight)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choiceSite)];
    [siteView addGestureRecognizer:tap];
    [contentItem addSubview:siteView];
    UILabel *siteLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, kItemHeight)];
    siteLabel.text = @"请选择地点";
    siteLabel.textColor = [UIColor colorWithRGB:143 green:142 blue:148];
    [siteView addSubview:siteLabel];
    [siteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-26);
        make.centerY.equalTo(siteView);
    }];
    self.siteLabel = siteLabel;
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"Disclosure_Indicator"] forState:UIControlStateNormal];
    [siteView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
        make.centerY.equalTo(siteView);
    }];
}

- (void)choiceSite{
    UMTSiteViewController *siteVC = [[UMTSiteViewController alloc]init];
    siteVC.block = ^void (NSString *site) {
        self.siteLabel.text = site;
    };
    [self.navigationController pushViewController:siteVC animated:YES];
}

- (void)addApplyItem{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(26, kItemHeight*2+20+20, 100, 18)];
    label.text = @"报名起止时间";
    label.font = kFont(13);
    label.textColor = [UIColor colorWithRGB:109 green:109 blue:114];
    [self.scrollView addSubview:label];
    
    UMTAddActivityTimeView *timeView = [[UMTAddActivityTimeView alloc]initWithFrame:CGRectMake(10, kItemHeight*2+40+18+8, UMTScreenWidth-20, kItemHeight*2)];
    timeView.delegate = self;
    [self.scrollView addSubview:timeView];
    self.applyTimeView = timeView;
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, kItemHeight*4+66+20, 100, 18)];
    label2.text = @"活动起止时间";
    label2.font = kFont(13);
    label2.textColor = [UIColor colorWithRGB:109 green:109 blue:114];
    [self.scrollView addSubview:label2];
    
    UMTAddActivityTimeView *actTimeView = [[UMTAddActivityTimeView alloc]initWithFrame:CGRectMake(10, kItemHeight*4+112, UMTScreenWidth-20, kItemHeight*2)];
    actTimeView.delegate = self;
    [self.scrollView addSubview:actTimeView];
    self.activityTimeView = actTimeView;
}

- (void)addPersonLimitView{
    UMTAddActivityItem *item = [[UMTAddActivityItem alloc]initWithFrame:CGRectMake(10, kItemHeight*6+112+20, UMTScreenWidth-20, kItemHeight)];
    item.numberofItems = 1;
    item.itemNames = @[@"最多人数"];
    [self.scrollView addSubview:item];
    
    UITextField *title = [[UITextField alloc]initWithFrame:CGRectMake(UMTScreenWidth-180, 0, 150, kItemHeight)];
    title.placeholder = @"选填";
    [title setKeyboardType:UIKeyboardTypePhonePad];
    [item addSubview:title];
    self.personLimitText = title;
}

- (void)addTagItem{
    UMTAddActivityItem *tagItem = [[UMTAddActivityItem alloc]initWithFrame:CGRectMake(10, kItemHeight*7+132+20, UMTScreenWidth-20, kItemHeight)];
    tagItem.numberofItems = 1;
    tagItem.itemNames = @[@"标签"];
    [self.scrollView addSubview:tagItem];
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(UMTScreenWidth-20-180, 0, 180, kItemHeight)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTag)];
    [rightView addGestureRecognizer:tap];
    [tagItem addSubview:rightView];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Disclosure_Indicator"]];
    [rightView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-8);
        make.centerY.equalTo(rightView);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
    }];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, kItemHeight)];
    label.text = @"至少选择一个标签";
    label.font = kFont(17);
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = [UIColor colorWithRGB:143 green:142 blue:148];
    [rightView addSubview:label];
    self.tagLabel = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-26);
        make.centerY.equalTo(rightView);
        make.left.equalTo(rightView.mas_left);
    }];
}

- (void)addContentView{
    UITextView *contentText = [[UITextView alloc]initWithFrame:CGRectMake(10, kItemHeight*8+152+20, UMTScreenWidth-20, 180)];
    contentText.delegate = self;
    contentText.text = @"请输入活动号召文字";
    contentText.textColor = [UIColor colorWithRGB:143 green:142 blue:148];
    contentText.font = kFont(17);
    contentText.scrollEnabled = NO;
    [self.scrollView addSubview:contentText];
    self.contentText = contentText;
}


- (void)chooseTag{
    UMTTagChooseController *tagVC = [[UMTTagChooseController alloc]init];
    tagVC.block = ^(NSArray *tags) {
        NSString *tagStr = tags[0];
        self.tagsArray = tags;
        for (int i = 1; i < tags.count; i++) {
            tagStr = [tagStr stringByAppendingString:[NSString stringWithFormat:@"、%@",tags[i]]];
        }
        self.tagLabel.text = tagStr;
    };
    [self.navigationController pushViewController:tagVC animated:YES];
}


#pragma mark -- UMTAddActivityTimeViewDelegate

- (void)clickedStartTime:(UIButton *)button{
    [self.view endEditing:YES];
    self.currentChoiceTimeButton = button;
    if (button.selected) {
        [self showPickerView];
    }else{
        [self hidePickerView];
    }
}

- (void)clickedEndTime:(UIButton *)button{
    self.currentChoiceTimeButton = button;
    if (button.selected) {
        [self showPickerView];
    }else{
        [self hidePickerView];
    }
}

//- (void)showDatePicker{
//    self.timeView.height += 160;
//    self.scrollView.height += 160;
//    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, kItemHeight+5, UMTScreenWidth-10, 150)];
//    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
//    [self.timeView addSubview:datePicker];
////    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.and.right.equalTo(self);
////        make.top.equalTo(self.timeView.lineView.mas_bottom).offset(5);
////        make.height.mas_equalTo(150);
////    }];
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kItemHeight+160, UMTScreenWidth-10, 1)];
//    lineView.backgroundColor = kLineColor;
//    [self.timeView addSubview:lineView];
////    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.and.right.equalTo(self);
////        make.top.equalTo(datePicker.mas_bottom).offset(5);
////        make.height.mas_equalTo(5);
////    }];
//    
//    self.timeView.endLabel.frame = CGRectMake(8, kItemHeight+160, 40, kItemHeight);
////    [self.timeView.endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.mas_offset(8);
////        make.top.equalTo(lineView.mas_bottom);
////        make.height.mas_equalTo(kItemHeight);
////    }];
//    CGFloat endTimeButtonWidth = CGRectGetWidth(self.timeView.endTimeButton.frame);
//    self.timeView.endTimeButton.frame = CGRectMake(UMTScreenWidth-10-8-endTimeButtonWidth, kItemHeight+160, endTimeButtonWidth, kItemHeight);
////    [self.timeView.endTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.right.mas_offset(-8);
////        make.top.equalTo(lineView.mas_top);
////        make.height.mas_equalTo(kItemHeight);
////    }];
////    [self.timeView layoutIfNeeded];
//}

//- (void)hideDatePicker{
//    
//}

#pragma mark--UITextViewDelegat
- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
}


//#pragma mark -- alertDelegat
//- (void)alertView:(UMTAlertView *)alertView didClickAtIndex:(NSInteger)index{
//    if (index == 0) {
//        self.typeLabel.text = @"精心计划";
//
//    }else if(index == 1){
//        self.typeLabel.text = @"说走就走";
//    }
//    [alertView hide];
//}

#pragma mark--UMTAddActivityNavBarDelegate

- (void)exitButtonClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonClicked{
    [self.view endEditing:YES];
    if (!self.titleText.text||self.titleText.text.length == 0) {
        [[UMTProgressHUD sharedHUD]showWithText:@"请输入标题" inView:self.view hideAfterDelay:.5];
        return;
    }
//    if (!self.siteLabel.text||[self.siteLabel.text isEqualToString:@"请选择地点"]) {
//        [[UMTProgressHUD sharedHUD]showWithText:@"请选择地点" inView:self.view hideAfterDelay:.5];
//        return;
//    }
//    if (!self.personLimitText.text||self.personLimitText.text.length == 0) {
//        [[UMTProgressHUD sharedHUD]showWithText:@"请选择地点" inView:self.view hideAfterDelay:.5];
//        return;
//    }
    UMTDetailActivityCellModel *model = [[UMTDetailActivityCellModel alloc]init];
    model.title = self.titleText.text;
    model.site = self.siteLabel.text;
    model.startTime = self.activityTimeView.startTime;
    model.endTime = self.activityTimeView.endTime;
    model.applyStartTime = self.applyTimeView.startTime;
    model.applyEndTime = self.applyTimeView.endTime;
    model.type = 1;
    model.site = self.siteLabel.text;
    model.tags = self.tagsArray;
//    NSString *personLimit = self.personLimitText.text;
//    if (!personLimit||personLimit.length == 0) {
//        model.peopleLimit = nil;
//    }
    model.peopleLimit = (int)[self.personLimitText.text integerValue];
    model.content = self.contentText.text;
    NSDictionary *params = [model yy_modelToJSONObject];
    [[UMTProgressHUD sharedHUD] rotateWithText:@"发布中" inView:self.view];
    [UMTIssurActivityRequest IssueActivityWithParams:params AndCompletionBlock:^(NSError *erro, id response) {
        [[UMTProgressHUD sharedHUD] hideAfterDelay:0];
        if (erro) {
            NSLog(@"%@",erro);
            [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",erro] inView:self.view hideAfterDelay:.5];
        }else{
            if ([response[@"status_code"] isEqualToString:@"2000"]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",response[@"info"]] inView:self.view hideAfterDelay:.5];
            }
            
        }
    }];
}

- (void)backClicked{
    [self.view endEditing:YES];
}

- (void)hidePickerView
{
    [UIView animateWithDuration:0.2f animations:^{
        [self.pickerTopView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo([UIApplication sharedApplication].keyWindow.mas_bottom);
        }];
        
        [self.pickerTopView.superview layoutIfNeeded];
        self.backgroundControl.alpha = 0.0f;
    }];
    self.currentChoiceTimeButton.selected = NO;
}

- (void)showPickerView
{
    
    [UIView animateWithDuration:0.2f animations:^{
        [self.pickerTopView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo([UIApplication sharedApplication].keyWindow.mas_bottom).with.offset(-200);
        }];
        self.backgroundControl.alpha = 0.6f;
        [self.pickerTopView.superview layoutIfNeeded];
    }];
}

- (void) timeCommitButtonCliked{
    [self hidePickerView];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy/MM/dd,HH:mm";
    NSDate *date = self.datePicker.date;
    NSString *dateStr = [formatter stringFromDate:date];
    [self.currentChoiceTimeButton setTitle:dateStr forState:UIControlStateNormal];
}



#pragma mark - keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardFrameAfterShow = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrameAfterShow.size.height;
    UIView *view = [UIResponder currentFirstResponder];
    CGFloat height = view.bottom-self.scrollView.contentOffset.y;
    UIView *aview = view.superview;
    height += aview.top;
    while ((aview = aview.superview)) {
        height += aview.top;
    }
    
    CGFloat keyboardTop = UMTScreenHeight-keyboardHeight;
    [UIView animateWithDuration:0.2f animations:^{
        if (height > keyboardTop) {
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y+height-keyboardTop);
        }
    }];
    
}


- (void)keyboardWillHide:(NSNotification *)notification
{
    
}

@end
