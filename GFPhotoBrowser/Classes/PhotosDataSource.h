//
//  PhotosDataSource.h
//  Photos
//
//  Created by 熊国锋 on 2016/11/3.
//  Copyright © 2016年 guofengld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoSectionInfo : NSObject

@property (nonatomic, readonly) NSString    *key;
@property (nonatomic, readonly) NSString    *title;

@property (nonatomic, assign)   PHAssetCollectionType       type;
@property (nonatomic, assign)   PHAssetCollectionSubtype    subType;

@property (nonatomic, readonly) NSInteger   numberOfObjects;
@property (nonatomic, strong)   NSArray     *objects;

- (instancetype)initWithKey:(NSString *)key title:(NSString *)title;

@end

@protocol PhotosDataDelegate <NSObject>

@optional
- (void)dataInitWillBegin;
- (void)dataInitDidFinish;

@end

@interface PhotosDataSource : NSObject

@property (nonatomic, weak) id <PhotosDataDelegate>   delegate;

- (instancetype)initWithType:(PHAssetCollectionType)type;
- (instancetype)initWithType:(PHAssetCollectionType)type
                     subType:(PHAssetCollectionSubtype)subType;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;

- (PHAsset *)objectAtIndexPath:(NSIndexPath *)indexPath;
- (PhotoSectionInfo *)sectionInfoForSection:(NSInteger)section;

- (NSArray <PHAsset *> *)fetchedObjects;
- (PHAsset *)nextObjectWithOptions:(NSEnumerationOptions)opt forObj:(PHAsset *)asset;

@end

NS_ASSUME_NONNULL_END
