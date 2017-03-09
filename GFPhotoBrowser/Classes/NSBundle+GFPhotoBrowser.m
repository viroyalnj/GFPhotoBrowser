//
//  NSBundle+GFPhotoBrowser.m
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/4.
//
//

#import "NSBundle+GFPhotoBrowser.h"

@implementation UIImage (GFPhotoBrowser)

+ (UIImage *)bundleImageNamed:(NSString *)name {
    NSBundle *bundle = [NSBundle GFBundle];
    
    NSString *string = [NSString stringWithFormat:@"@%.0fx", [UIScreen mainScreen].scale];
    NSArray *end = @[string, @"@3x", @"@2x"];
    
    NSString *fileName, *filePath;
    for (NSString *item in end) {
        fileName = [name stringByAppendingString:item];
        filePath = [bundle pathForResource:fileName ofType:@"png"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            break;
        }
    }
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

@end

@implementation NSBundle (GFPhotoBrowser)

+ (instancetype)GFBundle {
    static dispatch_once_t onceToken;
    static NSBundle *bundle;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"GFPhotoBrowser" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:path];
    });
    
    return bundle;
}

- (instancetype)localizedStringBundle {
    static dispatch_once_t onceToken;
    static NSBundle *stringBundle;
    dispatch_once(&onceToken, ^{
        NSBundle *bundle = [NSBundle GFBundle];
        NSString *resource;
        NSString *local = [[NSLocale preferredLanguages] firstObject];
        if ([local containsString:@"zh"]) {
            if ([local containsString:@"Hans"]) {
                resource = @"zh-Hans";
            }
            else {
                resource = @"zh-Hant";
            }
        }
        else {
            resource = @"en";
        }
        
        stringBundle = [NSBundle bundleWithPath:[bundle pathForResource:resource ofType:@"lproj"]];
    });
    
    return stringBundle;
}

- (NSString *)GFBundleStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    return [[self localizedStringBundle] localizedStringForKey:key value:value table:tableName];
}

@end
