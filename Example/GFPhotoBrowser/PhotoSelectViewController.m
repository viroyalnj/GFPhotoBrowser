//
//  PhotoSelectViewController.m
//  Photos
//
//  Created by 熊国锋 on 2016/11/4.
//  Copyright © 2016年 guofengld. All rights reserved.
//

#import "PhotoSelectViewController.h"
#import "PhotoBrowserViewController.h"
#import "AlbumViewController.h"
#import <Masonry/Masonry.h>
#import "PhotoBrowserNavigationController.h"

@interface PhotoSelectViewController () < PhotoBrowserNavigationDelegate >

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
    PhotoBrowserNavigationController *nav = [[PhotoBrowserNavigationController alloc] initWithType:PHAssetCollectionTypeSmartAlbum
                                                                                           subType:PHAssetCollectionSubtypeSmartAlbumUserLibrary];
    nav.delegate = self;
    
    [self.navigationController presentViewController:nav
                                            animated:YES
                                          completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PhotoBrowserNavigationDelegate

- (void)browserNavi:(PhotoBrowserNavigationController *)nav
         selectItem:(PHAsset *)asset {
    __weak typeof(self) wself = self;
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:CGSizeMake(1024, 1024)
                                              contentMode:PHImageContentModeDefault
                                                  options:nil
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                NSLog(@"image size: %@", NSStringFromCGSize(result.size));
                                                wself.imageView.image = result;
                                                wself.imageView.backgroundColor = [UIColor clearColor];
                                            }];
}

@end
