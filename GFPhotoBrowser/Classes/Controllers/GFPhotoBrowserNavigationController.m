//
//  GFPhotoBrowserNavigationController.m
//  Photos
//
//  Created by 熊国锋 on 2016/11/4.
//  Copyright © 2016年 viroyal. All rights reserved.
//

#import "GFPhotoBrowserNavigationController.h"
#import "GFAlbumViewController.h"
#import "GFPhotoBrowserViewController.h"

@interface GFPhotoBrowserNavigationController () < AlbumViewDelegate, PhotoBrowserDelegate >

@property (nonatomic, strong) GFPhotoBrowserViewController        *browserView;

@end

@implementation GFPhotoBrowserNavigationController

@dynamic delegate;

- (instancetype)initWithType:(PHAssetCollectionType)type subType:(PHAssetCollectionSubtype)subType {
    GFAlbumViewController *album = [[GFAlbumViewController alloc] init];
    if (self = [super initWithRootViewController:album]) {
        self.browserView = [[GFPhotoBrowserViewController alloc] initWithType:PHAssetCollectionTypeSmartAlbum
                                                                    subType:PHAssetCollectionSubtypeSmartAlbumUserLibrary];
        
        album.delegate = self;
        self.browserView.delegate = self;
        [self pushViewController:self.browserView animated:NO];
    }
    
    return self;
}

#pragma mark - AlbumViewDelegate

- (void)album:(GFAlbumViewController *)album selectSection:(PhotoSectionInfo *)sectionInfo {
    self.browserView = [[GFPhotoBrowserViewController alloc] initWithType:sectionInfo.type
                                                                subType:sectionInfo.subType];
    self.browserView.delegate = self;
    [self pushViewController:self.browserView animated:YES];
}

#pragma mark - PhotoBrowserDelegate

- (void)browser:(GFPhotoBrowserViewController *)browser selectItem:(PHAsset *)asset {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate browserNavi:self selectItem:asset];
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
