//
//  GFPhotoCropViewController.m
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/4.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import "GFPhotoCropViewController.h"
#import "NSBundle+GFPhotoBrowser.h"

@interface GFCropView : UIView

@end

@implementation GFCropView

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        self.backgroundColor = [UIColor purpleColor];
    }
    
    return self;
}

@end

#pragma mark - GFPhotoCropViewController

@interface GFPhotoCropViewController ()

@property (nonatomic, strong) UIImage           *image;

@property (nonatomic, strong) GFCropView        *cropView;

@end

@implementation GFPhotoCropViewController

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        self.image = image;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.navigationController) {
        self.navigationController.navigationBarHidden = YES;
    }
    
    self.cropView = [[GFCropView alloc] initWithImage:self.image];
    [self.view addSubview:self.cropView];
    
    self.cropView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.cropView
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.
                                                           constant:.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.cropView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.
                                                           constant:.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.cropView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.
                                                           constant:.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.cropView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.
                                                           constant:.0]];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCancel setTitle:GFLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    [btnCancel addTarget:self
                  action:@selector(touchCancel)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCancel];
    
    btnCancel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btnCancel
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeftMargin
                                                         multiplier:1.
                                                           constant:.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btnCancel
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottomMargin
                                                         multiplier:1.
                                                           constant:.0]];
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone setTitle:GFLocalizedString(@"Done", nil) forState:UIControlStateNormal];
    [btnDone addTarget:self
                action:@selector(touchDone)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDone];
    
    btnDone.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btnDone
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRightMargin
                                                         multiplier:1.
                                                           constant:.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btnDone
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottomMargin
                                                         multiplier:1.
                                                           constant:.0]];

    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)touchCancel {
    [self.delegate photoCropViewControllerDidCancel:self];
}

- (void)touchDone {
    [self.delegate photoCropViewController:self
                    didFinishCroppingImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
