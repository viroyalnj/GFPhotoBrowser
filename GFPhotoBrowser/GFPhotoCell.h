//
//  GFPhotoCell.h
//  Photos
//
//  Created by 熊国锋 on 2016/11/3.
//  Copyright © 2016年 guofengld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface GFPhotoCell : UICollectionViewCell

@property (nonatomic, strong)   PHAsset         *asset;

+ (NSString *)cellIdentifier;

@end
