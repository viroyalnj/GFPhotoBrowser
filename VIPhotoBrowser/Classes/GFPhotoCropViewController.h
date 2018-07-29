//
//  GFPhotoCropViewController.h
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/4.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GFPhotoCropViewController;

@protocol GFPhotoCropViewControllerDelegate <NSObject>

- (void)photoCropViewControllerDidCancel:(GFPhotoCropViewController *)cropViewController;
- (void)photoCropViewController:(GFPhotoCropViewController *)cropViewController
         didFinishCroppingImage:(UIImage *)image;

@end

@interface GFPhotoCropViewController : UIViewController

@property (nonatomic, weak) id<GFPhotoCropViewControllerDelegate>       delegate;
@property (assign)          CGFloat                                     outputWidth;

- (instancetype)initWithImage:(UIImage *)image fixedRatio:(CGFloat)ratio;

@end
