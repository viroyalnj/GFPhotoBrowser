//
//  GFPhotoBrowserNavigationController.m
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/4.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import "GFPhotoBrowserNavigationController.h"
#import "GFAlbumViewController.h"
#import "GFPhotoBrowserViewController.h"

@interface GFPhotoBrowserNavigationController () < AlbumViewDelegate, PhotoBrowserDelegate >

@property (nonatomic, strong) GFPhotoBrowserViewController        *browserView;

@end

@implementation GFPhotoBrowserNavigationController

@dynamic delegate;

- (instancetype)init {
    NSAssert(NO, @"Please use the method -initWithType:subType:allowsMultipleSelection: instead");
    return nil;
}

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType
                   mediaType:(PHAssetMediaType)mediaType
     allowsMultipleSelection:(BOOL)allowsMultipleSelection {
    return [self initWithType:type
                      subType:subType
                    mediaType:mediaType
      allowsMultipleSelection:allowsMultipleSelection
                   returnSize:PHImageManagerMaximumSize];
}

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType
                   mediaType:(PHAssetMediaType)mediaType
     allowsMultipleSelection:(BOOL)allowsMultipleSelection
                  returnSize:(CGSize)returnSize {
    
    GFAlbumViewController *album = [[GFAlbumViewController alloc] init];
    if (self = [super initWithRootViewController:album]) {
        self.mediaType = mediaType;
        self.allowsMultipleSelection = allowsMultipleSelection;
        self.returnSize = returnSize;
        
        self.browserView = [[GFPhotoBrowserViewController alloc] initWithType:type
                                                                      subType:subType
                                                                    mediaType:mediaType
                                                      allowsMultipleSelection:self.allowsMultipleSelection
                                                                   returnSize:returnSize];
        
        album.delegate = self;
        self.browserView.delegate = self;
        [self pushViewController:self.browserView animated:NO];
    }
    
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - AlbumViewDelegate

- (void)album:(GFAlbumViewController *)album selectSection:(PhotoSectionInfo *)sectionInfo {
    self.browserView = [[GFPhotoBrowserViewController alloc] initWithType:sectionInfo.type
                                                                  subType:sectionInfo.subType
                                                                mediaType:self.mediaType
                                                  allowsMultipleSelection:self.allowsMultipleSelection
                                                               returnSize:self.returnSize];
    self.browserView.delegate = self;
    [self pushViewController:self.browserView animated:YES];
}

#pragma mark - PhotoBrowserDelegate

- (void)browser:(GFPhotoBrowserViewController *)browser selectAssets:(NSArray<PHAsset *> *)assets {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(browserNavi:selectAssets:)]) {
            [self.delegate browserNavi:self selectAssets:assets];
        }
    }];
}

- (void)browser:(GFPhotoBrowserViewController *)browser selectImages:(NSArray<UIImage *> *)images {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(browserNavi:selectImages:)]) {
            [self.delegate browserNavi:self selectImages:images];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
