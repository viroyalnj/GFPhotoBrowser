//
//  PhotoCell.m
//  Photos
//
//  Created by 熊国锋 on 2016/11/3.
//  Copyright © 2016年 guofengld. All rights reserved.
//

#import "PhotoCell.h"
#import <Masonry/Masonry.h>

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
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(1);
            make.top.equalTo(self.contentView.mas_top).offset(1);
            make.right.equalTo(self.contentView.mas_right).offset(-1);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
        }];
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
