//
//  GFPhotoBrowserNavigationController.h
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/4.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class GFPhotoBrowserNavigationController;

@protocol GFPhotoBrowserNavigationDelegate <UINavigationControllerDelegate>

- (void)browserNavi:(GFPhotoBrowserNavigationController *)nav selectAssets:(NSArray<PHAsset *> *)assets;

@end

@interface GFPhotoBrowserNavigationController : UINavigationController

@property (nonatomic, weak) id <GFPhotoBrowserNavigationDelegate> delegate;

@property (nonatomic) PHAssetMediaType      mediaType;
@property (nonatomic) BOOL                  allowsMultipleSelection;

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType
                   mediaType:(PHAssetMediaType)mediaType
     allowsMultipleSelection:(BOOL)allowsMultipleSelection;

@end
