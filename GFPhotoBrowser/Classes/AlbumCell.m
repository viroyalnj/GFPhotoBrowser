//
//  AlbumCell.m
//  Pods
//
//  Created by 熊国锋 on 2016/11/4.
//
//

#import "AlbumCell.h"

@interface AlbumCell ()

@property (nonatomic, strong)   UIImageView         *iconView;
@property (nonatomic, strong)   UILabel             *labelView;

@end

@implementation AlbumCell

+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSInteger padding = 1;
        
        self.iconView = [[UIImageView alloc] init];
        self.iconView.contentMode = UIViewContentModeScaleAspectFill;
        self.iconView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.iconView];
        
        self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.contentView
                                                                   attribute:NSLayoutAttributeLeft
                                                                  multiplier:1.0
                                                                    constant:padding]];
        
        [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.contentView
                                                                   attribute:NSLayoutAttributeTop
                                                                  multiplier:1.0
                                                                    constant:padding]];
        
        [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.contentView
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0
                                                                    constant:padding]];
        
        [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.imageView
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:1.0
                                                                    constant:0]];
    }
    
    return self;
}

- (void)setSectionInfo:(PhotoSectionInfo *)sectionInfo {
    self.labelView.text = sectionInfo.title;
    
    PHAsset *asset = [sectionInfo.objects firstObject];
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:CGSizeMake(128, 128)
                                              contentMode:PHImageContentModeDefault
                                                  options:nil
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                self.iconView.image = result;
                                            }];
}


@end
