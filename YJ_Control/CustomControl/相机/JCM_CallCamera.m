//
//  JCM_CallCamera.m
//  竞彩猫
//
//  Created by yujie on 2017/5/11.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_CallCamera.h"

@interface JCM_CallCamera()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSUInteger sourceType;
}
@end

@implementation JCM_CallCamera

+ (JCM_CallCamera *)sharedModel{
    static JCM_CallCamera *sharedModel = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sharedModel = [[self alloc] init];
    });
    return sharedModel;
}

+(void)sendImageWithBlock:(JCM_ChoosedPhotoBlock)choosedPhotoBlock{
    
    JCM_CallCamera *callCamera = [JCM_CallCamera sharedModel];
    
    callCamera.choosedPhotoBlock = choosedPhotoBlock;
    
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:callCamera cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"相册", nil];
    }else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:callCamera cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:[[[[[UIApplication sharedApplication] delegate] window] rootViewController] view]];
    
}

#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:  // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:  // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
                    break;
            }
        }else {
            if (buttonIndex == 0) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            } else {
                return;
            }
        }
        
        // 跳转到相机或相册页面
        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:imagePickerController animated:YES completion:NULL];
        
    }
}

#pragma mark - image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    image = [self OriginImage:image scaleToSize:CGSizeMake(image.size.width*0.8, image.size.height*0.8)];
    
    [self choosedPhotoBlock](image);
    
}

-(UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, SCALE_ELEMENT);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}


@end
