//
//  ViewController.h
//  GFPhotoBrowser
//
//  Created by guofengld on 11/04/2016.
//  Copyright (c) 2016 guofengld. All rights reserved.
//

@import UIKit;
#import "PhotosDataSource.h"

@interface ViewController : UICollectionViewController

- (instancetype)initWithType:(PHAssetCollectionType)type;

@end
