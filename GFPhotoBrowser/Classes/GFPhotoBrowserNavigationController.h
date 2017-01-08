//
//  GFPhotoBrowserNavigationController.h
//  Photos
//
//  Created by 熊国锋 on 2016/11/4.
//  Copyright © 2016年 viroyal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class GFPhotoBrowserNavigationController;

@protocol PhotoBrowserNavigationDelegate <UINavigationControllerDelegate>

- (void)browserNavi:(GFPhotoBrowserNavigationController *)nav selectItem:(PHAsset *)asset;

@end

@interface GFPhotoBrowserNavigationController : UINavigationController

@property (nonatomic, weak) id <PhotoBrowserNavigationDelegate> delegate;

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType;

@end
