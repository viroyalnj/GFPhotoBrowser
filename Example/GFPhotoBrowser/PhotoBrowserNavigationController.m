//
//  PhotoBrowserNavigationController.m
//  Photos
//
//  Created by 熊国锋 on 2016/11/4.
//  Copyright © 2016年 viroyal. All rights reserved.
//

#import "PhotoBrowserNavigationController.h"
#import "AlbumViewController.h"
#import "PhotoBrowserViewController.h"

@interface PhotoBrowserNavigationController () < AlbumViewDelegate, PhotoBrowserDelegate >

@property (nonatomic, strong) PhotoBrowserViewController        *browserView;

@end

@implementation PhotoBrowserNavigationController

@dynamic delegate;

- (instancetype)initWithType:(PHAssetCollectionType)type subType:(PHAssetCollectionSubtype)subType {
    AlbumViewController *album = [[AlbumViewController alloc] init];
    if (self = [super initWithRootViewController:album]) {
        self.browserView = [[PhotoBrowserViewController alloc] initWithType:PHAssetCollectionTypeSmartAlbum
                                                                    subType:PHAssetCollectionSubtypeSmartAlbumUserLibrary];
        
        album.delegate = self;
        self.browserView.delegate = self;
        [self pushViewController:self.browserView animated:NO];
    }
    
    return self;
}

#pragma mark - AlbumViewDelegate

- (void)album:(AlbumViewController *)album selectSection:(PhotoSectionInfo *)sectionInfo {
    self.browserView = [[PhotoBrowserViewController alloc] initWithType:sectionInfo.type
                                                                subType:sectionInfo.subType];
    self.browserView.delegate = self;
    [self pushViewController:self.browserView animated:YES];
}

#pragma mark - PhotoBrowserDelegate

- (void)browser:(PhotoBrowserViewController *)browser selectItem:(PHAsset *)asset {
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
