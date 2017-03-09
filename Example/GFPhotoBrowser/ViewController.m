//
//  ViewController.m
//  GFPhotoBrowser
//
//  Created by guofengld on 11/04/2016.
//  Copyright (c) 2016 guofengld. All rights reserved.
//


#import "ViewController.h"
#import "GFPhotosDataSource.h"
#import "GFPhotoCell.h"
#import <Masonry/Masonry.h>

@interface ImageHeader : UICollectionReusableView

@property (nonatomic, copy) NSString        *title;
@property (nonatomic, copy) NSString        *detail;

+ (NSString *)cellIdentifier;

@property (nonatomic, strong)   UILabel     *titleLabel;
@property (nonatomic, strong)   UILabel     *detailLabel;

@end

@implementation ImageHeader

+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_leftMargin);
            make.top.equalTo(self.mas_topMargin);
            make.bottom.equalTo(self.mas_bottomMargin);
        }];
        
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(self.titleLabel.mas_right);
            make.right.equalTo(self.mas_rightMargin);
            make.top.equalTo(self.mas_topMargin);
            make.bottom.equalTo(self.mas_bottomMargin);
        }];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setDetail:(NSString *)detail {
    self.detailLabel.text = detail;
}

@end

#pragma mark - ViewController

@interface ViewController () < PhotosDataDelegate >

@property (nonatomic, assign) PHAssetCollectionType         type;
@property (nonatomic, strong) GFPhotosDataSource            *dataSource;

@end

@implementation ViewController

- (instancetype)initWithType:(PHAssetCollectionType)type {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.type = type;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        [self.collectionView registerClass:[GFPhotoCell class]
                forCellWithReuseIdentifier:[GFPhotoCell cellIdentifier]];
        
        [self.collectionView registerClass:[ImageHeader class]
                forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                       withReuseIdentifier:[ImageHeader cellIdentifier]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.type) {
        case PHAssetCollectionTypeAlbum:
            self.title = @"Album";
            break;
            
        case PHAssetCollectionTypeSmartAlbum:
            self.title = @"Smart Album";
            break;
            
        case PHAssetCollectionTypeMoment:
            self.title = @"Moment";
            break;
    }
    
    self.dataSource = [[GFPhotosDataSource alloc] initWithType:self.type];
    self.dataSource.delegate = self;
}

#pragma mark - PhotosDataDelegate

- (void)dataInitWillBegin {
    
}

- (void)dataInitDidFinish:(NSArray<PhotoSectionInfo *> *)sections {
    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.dataSource numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GFPhotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GFPhotoCell cellIdentifier]
                                                                 forIndexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    ImageHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                             withReuseIdentifier:[ImageHeader cellIdentifier]
                                                                    forIndexPath:indexPath];
    
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(GFPhotoCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.asset = [self.dataSource objectAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(ImageHeader *)view
        forElementKind:(NSString *)elementKind
           atIndexPath:(NSIndexPath *)indexPath {
    PhotoSectionInfo *info = [self.dataSource sectionInfoForSection:indexPath.section];
    view.title = info.title;
    view.detail = [NSString stringWithFormat:@"%ld", info.numberOfObjects];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = MIN(CGRectGetWidth(collectionView.bounds), CGRectGetHeight(collectionView.bounds));
    return CGSizeMake(width / 4, width / 4);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat width = CGRectGetWidth(collectionView.bounds);
    return CGSizeMake(width, 48);
}

@end
