//
//  GFPhotoBrowserViewController.m
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/4.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import "GFPhotoBrowserViewController.h"
#import "GFPhotoCell.h"
#import "GFPhotosDataSource.h"
#import "NSBundle+GFPhotoBrowser.h"

@interface GFPhotoBrowserViewController () < GFPhotosDataDelegate >

@property (nonatomic, assign) PHAssetCollectionType         type;
@property (nonatomic, assign) PHAssetCollectionSubtype      subType;
@property (nonatomic, assign) PHAssetMediaType              mediaType;

@property (nonatomic, strong) GFPhotosDataSource            *dataSource;

@property (nonatomic, strong) UIBarButtonItem               *cancelItem;
@property (nonatomic, strong) UIBarButtonItem               *doneItem;

@property (nonatomic, strong) NSMutableArray                *selectedAssets;

@end

@implementation GFPhotoBrowserViewController

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType
                   mediaType:(PHAssetMediaType)mediaType
     allowsMultipleSelection:(BOOL)allowsMultipleSelection {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.type = type;
        self.subType = subType;
        self.mediaType = mediaType;
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.allowsMultipleSelection = allowsMultipleSelection;
        
        [self.collectionView registerClass:[GFPhotoCell class]
                forCellWithReuseIdentifier:[GFPhotoCell cellIdentifier]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [[GFPhotosDataSource alloc] initWithType:self.type
                                                       subType:self.subType
                                                     mediaType:self.mediaType];
    
    self.dataSource.delegate = self;
    
    self.cancelItem = [[UIBarButtonItem alloc] initWithTitle:GFLocalizedString(@"Cancel", nil)
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(selectCancel)];
    
    self.doneItem = [[UIBarButtonItem alloc] initWithTitle:GFLocalizedString(@"Done", nil)
                                                     style:UIBarButtonItemStylePlain
                                                    target:self
                                                    action:@selector(selectDone)];
    
    self.navigationItem.rightBarButtonItem = self.cancelItem;
    self.selectedAssets = [NSMutableArray new];
}

- (void)selectCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectDone {
    [self.delegate browser:self selectAssets:self.selectedAssets.copy];
}

#pragma mark - GFPhotosDataDelegate

- (void)dataInitWillBegin {
    
}

- (void)dataInitDidFinish:(NSArray<PhotoSectionInfo *> *)sections {
    self.title = [[sections firstObject] title];
    
    [self.collectionView reloadData];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    if (count > 0) {
        NSIndexPath *last = [NSIndexPath indexPathForItem:count - 1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:last
                                    atScrollPosition:UICollectionViewScrollPositionBottom
                                            animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.dataSource numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GFPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GFPhotoCell cellIdentifier]
                                                                  forIndexPath:indexPath];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(GFPhotoCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.asset = [self.dataSource objectAtIndexPath:indexPath];
    cell.allowsMultipleSelection = self.collectionView.allowsMultipleSelection;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = MIN(CGRectGetWidth(collectionView.bounds), CGRectGetHeight(collectionView.bounds));
    return CGSizeMake(width / 4, width / 4);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = [self.dataSource objectAtIndexPath:indexPath];
    if (collectionView.allowsMultipleSelection) {
        [self.selectedAssets addObject:asset];
        
        [self selectionChanged];
    }
    else {
        [self.delegate browser:self selectAssets:@[asset]];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = [self.dataSource objectAtIndexPath:indexPath];
    [self.selectedAssets removeObject:asset];
    
    [self selectionChanged];
}

- (void)selectionChanged {
    NSArray *selected = [self.collectionView indexPathsForSelectedItems];
    if ([selected count]) {
        self.navigationItem.rightBarButtonItem = self.doneItem;
    }
    else {
        self.navigationItem.rightBarButtonItem = self.cancelItem;
    }
}

@end
