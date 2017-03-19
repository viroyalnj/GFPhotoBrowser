//
//  PhotoSelectViewController.m
//  Photos
//
//  Created by 熊国锋 on 2016/11/4.
//  Copyright © 2016年 guofengld. All rights reserved.
//

#import "PhotoSelectViewController.h"
#import <Masonry/Masonry.h>
#import <GFPhotoBrowser/GFPhotoBrowser.h>

@interface PhotoSelectViewController () < GFPhotoBrowserNavigationDelegate, GFPhotoCropViewControllerDelegate >

@property (nonatomic, strong)   UIImageView         *imageView;

@end

@implementation PhotoSelectViewController

- (instancetype)init {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)loadView {
    UIView *view = [[UIView alloc] init];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.backgroundColor = [UIColor purpleColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(selectPhoto)]];
    self.imageView.userInteractionEnabled = YES;
    [view addSubview:self.imageView];
    
    CGFloat width = MIN(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) - 80;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([NSNumber numberWithFloat:width]);
        make.height.equalTo(self.imageView.mas_width).offset(-80);
        make.center.equalTo(view);
    }];
    
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Select photo";
}

- (void)selectPhoto {
    GFPhotoBrowserNavigationController *nav = [[GFPhotoBrowserNavigationController alloc] initWithType:PHAssetCollectionTypeSmartAlbum
                                                                                               subType:PHAssetCollectionSubtypeSmartAlbumUserLibrary
                                                                                             mediaType:PHAssetMediaTypeImage
                                                                               allowsMultipleSelection:NO];
    nav.delegate = self;
    
    [self presentViewController:nav
                       animated:YES
                     completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PhotoBrowserNavigationDelegate

- (void)browserNavi:(GFPhotoBrowserNavigationController *)nav
       selectAssets:(NSArray<PHAsset *> *)assets {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    
    __weak typeof(self) wself = self;
    [[PHImageManager defaultManager] requestImageForAsset:[assets firstObject]
                                               targetSize:CGSizeMake(1024, 1024)
                                              contentMode:PHImageContentModeDefault
                                                  options:options
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                if (result) {
                                                    GFPhotoCropViewController *crop = [[GFPhotoCropViewController alloc] initWithImage:result];
                                                    crop.delegate = self;
                                                    [self presentViewController:crop
                                                                       animated:YES
                                                                     completion:nil];
                                                }
                                                else {
                                                    wself.imageView.backgroundColor = [UIColor purpleColor];
                                                }
                                            }];
}

#pragma mark - GFPhotoCropViewControllerDelegate

- (void)photoCropViewControllerDidCancel:(GFPhotoCropViewController *)cropViewController {
    [cropViewController dismissViewControllerAnimated:YES
                                           completion:nil];
}

- (void)photoCropViewController:(GFPhotoCropViewController *)cropViewController
         didFinishCroppingImage:(UIImage *)image {
    [cropViewController dismissViewControllerAnimated:YES
                                           completion:^{
                                               
                                           }];
}

@end
