//
//  XYWillNotifyViewController.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYWillNotifyViewController.h"
#import "XYNewNotifyImgView.h"
#import "XYAddEventViewController.h"
@interface XYWillNotifyViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *notifyRemark;
@property (weak, nonatomic) IBOutlet XYNewNotifyImgView *notifyImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notifyImgViewH;

@property(nonatomic,strong)XYNotifyModel* model;

@end

@implementation XYWillNotifyViewController

- (IBAction)nextStepClick:(id)sender {
    
    [self.view endEditing:YES];
    
    //此处存储传递数据
    if ([XYTool removeSpaceAndNewline:self.notifyRemark.text].length==0) {
        [XYTool showPromptView:@"请填写提醒信息" holdView:nil];
        return;
    }else{
        self.model.notifyRemark=self.notifyRemark.text;
    }
    if (self.model.notifyImgUrl==nil||self.model.notifyImgUrl.length==0) {
        [XYTool showPromptView:@"请设置图片" holdView:nil];
        return;
    }
    
    [self performSegueWithIdentifier:@"XYAddEventViewController" sender:self.model];
}



- (IBAction)takePhoto:(id)sender {
    
    UIAlertController* alertCtl=[UIAlertController alertControllerWithTitle:@"设置提醒图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* action1=[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *picker=[[UIImagePickerController alloc] init];
            picker.delegate = self;
            //picker.allowsEditing=YES;
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            picker.videoQuality = UIImagePickerControllerQualityType640x480;
            [self presentViewController:picker animated:YES completion:nil];
            
        }
    }];
    UIAlertAction* action2=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相册
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *picker=[[UIImagePickerController alloc] init];
            picker.delegate = self;
            //picker.allowsEditing=YES;
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            picker.videoQuality = UIImagePickerControllerQualityType640x480;
            [self presentViewController:picker animated:YES completion:nil];
            
        }
    }];
    
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        UIAlertAction* actionDeleteImg=[UIAlertAction actionWithTitle:@"移除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //删除图片
            [self.notifyImgView setImage:nil];
            self.model.notifyImgUrl=nil;
        }];
        [alertCtl addAction:actionDeleteImg];
    }
    
    UIAlertAction* action3=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    [alertCtl addAction:action1];
    [alertCtl addAction:action2];
    [alertCtl addAction:action3];
    [self presentViewController:alertCtl animated:YES completion:nil];
}

- (IBAction)closePageClick:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf)
    self.notifyImgView.callBack=^(id sender){
        [weakSelf takePhoto:sender];
    };
    self.notifyImgViewH.constant=Main_Screen_Width*2/3;
    self.model=[[XYNotifyModel alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Image Picker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *sizedImage= [self sizedImage:[info objectForKey:UIImagePickerControllerOriginalImage] withMaxValue:2500];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self performSelectorOnMainThread:@selector(uploadUserIcon:) withObject:sizedImage waitUntilDone:NO];
    }];
}
//上传照片
- (void)uploadUserIcon:(UIImage *)userIcon{
    
    [self.notifyImgView setImage:userIcon];
    self.model.notifyImgUrl=@"http://img5q.duitang.com/uploads/item/201503/07/20150307203721_nnS2E.png";
}

- (UIImage *)sizedImage:(UIImage *)originalImage withMaxValue:(float)maxValue
{
    UIImage *image = originalImage;
    CGFloat var1;
    CGFloat var2;
    
    if (image.size.width > image.size.height){
        // Landscape
        CGFloat aspect = image.size.width / image.size.height;
        CGFloat height = ceilf(maxValue/aspect);
        var1 = maxValue;
        var2 = height;
    }
    else if (image.size.height > image.size.width){
        // Portrait
        CGFloat aspect = image.size.height / image.size.width;
        CGFloat width = ceilf(maxValue/aspect);
        var1 = width;
        var2 = maxValue;
    }
    else{
        // Square
        var1 = maxValue;
        var2 = maxValue;
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(var1, var2), NO, 1);
    [image drawInRect:CGRectMake(0, 0, var1, var2)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[XYAddEventViewController class]]) {
        XYAddEventViewController* tempCtl=(XYAddEventViewController*)segue.destinationViewController;
        tempCtl.model=self.model;
    }
}

@end
