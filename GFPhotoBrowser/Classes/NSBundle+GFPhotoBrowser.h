//
//  NSBundle+GFPhotoBrowser.h
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/4.
//  Copyright © 2016年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GFPhotoBrowser)

+ (UIImage *)bundleImageNamed:(NSString *)name;

@end

@interface NSBundle (GFPhotoBrowser)

+ (instancetype)GFBundle;

- (NSString *)GFBundleStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName;

@end

#define GFLocalizedString(key, comment) \
    [[NSBundle GFBundle] GFBundleStringForKey:(key) value:(key) table:@"Localizable"]
