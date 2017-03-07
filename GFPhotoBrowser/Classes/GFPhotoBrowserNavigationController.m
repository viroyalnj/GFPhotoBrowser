//
//  GFPhotoBrowserNavigationController.m
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/4.
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

- (instancetype)init {
    NSAssert(NO, @"Please use the method -initWithType:subType:allowsMultipleSelection: instead");
    return nil;
}

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType
     allowsMultipleSelection:(BOOL)allowsMultipleSelection {
    GFAlbumViewController *album = [[GFAlbumViewController alloc] init];
    if (self = [super initWithRootViewController:album]) {
        self.allowsMultipleSelection = allowsMultipleSelection;
        
        self.browserView = [[GFPhotoBrowserViewController alloc] initWithType:type
                                                                      subType:subType
                                                      allowsMultipleSelection:self.allowsMultipleSelection];
        
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
                                                  allowsMultipleSelection:self.allowsMultipleSelection];
    self.browserView.delegate = self;
    [self pushViewController:self.browserView animated:YES];
}

#pragma mark - PhotoBrowserDelegate

- (void)browser:(GFPhotoBrowserViewController *)browser selectItems:(NSArray<PHAsset *> *)items {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate browserNavi:self selectItems:items];
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
