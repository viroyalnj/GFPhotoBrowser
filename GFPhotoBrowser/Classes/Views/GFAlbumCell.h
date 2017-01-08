//
//  GFAlbumCell.h
//  Pods
//
//  Created by 熊国锋 on 2016/11/4.
//
//

#import <UIKit/UIKit.h>
#import "GFPhotosDataSource.h"

@interface GFAlbumCell : UITableViewCell

@property (nonatomic, copy) PhotoSectionInfo        *sectionInfo;

+ (NSString *)cellIdentifier;

@end
