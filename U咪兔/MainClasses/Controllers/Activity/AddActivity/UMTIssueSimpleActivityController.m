//
//  UMTIssueSimpleActivityController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/7.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTIssueSimpleActivityController.h"
#import "UMTAddActivityNavBar.h"
#import "UMTAddActivityItem.h"
#import "UMTSiteViewController.h"
#import "UMTTagChooseController.h"
#import "UIResponder+Extension.h"

#define kItemHeight 40

@interface UMTIssueSimpleActivityController ()<UMTAddActivityNavBarDelegate,UITextViewDelegate>

@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic,strong) UIView *pickerTopView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *currentChoiceTimeButton;
@property (nonatomic,strong) UIControl *backgroundControl;
@property (nonatomic,strong) UILabel *tagLabel;
@property (nonatomic,strong) UITextField *titleText;
@property (nonatomic,strong) UITextField *personLimitText;
@property (nonatomic,strong) UILabel *siteLabel;

@end

@implementation UMTIssueSimpleActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self initUi];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)initUi{
    [self addNavBar];
    [self addScrollView];
    //    [self addTypeView];
    [self addContentItem];
    [self initPickerView];
    [self addTimeLimitView];
    [self addPersonLimitView];
    [self addTagItem];
    [self addContentView];
}

- (void)initPickerView
{
    UIView *pickerTopView = [[UIView alloc] init];
    pickerTopView.backgroundColor = kCommonGray_Color;
    [[UIApplication sharedApplication].keyWindow addSubview:pickerTopView];
    [pickerTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([UIApplication sharedApplication].keyWindow.mas_bottom);
        make.left.and.right.equalTo([UIApplication sharedApplication].keyWindow);
        make.height.mas_equalTo(40);
    }];
    self.pickerTopView = pickerTopView;
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setTitleColor:kCommonGreenColor forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(timeCommitButtonCliked) forControlEvents:UIControlEventTouchUpInside];
    [pickerTopView addSubview:finishButton];
    [finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(pickerTopView).with.offset(-15);
        make.centerY.equalTo(pickerTopView);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, kItemHeight+5, UMTScreenWidth-10, 150)];
    datePicker.datePickerMode = UIDatePickerModeTime;
    self.datePicker = datePicker;
    datePicker.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(pickerTopView.mas_bottom);
        make.height.mas_equalTo(160);
    }];
    
    UIControl *backgroundControl = [[UIControl alloc] init];
    backgroundControl.backgroundColor = kLineColor;
    [backgroundControl addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    backgroundControl.alpha = 0.0f;
    [[UIApplication sharedApplication].keyWindow addSubview:backgroundControl];
    [backgroundControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo([UIApplication sharedApplication].keyWindow);
        make.bottom.equalTo(pickerTopView.mas_top);
    }];
    
}

- (void)addNavBar{
    UMTAddActivityNavBar *bar = [[UMTAddActivityNavBar alloc]initWithFrame:CGRectMake(0, 20, UMTScreenWidth, 44)];
    [self.view addSubview:bar];
    bar.delegate = self;
}

- (void)addScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, UMTScreenWidth, UMTScreenHeight-64)];
    scrollView.contentSize = CGSizeMake(UMTScreenWidth,kItemHeight*5+120);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIControl *control = [[UIControl alloc]initWithFrame:self.view.bounds];
    [control addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:control];
}

- (void)addContentItem{
    UMTAddActivityItem *contentItem = [[UMTAddActivityItem alloc]initWithFrame:CGRectMake(5, 20, UMTScreenWidth-10, kItemHeight*2)];
    contentItem.numberofItems = 2;
    contentItem.itemNames = @[@"标题",@"地点"];
    [self.scrollView addSubview:contentItem];
    
    UITextField *title = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, 150, kItemHeight)];
    title.placeholder = @"请输入活动标题";
    [contentItem addSubview:title];
    self.titleText = title;
    
    UILabel *siteLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, kItemHeight, 180, kItemHeight)];
    siteLabel.text = @"请选择地点";
    [contentItem addSubview:siteLabel];
    self.siteLabel = siteLabel;
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(UMTScreenWidth-10-40, kItemHeight, 30, kItemHeight)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"Disclosure_Indicator"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(choiceSite) forControlEvents:UIControlEventTouchUpInside];
    [contentItem addSubview:rightButton];
}

- (void)choiceSite{
    UMTSiteViewController *siteVC = [[UMTSiteViewController alloc]init];
    [self.navigationController pushViewController:siteVC animated:YES];
}

- (void)addTimeLimitView{
    UMTAddActivityItem *item = [[UMTAddActivityItem alloc]initWithFrame:CGRectMake(5, kItemHeight*2+40, UMTScreenWidth-10, kItemHeight)];
    item.numberofItems = 1;
    item.itemNames = @[@"愿意等待时机"];
    [self.scrollView addSubview:item];
    
    UIButton *timeButton = [[UIButton alloc]initWithFrame:CGRectMake(UMTScreenWidth-10-80, 0, 80, kItemHeight)];
    [timeButton setTitle:@"10:00:00" forState:UIControlStateNormal];
    [timeButton setTintColor:kCommonGreenColor];
    [timeButton addTarget:self action:@selector(choseTime) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addPersonLimitView{
    UMTAddActivityItem *item = [[UMTAddActivityItem alloc]initWithFrame:CGRectMake(5, kItemHeight*3+60, UMTScreenWidth-10, kItemHeight)];
    item.numberofItems = 1;
    item.itemNames = @[@"最多人数"];
    [self.scrollView addSubview:item];
    
    UITextField *title = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, 150, kItemHeight)];
    title.placeholder = @"选填";
    [item addSubview:title];
    self.personLimitText = title;
}

- (void)addTagItem{
    UMTAddActivityItem *tagItem = [[UMTAddActivityItem alloc]initWithFrame:CGRectMake(5, kItemHeight*4+80, UMTScreenWidth-10, kItemHeight)];
    tagItem.numberofItems = 1;
    tagItem.itemNames = @[@"标签"];
    [self.scrollView addSubview:tagItem];
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(UMTScreenWidth-10-180, 0, 180, kItemHeight)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTag)];
    [rightView addGestureRecognizer:tap];
    [tagItem addSubview:rightView];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Disclosure_Indicator"]];
    imgView.frame = CGRectMake(180-26, 0, 18, 18);
    imgView.centerY = rightView.centerY;
    [rightView addSubview:imgView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, kItemHeight)];
    label.text = @"至少选择一个标签";
    [rightView addSubview:label];
    self.tagLabel = label;
    
}

- (void)addContentView{
    UITextView *contentText = [[UITextView alloc]initWithFrame:CGRectMake(5, kItemHeight*5+100, UMTScreenWidth-10, 200)];
    contentText.delegate = self;
    contentText.text = @"请输入活动号召文字";
    contentText.scrollEnabled = NO;
    [self.scrollView addSubview:contentText];
}

- (void)choseTime{
    [self showPickerView];
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
    formatter.dateFormat = @"yyyy/MM/dd,HH:ss";
    NSDate *date = self.datePicker.date;
    NSString *dateStr = [formatter stringFromDate:date];
    [self.currentChoiceTimeButton setTitle:dateStr forState:UIControlStateNormal];
}

- (void)chooseTag{
    UMTTagChooseController *tagVC = [[UMTTagChooseController alloc]init];
    [self.navigationController pushViewController:tagVC animated:YES];
}

#pragma mark--UMTAddActivityNavBarDelegate

- (void)exitButtonClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonClicked{
    
}

#pragma mark--UITextViewDelegat
- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.text = @"";
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
    
    CGFloat keyboardTop = UMTScreenHeight -64 -keyboardHeight;
    [UIView animateWithDuration:0.2f animations:^{
        if (height > keyboardTop) {
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y+height-keyboardTop);
        }
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
}

- (void)backClicked{
    [self.view endEditing:YES];
}

@end
