//
//  GFAlbumCell.h
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/3.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFPhotosDataSource.h"

@interface GFAlbumCell : UITableViewCell

@property (nonatomic, copy) PhotoSectionInfo        *sectionInfo;

+ (NSString *)cellIdentifier;

@end
