//
//  GFPhotoCell.h
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/3.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface GFPhotoCell : UICollectionViewCell

@property (nonatomic, strong)   PHAsset         *asset;
@property (nonatomic)           BOOL            allowsMultipleSelection;

+ (NSString *)cellIdentifier;

@end
