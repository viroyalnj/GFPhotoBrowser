//
//  PhotoBrowserViewController.h
//  Photos
//
//  Created by 熊国锋 on 2016/11/4.
//  Copyright © 2016年 guofengld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class PhotoBrowserViewController;

@protocol PhotoBrowserDelegate <NSObject>

- (void)browser:(PhotoBrowserViewController *)browser selectItem:(PHAsset *)asset;

@end

@interface PhotoBrowserViewController : UICollectionViewController

@property (nonatomic, weak) id <PhotoBrowserDelegate>   delegate;

- (instancetype)initWithType:(PHAssetCollectionType)type subType:(PHAssetCollectionSubtype)subType;

@end
