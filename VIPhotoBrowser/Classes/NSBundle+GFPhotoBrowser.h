//
//  NSBundle+GFPhotoBrowser.h
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/4.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GFPhotoBrowser)

+ (UIImage *)photoBrowserImageNamed:(NSString *)name;

@end

@interface NSBundle (GFPhotoBrowser)

+ (instancetype)photoBrowserBundle;

- (NSString *)photoBrowserStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName;

@end

#define GFLocalizedString(key, comment) \
    [[NSBundle photoBrowserBundle] photoBrowserStringForKey:(key) value:(key) table:@"Localizable"]
