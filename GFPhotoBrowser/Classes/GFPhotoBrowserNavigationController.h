//
//  GFPhotoBrowserNavigationController.h
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/4.
//  Copyright © 2016年 viroyal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class GFPhotoBrowserNavigationController;

@protocol PhotoBrowserNavigationDelegate <UINavigationControllerDelegate>

- (void)browserNavi:(GFPhotoBrowserNavigationController *)nav selectAssets:(NSArray<PHAsset *> *)assets;

@end

@interface GFPhotoBrowserNavigationController : UINavigationController

@property (nonatomic, weak) id <PhotoBrowserNavigationDelegate> delegate;
@property (nonatomic) BOOL allowsMultipleSelection;

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType
     allowsMultipleSelection:(BOOL)allowsMultipleSelection;

@end
