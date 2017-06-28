//
//  GFPhotoBrowserNavigationController.h
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/4.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "GFPhotoBrowserViewController.h"

@class GFPhotoBrowserNavigationController;

@protocol GFPhotoBrowserNavigationDelegate <UINavigationControllerDelegate>

@optional

- (void)browserNavi:(GFPhotoBrowserNavigationController *)nav selectImages:(NSArray<UIImage *> *)images;

@end

@interface GFPhotoBrowserNavigationController : UINavigationController

@property (nonatomic, weak) id <GFPhotoBrowserNavigationDelegate> delegate;

@property (nonatomic) PHAssetMediaType      mediaType;
@property (nonatomic) BOOL                  allowsMultipleSelection;
@property (nonatomic) CGSize                returnSize;
@property (nonatomic) NSInteger             imageCountLimit;

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType
                   mediaType:(PHAssetMediaType)mediaType
     allowsMultipleSelection:(BOOL)allowsMultipleSelection;

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType
                   mediaType:(PHAssetMediaType)mediaType
     allowsMultipleSelection:(BOOL)allowsMultipleSelection
                  returnSize:(CGSize)returnSize;

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType
                   mediaType:(PHAssetMediaType)mediaType
     allowsMultipleSelection:(BOOL)allowsMultipleSelection
                  returnSize:(CGSize)returnSize
             imageCountLimit:(NSInteger)imageCountLimit;

@end
