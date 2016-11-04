//
//  PhotoBrowserViewController.m
//  Photos
//
//  Created by 熊国锋 on 2016/11/4.
//  Copyright © 2016年 guofengld. All rights reserved.
//

#import "PhotoBrowserViewController.h"
#import "PhotoCell.h"
#import "PhotosDataSource.h"

@interface PhotoBrowserViewController () < PhotosDataDelegate >

@property (nonatomic, assign) PHAssetCollectionType     type;
@property (nonatomic, assign) PHAssetCollectionSubtype  subType;
@property (nonatomic, strong) PhotosDataSource          *dataSource;

@end

@implementation PhotoBrowserViewController

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.type = type;
        self.subType = subType;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        [self.collectionView registerClass:[PhotoCell class]
                forCellWithReuseIdentifier:[PhotoCell cellIdentifier]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Photo browser";
    
    self.dataSource = [[PhotosDataSource alloc] initWithType:self.type
                                                     subType:self.subType];
    self.dataSource.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(closeView)];
}

- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PhotosDataDelegate

- (void)dataInitWillBegin {
    
}

- (void)dataInitDidFinish {
    [self.collectionView reloadData];
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
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PhotoCell cellIdentifier]
                                                                forIndexPath:indexPath];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(PhotoCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.asset = [self.dataSource objectAtIndexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = MIN(CGRectGetWidth(collectionView.bounds), CGRectGetHeight(collectionView.bounds));
    return CGSizeMake(width / 4, width / 4);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate browser:self selectItem:[self.dataSource objectAtIndexPath:indexPath]];
}

@end
