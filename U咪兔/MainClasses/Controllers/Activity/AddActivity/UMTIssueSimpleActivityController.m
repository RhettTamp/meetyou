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
#import "UMTDetailActivityCellModel.h"
#import "UMTIssurActivityRequest.h"

#define kItemHeight 44

@interface UMTIssueSimpleActivityController ()<UMTAddActivityNavBarDelegate,UITextViewDelegate>

@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic,strong) UIView *pickerTopView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIControl *backgroundControl;
@property (nonatomic,strong) UILabel *tagLabel;
@property (nonatomic,strong) UITextField *titleText;
@property (nonatomic,strong) UITextField *personLimitText;
@property (nonatomic,strong) UILabel *siteLabel;
@property (nonatomic,strong) UIButton *timeButton;
@property (nonatomic,strong) UITextView *contentText;

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
    datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
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
    self.backgroundControl = backgroundControl;
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
    UMTAddActivityItem *contentItem = [[UMTAddActivityItem alloc]initWithFrame:CGRectMake(10, 20, UMTScreenWidth-20, kItemHeight*2)];
    contentItem.numberofItems = 2;
    contentItem.itemNames = @[@"标题",@"地点"];
    [self.scrollView addSubview:contentItem];
    
    UITextField *title = [[UITextField alloc]initWithFrame:CGRectMake(115, 0, 180, kItemHeight)];
    title.placeholder = @"请输入活动标题";
    [contentItem addSubview:title];
    self.titleText = title;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(choiceSite)];
    UIView *rightView = [[UIView alloc]init];
    [rightView addGestureRecognizer:tap];
    [contentItem addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentItem.mas_right);
        make.top.mas_offset(kItemHeight);
        make.height.mas_equalTo(kItemHeight);
    }];
    
    UILabel *siteLabel = [[UILabel alloc]init];
    siteLabel.text = @"请选择地点";
    siteLabel.textColor = Hex(0x8f8e94);
    siteLabel.textAlignment = NSTextAlignmentRight;
    [rightView addSubview:siteLabel];
    [siteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-34);
        make.centerY.equalTo(rightView);
        make.left.equalTo(rightView.mas_left);
    }];
    self.siteLabel = siteLabel;
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"Disclosure_Indicator"] forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(choiceSite) forControlEvents:UIControlEventTouchUpInside];
    [contentItem addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-14);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(15);
        make.centerY.equalTo(rightView);
    }];
}

- (void)choiceSite{
    UMTSiteViewController *siteVC = [[UMTSiteViewController alloc]init];
    __weak typeof(self) weakSelf = self;
    siteVC.block = ^(NSString *site) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.siteLabel.text = site;
    };
    [self.navigationController pushViewController:siteVC animated:YES];
}

- (void)addTimeLimitView{
    UMTAddActivityItem *item = [[UMTAddActivityItem alloc]initWithFrame:CGRectMake(10, kItemHeight*2+40, UMTScreenWidth-20, kItemHeight)];
    item.numberofItems = 1;
    item.itemNames = @[@"愿意等待时间"];
    [self.scrollView addSubview:item];
    
    UIButton *timeButton = [[UIButton alloc]initWithFrame:CGRectMake(UMTScreenWidth-25-80, 0, 80, kItemHeight)];
    [timeButton setTitle:@"10:00" forState:UIControlStateNormal];
    [timeButton setTitleColor:kCommonGreenColor forState:UIControlStateSelected];
    [timeButton setTitleColor:[UIColor colorWithRGB:142 green:142 blue:142] forState:UIControlStateNormal];
    [timeButton addTarget:self action:@selector(choseTime) forControlEvents:UIControlEventTouchUpInside];
    [item addSubview:timeButton];
    self.timeButton = timeButton;
}

- (void)addPersonLimitView{
    UMTAddActivityItem *item = [[UMTAddActivityItem alloc]initWithFrame:CGRectMake(10, kItemHeight*3+60, UMTScreenWidth-20, kItemHeight)];
    item.numberofItems = 1;
    item.itemNames = @[@"最多人数"];
    [self.scrollView addSubview:item];
    
    UITextField *title = [[UITextField alloc]initWithFrame:CGRectMake(UMTScreenWidth-20-180, 0, 150, kItemHeight)];
    title.placeholder = @"选填";
    [item addSubview:title];
    self.personLimitText = title;
}

- (void)addTagItem{
    UMTAddActivityItem *tagItem = [[UMTAddActivityItem alloc]initWithFrame:CGRectMake(10, kItemHeight*4+80, UMTScreenWidth-20, kItemHeight)];
    tagItem.numberofItems = 1;
    tagItem.itemNames = @[@"标签"];
    [self.scrollView addSubview:tagItem];
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(UMTScreenWidth-20-180, 0, 180, kItemHeight)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTag)];
    [rightView addGestureRecognizer:tap];
    [tagItem addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tagItem.mas_right);
        make.top.equalTo(tagItem.mas_top);
        make.height.mas_equalTo(kItemHeight);
    }];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Disclosure_Indicator"]];
//    imgView.frame = CGRectMake(180-26, 0, 8, 13);
    imgView.centerY = rightView.centerY;
    [rightView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(15);
        make.centerY.equalTo(rightView);
    }];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, kItemHeight)];
    label.text = @"请选择一个标签";
    label.textColor = [UIColor colorWithRGB:143 green:142 blue:148];
    [rightView addSubview:label];
    self.tagLabel = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imgView.mas_left).offset(-11);
        make.centerY.equalTo(imgView);
        make.left.equalTo(rightView.mas_left);
    }];
}

- (void)addContentView{
    UITextView *contentText = [[UITextView alloc]initWithFrame:CGRectMake(10, kItemHeight*5+100, UMTScreenWidth-20, UMTScreenHeight*176/667.0)];
    contentText.delegate = self;
    contentText.layer.cornerRadius = 4;
    contentText.text = @"请输入活动号召文字";
    contentText.textColor = [UIColor colorWithRGB:143 green:142 blue:148];
    contentText.font = kFont(17);
    contentText.scrollEnabled = NO;
    [self.scrollView addSubview:contentText];
    self.contentText = contentText;
}

- (void)choseTime{
    [self.view endEditing:YES];
    if (self.timeButton.selected) {
        self.timeButton.selected = NO;
    }else{
        self.timeButton.selected = YES;
    }
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
    self.timeButton.selected = NO;
}

- (void)showPickerView
{
    
    [UIView animateWithDuration:0.2f animations:^{
        [self.pickerTopView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo([UIApplication sharedApplication].keyWindow.mas_bottom).with.offset(-200);
        }];
        self.backgroundControl.alpha = 0.5f;
        [self.pickerTopView.superview layoutIfNeeded];
    }];
}

- (void) timeCommitButtonCliked{
    [self hidePickerView];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"HH:mm";
    NSDate *date = self.datePicker.date;
    NSString *dateStr = [formatter stringFromDate:date];
    [self.timeButton setTitle:dateStr forState:UIControlStateNormal];
}

- (void)chooseTag{
    UMTTagChooseController *tagVC = [[UMTTagChooseController alloc]init];
    tagVC.block = ^(NSArray *tags) {
        self.tagLabel.text = tags[0];
    };
    [self.navigationController pushViewController:tagVC animated:YES];
}

#pragma mark--UMTAddActivityNavBarDelegate

- (void)exitButtonClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonClicked{
    
    UMTDetailActivityCellModel *model = [[UMTDetailActivityCellModel alloc]init];
    model.title = self.titleText.text;
    model.site = self.siteLabel.text;
    NSString *timeStr = self.timeButton.titleLabel.text;
    NSDateFormatter *timeStrFormate = [[NSDateFormatter alloc]init];
    timeStrFormate.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *hourStr = [timeStr substringWithRange:NSMakeRange(0, 2)];
    NSString *minitStr = [timeStr substringWithRange:NSMakeRange(3, 2)];
    NSInteger hour = [hourStr integerValue];
    NSInteger minit = [minitStr integerValue];
    NSTimeInterval interval = hour*3600+minit*60;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:interval];
    NSString *dateStr = [timeStrFormate stringFromDate:date];
    model.applyEndTime = dateStr;
    model.applyStartTime = [timeStrFormate stringFromDate:[NSDate date]];
    model.peopleLimit = [self.personLimitText.text intValue];
    model.tags = @[self.tagLabel.text];
    model.content = self.contentText.text;
    model.type = 2;
    NSDictionary *params = [model yy_modelToJSONObject];
    [[UMTProgressHUD sharedHUD]rotateWithText:@"发布中" inView:self.view];
    [UMTIssurActivityRequest IssueActivityWithParams:params AndCompletionBlock:^(NSError *erro, id response) {
        [[UMTProgressHUD sharedHUD]hideAfterDelay:0];
        if (erro) {
            [[UMTProgressHUD sharedHUD]showWithText:[NSString stringWithFormat:@"%@",erro] inView:self.view hideAfterDelay:0.5];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
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
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardFrameAfterShow = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrameAfterShow.size.height;
    self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y-keyboardHeight);
}

- (void)backClicked{
    [self.view endEditing:YES];
}

@end
