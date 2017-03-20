//
//  GFPhotoBrowserViewController.h
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/4.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef NS_ENUM(NSUInteger, GFPhotoReturnType) {
    PhotoAsset,
    PhotoOriginal,
    PhotoLarge,
    PhotoMedium,
    PhotoSmall,
};

@class GFPhotoBrowserViewController;

@protocol PhotoBrowserDelegate <NSObject>

@optional

- (void)browser:(GFPhotoBrowserViewController *)browser selectAssets:(NSArray <PHAsset *> *)assets;
- (void)browser:(GFPhotoBrowserViewController *)browser selectImages:(NSArray <UIImage *> *)images;

@end

@interface GFPhotoBrowserViewController : UICollectionViewController

@property (nonatomic, weak) id <PhotoBrowserDelegate>   delegate;
@property (nonatomic, assign) GFPhotoReturnType         returnType;

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType
                   mediaType:(PHAssetMediaType)mediaType
     allowsMultipleSelection:(BOOL)allowsMultipleSelection;

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType
                   mediaType:(PHAssetMediaType)mediaType
     allowsMultipleSelection:(BOOL)allowsMultipleSelection
                  returnType:(GFPhotoReturnType)returnType;

@end
