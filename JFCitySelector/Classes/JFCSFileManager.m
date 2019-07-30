//
//  JFCSFileManager.m
//  jfcityselector
//
//  Created by zhifenx on 2019/7/30.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSFileManager.h"

// The best order for path scale search.
static NSArray *_NSBundlePreferredScales() {
    static NSArray *scales;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenScale = [UIScreen mainScreen].scale;
        if (screenScale <= 1) {
            scales = @[@1,@2,@3];
        } else if (screenScale <= 2) {
            scales = @[@2,@3,@1];
        } else {
            scales = @[@3,@2,@1];
        }
    });
    return scales;
}

// Add scale modifier to the file name (without path extension), from @"name" to @"name@2x".
static NSString *_NSStringByAppendingNameScale(NSString *string, CGFloat scale) {
    if (!string) return nil;
    if (fabs(scale - 1) <= __FLT_EPSILON__ || string.length == 0 || [string hasSuffix:@"/"]) return string.copy;
    return [string stringByAppendingFormat:@"@%@x", @(scale)];
}

@implementation JFCSFileManager

+ (NSBundle *)jFCitySelectorBundle {
    static NSBundle *imageBrowserBundle = nil;
    if (imageBrowserBundle == nil) {
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        NSString *path = [bundle pathForResource:@"JFCitySelector" ofType:@"bundle"];
        imageBrowserBundle = [NSBundle bundleWithPath:path];
    }
    return imageBrowserBundle;
}

+ (UIImage *)getImageWithName:(NSString *)name {
    //Imitate 'YYImage', but don't need to determine image type, they are all 'png'.
    NSString *res = name, *path = nil;
    CGFloat scale = 1;
    NSArray *scales = _NSBundlePreferredScales();
    for (int s = 0; s < scales.count; s++) {
        scale = ((NSNumber *)scales[s]).floatValue;
        NSString *scaledName = _NSStringByAppendingNameScale(res, scale);
        path = [[self jFCitySelectorBundle] pathForResource:scaledName ofType:@"png"];
        if (path) break;
    }
    if (!path.length) return nil;
    return [UIImage imageWithContentsOfFile:path];
}

@end
