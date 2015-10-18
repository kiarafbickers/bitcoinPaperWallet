//
//  UIImage+Resizing.m
//  AirPrint
//
//  Created by Mac on 13/10/31.
//  Copyright (c) 2013年 KKBOX. All rights reserved.
//

#import "UIImage+Resizing.h"

@implementation UIImage (Resizing)

+ (UIImage *)imageFromImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0) {
            UIGraphicsBeginImageContextWithOptions(newSize, YES, 2.0);
        } else {
            UIGraphicsBeginImageContext(newSize);
        }
    } else {
        UIGraphicsBeginImageContext(newSize);
    }
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
