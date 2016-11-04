//
//  PhotosDataSource.m
//  Photos
//
//  Created by 熊国锋 on 2016/11/3.
//  Copyright © 2016年 guofengld. All rights reserved.
//

#import "PhotosDataSource.h"

@implementation PhotoSectionInfo

- (instancetype)initWithKey:(NSString *)key title:(NSString *)title {
    if (self = [super init]) {
        _key = [key copy];
        _title = [title copy];
    }
    
    return self;
}

- (NSInteger)numberOfObjects {
    return [self.objects count];
}

@end

#pragma mark - PhotosDataSource

@interface PhotosDataSource ()

@property (nonatomic, strong)   PHPhotoLibrary              *photoLibrary;

@property (nonatomic, strong)   NSMutableArray<PhotoSectionInfo *>   *sectionInfo;

@end

@implementation PhotosDataSource

- (instancetype)initWithType:(PHAssetCollectionType)type {
    return [self initWithType:type
                      subType:PHAssetCollectionSubtypeAny];
}

- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType {
    if (self = [super init]) {
        
        self.photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dataInitWillBegin];
                [self fetchDataType:type subType:subType];
                [self dataInitDidFinish];
            });
        }];
    }
    
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dataInitWillBegin];
                
                [self fetchDataType:PHAssetCollectionTypeSmartAlbum subType:PHAssetCollectionSubtypeAny];
                [self fetchDataType:PHAssetCollectionTypeAlbum subType:PHAssetCollectionSubtypeAny];
                
                [self dataInitDidFinish];
            });
        }];
    }
    
    return self;
}

- (void)dataInitWillBegin {
    [self.delegate dataInitWillBegin];
    
    self.sectionInfo = [NSMutableArray new];
}

- (void)dataInitDidFinish {
    [self.delegate dataInitDidFinish];
}

- (void)fetchDataType:(PHAssetCollectionType)type subType:(PHAssetCollectionSubtype)subType {
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.includeHiddenAssets = NO;
    
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:type
                                                                     subtype:subType
                                                                     options:options];
    for (PHAssetCollection *item in result) {
        PHFetchResult *assets = [PHAsset fetchAssetsInAssetCollection:item options:nil];
        NSMutableArray *arr = [NSMutableArray new];
        for (PHAsset *ass in assets) {
            [arr addObject:ass];
        }
        
        if ([arr count] == 0) {
            continue;
        }
        
        NSString *key = item.localIdentifier;
        NSString *title = item.localizedTitle;
        
        PhotoSectionInfo *info = [[PhotoSectionInfo alloc] initWithKey:key title:title];
        info.type = item.assetCollectionType;
        info.subType = item.assetCollectionSubtype;
        
        info.objects = [NSArray arrayWithArray:arr];
        [self.sectionInfo addObject:info];
    }
}

- (NSInteger)numberOfSections {
    if ([PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusAuthorized) {
        return 0;
    }
    
    return [self.sectionInfo count];
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    if ([PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusAuthorized) {
        return 0;
    }
    
    return [self.sectionInfo[section] numberOfObjects];
}

- (PHAsset *)objectAtIndexPath:(NSIndexPath *)indexPath {
    return self.sectionInfo[indexPath.section].objects[indexPath.row];
}

- (PhotoSectionInfo *)sectionInfoForSection:(NSInteger)section {
    return self.sectionInfo[section];
}

@end
