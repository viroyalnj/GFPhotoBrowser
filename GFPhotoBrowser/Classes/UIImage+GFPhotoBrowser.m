//
//  UIImage+Bundle.m
//  GFPhotoBrowser
//
//  Created by guofengld on 2016/11/4.
//
//

#import "UIImage+GFPhotoBrowser.h"

@implementation UIImage (GFPhotoBrowser)

+ (UIImage *)bundleImageNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GFPhotoBrowser" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    NSString *fileName = [NSString stringWithFormat:@"%@@%.0fx", name, [UIScreen mainScreen].scale];
    NSString *filePath = [bundle pathForResource:fileName ofType:@"png"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        fileName = name;
        filePath = [bundle pathForResource:fileName ofType:@"png"];
    }
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

@end
