//
//  UMTEditViewController.m
//  U咪兔
//
//  Created by 谭培 on 2017/5/21.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTEditViewController.h"
#import "UMTInfoContactController.h"
#import "UIResponder+Extension.h"
#import "UMTAlertView.h"

#define kItemHeight 44

@interface UMTEditViewController ()<UMTAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIImageView *headImage;
@property (nonatomic,strong) UITextField *nameText;
@property (nonatomic,strong) UITextField *introText;
@property (nonatomic,strong) UMTInfoContactController *contactVC;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UMTAlertView *alertView;
@property (nonatomic,strong) UIImagePickerController *imgPicker;

@end

@implementation UMTEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑个人资料";
    [self initUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initUI{
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(UMTScreenWidth, UMTScreenHeight-64);
    UIControl *backControl = [[UIControl alloc]initWithFrame:scrollView.bounds];
    [backControl addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    backControl.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:backControl];
    self.scrollView = scrollView;
    
    _headImage = [[UIImageView alloc]init];
    _headImage.image = [UIImage imageNamed:@"m1"];
    UIButton *hiddenButton = [[UIButton alloc]init];
    [hiddenButton addTarget:self action:@selector(headImageClicked) forControlEvents:UIControlEventTouchUpInside];
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    //    [tap addTarget:self action:@selector(headImageClicked)];
    //    [_headImage addGestureRecognizer:tap];
    [scrollView addSubview:_headImage];
    [backControl addSubview:hiddenButton];
    [hiddenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(_headImage);
    }];
    CGFloat width = 68;
    _headImage.layer.cornerRadius = width/2;
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.centerX.equalTo(self.view);
        make.width.and.height.mas_equalTo(width);
    }];
    
    UILabel *xinxiLabel = [[UILabel alloc]init];
    xinxiLabel.text = @"公开信息";
    xinxiLabel.textColor = Hex(0x6d6d72);
    xinxiLabel.font = kFont(13);
    [scrollView addSubview:xinxiLabel];
    [xinxiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImage.mas_bottom).offset(20);
        make.left.mas_offset(20);
    }];
    
    UIView *item = [[UIView alloc]init];
    item.backgroundColor = [UIColor whiteColor];
    item.layer.cornerRadius = 4;
    item.layer.borderColor = kLineColor.CGColor;
    item.layer.borderWidth = 1;
    [scrollView addSubview:item];
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(xinxiLabel.mas_bottom).offset(8);
        make.height.mas_equalTo(kItemHeight*2);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = Hex(0xdedfe0);
    [item addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(item);
        make.top.mas_offset(kItemHeight);
        make.height.mas_equalTo(0.5);
    }];
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"昵称";
    nameLabel.textColor = Hex(0x333333);
    nameLabel.font = kFont(17);
    [item addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(10);
    }];
    UILabel *introLabel = [[UILabel alloc]init];
    introLabel.text = @"简介";
    introLabel.textColor = Hex(0x333333);
    introLabel.font = kFont(17);
    [item addSubview:introLabel];
    [introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.bottom.mas_offset(-10);
    }];
    
    _nameText = [[UITextField alloc]init];
    _nameText.textColor = Hex(0xbbbbbb);
    [item addSubview:_nameText];
    [_nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(115);
        make.centerY.equalTo(nameLabel);
        make.right.mas_offset(-10);
    }];
    
    _introText = [[UITextField alloc]init];
    _introText.textColor = Hex(0xbbbbbb);
    [item addSubview:_introText];
    [_introText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameText.mas_left);
        make.centerY.equalTo(introLabel);
        make.right.mas_offset(-10);
    }];
    
    UILabel *yincangLabel = [[UILabel alloc]init];
    yincangLabel.text = @"隐藏联系方式";
    yincangLabel.textColor = Hex(0x6d6d72);
    yincangLabel.font = kFont(13);
    [scrollView addSubview:yincangLabel];
    [yincangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item.mas_bottom).offset(20);
        make.left.mas_offset(20);
    }];
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(10, 265, UMTScreenWidth-20, kItemHeight*3)];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    tableview.layer.cornerRadius = 4;
    tableview.layer.borderColor = kLineColor.CGColor;
    tableview.layer.borderWidth = 0.5;
    //    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 76+kItemHeight*2+kItemHeight*3+18+18+kItemHeight*3, UMTScreenWidth, 0.5)];
    //    bottomLine.backgroundColor = kLineColor;
    //    [scrollView addSubview:bottomLine];
    
    UMTInfoContactController *helper = [[UMTInfoContactController alloc]initWithTableView:tableview];
    self.contactVC = helper;
    [scrollView addSubview:tableview];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableHeightChanged:) name:@"tableHeightChange" object:nil];
    
    self.alertView = [[UMTAlertView alloc]initWithFuncArray:@[@"从相册中选择",@"拍照"]];
    self.alertView.delegate = self;
}


- (void)backClicked{
    [self.view endEditing:YES];
}

- (void)tableHeightChanged:(NSNotification *)notification{
    //    tableHeight = [notification.userInfo[@"height"] floatValue];
    //    [self refreshUI];
}

- (void)headImageClicked{
    [self.alertView show];
}

- (void)alertView:(UMTAlertView *)alertView didClickAtIndex:(NSInteger)index{
    [alertView hide];
    if (index == 0) {
        self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else if (index == 1){
        self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self presentViewController:self.imgPicker animated:YES completion:nil];
}

- (UIImagePickerController *)imgPicker{
    if (!_imgPicker) {
        _imgPicker = [[UIImagePickerController alloc]init];
        _imgPicker.delegate = self;
        _imgPicker.allowsEditing = YES;
    }
    return _imgPicker;
}

#pragma mark-UIImagePickerImageControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.headImage.image = info[UIImagePickerControllerEditedImage];
    _headImage.layer.cornerRadius = 68/2;
    [picker dismissViewControllerAnimated:YES completion:nil];
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
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

@end
