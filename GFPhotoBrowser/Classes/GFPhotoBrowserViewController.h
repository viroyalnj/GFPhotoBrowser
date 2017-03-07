//
//  GFPhotoBrowserViewController.h
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/4.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class GFPhotoBrowserViewController;

@protocol PhotoBrowserDelegate <NSObject>

- (void)browser:(GFPhotoBrowserViewController *)browser selectItems:(NSArray <PHAsset *> *)items;

@end

@interface GFPhotoBrowserViewController : UICollectionViewController

@property (nonatomic, weak) id <PhotoBrowserDelegate>   delegate;

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType
     allowsMultipleSelection:(BOOL)allowsMultipleSelection;


@end
