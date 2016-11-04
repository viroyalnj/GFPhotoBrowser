//
//  PhotoCell.m
//  Photos
//
//  Created by 熊国锋 on 2016/11/3.
//  Copyright © 2016年 guofengld. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell ()

@property (nonatomic, strong)   UIImageView     *imageView;

@end

@implementation PhotoCell

+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.imageView];
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.contentView
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0
                                                                    constant:1]];
        
        [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.contentView
                                                                   attribute:NSLayoutAttributeTop
                                                                  multiplier:1.0
                                                                    constant:1]];
        
        [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.contentView
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0
                                                                    constant:-1]];
        
        [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.contentView
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0
                                                                    constant:-1]];
    }
    
    return self;
}

- (void)setAsset:(PHAsset *)asset {
    _asset = asset;
    
    __weak typeof(self) wself = self;
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:CGSizeMake(128, 128)
                                              contentMode:PHImageContentModeDefault
                                                  options:nil
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                wself.imageView.image = result;
                                            }];
}

@end
