//
//  UMTcertificationController.m
//  U咪兔
//
//  Created by 谭培 on 2017/4/5.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "UMTcertificationController.h"
#import "UMTSchoolInfoView.h"
#import "UMTRootViewController.h"
#import "UMTUploadPhotoView.h"
#import "UMTAlertView.h"
#import "UMTFindSchoolController.h"
#import "UMTRegisterHelper.h"
#import "UMTRegesterRequest.h"
#import "UMTKeychainTool.h"

#define kItemHeight 44

@interface UMTcertificationController ()<chooseSchoolDelegate,UIImagePickerControllerDelegate,UMTAlertViewDelegate,UINavigationControllerDelegate,UMTUploadPhotoViewDelegate>

@property (nonatomic,strong) UMTAlertView *alertView;
@property (nonatomic,strong) UIImagePickerController *imgPicker;
@property (nonatomic,strong) UIImagePickerController *imgClickedPicker;
@property (nonatomic,strong) UIImage *selectedImg;
@property (nonatomic,strong) UMTUploadPhotoView *uploadPhotoView;
@property (nonatomic,strong) UMTSchoolInfoView *schoolInfoView;
@property (nonatomic,strong) UMTAlertView *imageSelectAlertView;
@property (nonatomic,strong) NSDictionary *schoolInfo;

@end

@implementation UMTcertificationController

{
    NSInteger imageCount;
    NSInteger clickedImageIndex;
}

- (NSString *)title{
    return @"学籍审核";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    imageCount = 0;
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(skip)];
    self.navigationItem.rightBarButtonItem = rightBar;
}

- (void)initUI{
    
    [self initSchoolInfoView];
    [self initUploadPhotoView];
    [self addCommitButton];
}


- (void)initSchoolInfoView{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 84, 60, 18)];
    label.font = kFont(13);
    label.textColor = kGrayFontColor;
    label.text = @"学籍信息";
    [self.view addSubview:label];
    UMTSchoolInfoView *sclView = [[UMTSchoolInfoView alloc]initWithFrame:CGRectMake(0, 110, UMTScreenWidth, kItemHeight*3)];
    sclView.backgroundColor = [UIColor whiteColor];
    sclView.delegate = self;
    self.schoolInfoView = sclView;
    [self.view addSubview:sclView];
}

- (void)initUploadPhotoView{
    
    self.alertView = [[UMTAlertView alloc]initWithFuncArray:@[@"从相册中选择",@"拍照"]];
    self.alertView.delegate = self;
    self.imageSelectAlertView = [[UMTAlertView alloc]initWithFuncArray:@[@"删除",@"从相册中选择",@"拍照"]];
    self.imageSelectAlertView.delegate = self;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 138+kItemHeight*3, 100, 18)];
    label.font = kFont(13);
    label.textColor = kGrayFontColor;
    label.text = @"上传学生证照片";
    [self.view addSubview:label];
    
    UMTUploadPhotoView *upldView = [[UMTUploadPhotoView alloc]initWithFrame:CGRectMake(0, 164+kItemHeight*3, UMTScreenWidth, 96)];
    upldView.delegate = self;
    upldView.backgroundColor = [UIColor whiteColor];
    upldView.buttonClickedblock = ^(void){
        if (imageCount >= 2) {
            return ;
        }
        [self.alertView show];
    };
    [self.view addSubview:upldView];
    self.uploadPhotoView = upldView;
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 268+kItemHeight*3, UMTScreenWidth-30, 54)];
    hintLabel.text = @"我们非常重视个人信息安全，填写真实信息旨在保护用户约玩过程中的安全，我们不会向任何人展示您的真实信息。我们将尽快完成审核";
    hintLabel.font = kFont(13);
    hintLabel.numberOfLines = 0;
    hintLabel.textColor = kGrayFontColor;
    [self.view addSubview:hintLabel];
}

- (void)addCommitButton{
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 333+kItemHeight*3, UMTScreenWidth-40, kItemHeight)];
    [commitButton setTitle:@"提交审核" forState:UIControlStateNormal];
    commitButton.backgroundColor = kCommonGreenColor;
    commitButton.layer.cornerRadius = 4;
    [commitButton addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
}

- (UIImagePickerController *)imgPicker{
    if (!_imgPicker) {
        _imgPicker = [[UIImagePickerController alloc]init];
        _imgPicker.delegate = self;
        _imgPicker.allowsEditing = YES;
    }
    return _imgPicker;
}

- (UIImagePickerController *)imgClickedPicker{
    if (!_imgClickedPicker) {
        _imgClickedPicker = [[UIImagePickerController alloc]init];
        _imgClickedPicker.delegate = self;
        _imgClickedPicker.allowsEditing = YES;
    }
    return _imgClickedPicker;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)commitButtonClicked{
    NSString *name = self.schoolInfoView.userName;
    NSString *schoolname = self.schoolInfoView.schoolName;
    NSString *studentId = self.schoolInfoView.userSchoolId;
    NSArray *pictures = self.uploadPhotoView.pictures;
    if (!name||name.length == 0) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请输入真实姓名" inView:self.view hideAfterDelay:0.5];
        return;
    }
    if (!schoolname||schoolname.length == 0) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请选择学校" inView:self.view hideAfterDelay:0.5];
        return;
    }
    if (!studentId||studentId.length == 0) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请输入学号" inView:self.view hideAfterDelay:0.5];
        return;
    }
    if (!pictures || pictures.count == 0) {
        [[UMTProgressHUD sharedHUD] showWithText:@"请上传学生证" inView:self.view hideAfterDelay:0.5];
        return;
    }
    NSInteger count = pictures.count;
    UMTRegisterHelper *sharedHelper = [UMTRegisterHelper sharedHelper];
    if (count == 1) {
        sharedHelper.photo = UIImagePNGRepresentation(pictures[0]);
    }else if(count == 2){
        sharedHelper.photo = UIImagePNGRepresentation(pictures[0]);
        sharedHelper.photo2 = UIImagePNGRepresentation(pictures[1]);
    }
    sharedHelper.name = name;
    sharedHelper.student_id = studentId;
    sharedHelper.school_id = self.schoolInfo[@"school_id"];
    [[UMTProgressHUD sharedHUD] rotateWithText:@"注册中" inView:self.view];
    [UMTRegesterRequest RegisterWithCompletionBlock:^(NSError *erro, id response) {
        [[UMTProgressHUD sharedHUD] hideAfterDelay:0];
        if (erro) {
            [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",erro] inView:self.view hideAfterDelay:0.5];
        }else{
            if ([response[@"status_code"] isEqualToString:@"2001"]) {
                NSString *token = response[@"token"];
                NSDate *date = [NSDate date];
                [UMTKeychainTool save:kTokenKey data:token];
                [UMTKeychainTool save:@"lastDate" data:date];
                
                [[UMTProgressHUD sharedHUD] showWithText:@"注册成功" inView:self.view hideAfterDelay:0.5];
                UMTRootViewController *rootVc = [[UMTRootViewController alloc]init];
                [self presentViewController:rootVc animated:YES completion:nil];
            }else{
                [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",response[@"info"]] inView:self.view hideAfterDelay:0.5];
            }
            
        }
    }];
}

- (void)skip{
    [[UMTProgressHUD sharedHUD] rotateWithText:@"注册中" inView:self.view];
    [UMTRegesterRequest RegisterWithCompletionBlock:^(NSError *erro, id response) {
        [[UMTProgressHUD sharedHUD]hideAfterDelay:0];
        if (erro) {
            [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",erro] inView:self.view hideAfterDelay:0.5];
        }else{
            if ([response[@"status_code"] isEqualToString:@"2001"]) {
                NSString *token = response[@"token"];
                NSDate *date = [NSDate date];
                
                [UMTKeychainTool save:kTokenKey data:token];
                [UMTKeychainTool save:@"lastDate" data:date];
                
                [[UMTProgressHUD sharedHUD] showWithText:@"注册成功" inView:self.view hideAfterDelay:0.5];
                UMTRootViewController *rootVc = [[UMTRootViewController alloc]init];
                [self presentViewController:rootVc animated:YES completion:nil];
            }else{
                [[UMTProgressHUD sharedHUD] showWithText:[NSString stringWithFormat:@"%@",response[@"info"]] inView:self.view hideAfterDelay:0.5];
            }
            
        }
    }];
}

- (void)alertView:(UMTAlertView *)alertView didClickAtIndex:(NSInteger)index{
    [alertView hide];
    if (alertView == self.alertView) {
        if (index == 0) {
            self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else if (index == 1){
            self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        [self presentViewController:self.imgPicker animated:YES completion:nil];
    }else{
        if (index == 0) {
            imageCount -= 1;
            [self.uploadPhotoView deleteImageView:clickedImageIndex imageCount:imageCount];
            return;
        }else if (index == 1){
            self.imgClickedPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else if (index == 2){
            self.imgClickedPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        [self presentViewController:self.imgClickedPicker animated:YES completion:nil];
    }
    
}

- (void)imageTaped:(UIImageView *)imageView index:(NSInteger)index{
    clickedImageIndex = index;
    [self.imageSelectAlertView show];
}

#pragma mark-UIImagePickerImageControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.selectedImg = info[UIImagePickerControllerEditedImage];
    if (picker == self.imgPicker) {
        
        imageCount += 1;
        [self.uploadPhotoView addImage:self.selectedImg index:imageCount];
        
    }else{
        [self.uploadPhotoView changeImage:self.selectedImg index:clickedImageIndex];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark--chooseSchoolDelegate
- (void)chooseSchool{
    UMTFindSchoolController *findVC = [[UMTFindSchoolController alloc]init];
    __weak typeof(self) weakSelf = self;
    findVC.getSchoolBlock = ^(NSDictionary *schoolInfo) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.schoolInfoView.schoolName = schoolInfo[@"school_name"];
        strongSelf.schoolInfo = schoolInfo;
    };
    [self.navigationController pushViewController:findVC animated:YES];
}


@end
