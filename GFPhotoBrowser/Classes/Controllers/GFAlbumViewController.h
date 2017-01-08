//
//  GFAlbumViewController.h
//  Photos
//
//  Created by 熊国锋 on 2016/11/4.
//  Copyright © 2016年 viroyal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFPhotosDataSource.h"

@class GFAlbumViewController;

@protocol AlbumViewDelegate <NSObject>

- (void)album:(GFAlbumViewController *)album selectSection:(PhotoSectionInfo *)sectionInfo;

@end

@interface GFAlbumViewController : UITableViewController

@property (nonatomic, weak) id<AlbumViewDelegate>   delegate;

@end
