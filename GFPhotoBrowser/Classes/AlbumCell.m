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
        UIView *superView = self.contentView;
        
        self.iconView = [[UIImageView alloc] init];
        self.iconView.contentMode = UIViewContentModeScaleAspectFill;
        self.iconView.layer.masksToBounds = YES;
        [superView addSubview:self.iconView];
        
        self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:padding]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:padding]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:-padding]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.iconView
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1.0
                                                               constant:0]];
        
        self.labelView = [[UILabel alloc] init];
        [superView addSubview:self.labelView];
        
        self.labelView.translatesAutoresizingMaskIntoConstraints = NO;
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelView
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.iconView
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0
                                                                      constant:4]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:padding]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:-padding]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelView
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:-padding]];
    }
    
    return self;
}

- (void)setSectionInfo:(PhotoSectionInfo *)sectionInfo {
    NSAttributedString *name = [[NSAttributedString alloc] initWithString:sectionInfo.title
                                                               attributes:@{ NSFontAttributeName : [UIFont boldSystemFontOfSize:16],
                                                                             NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    NSAttributedString *number = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" (%ld)", sectionInfo.numberOfObjects]
                                                                 attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:12],
                                                                               NSForegroundColorAttributeName : [UIColor darkTextColor]}];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:name];
    [string appendAttributedString:number];
    self.labelView.attributedText = string;
    
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
