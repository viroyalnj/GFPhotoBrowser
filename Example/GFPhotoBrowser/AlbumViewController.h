//
//  AlbumViewController.h
//  Photos
//
//  Created by 熊国锋 on 2016/11/4.
//  Copyright © 2016年 viroyal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosDataSource.h"

@class AlbumViewController;

@protocol AlbumViewDelegate <NSObject>

- (void)album:(AlbumViewController *)album selectSection:(PhotoSectionInfo *)sectionInfo;

@end

@interface AlbumViewController : UITableViewController

@property (nonatomic, weak) id<AlbumViewDelegate>   delegate;

@end
