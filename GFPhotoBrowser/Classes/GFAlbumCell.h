//
//  GFAlbumCell.h
//  Pods
//
//  Created by guofengld on 2016/11/4.
//
//

#import <UIKit/UIKit.h>
#import "GFPhotosDataSource.h"

@interface GFAlbumCell : UITableViewCell

@property (nonatomic, copy) PhotoSectionInfo        *sectionInfo;

+ (NSString *)cellIdentifier;

@end
