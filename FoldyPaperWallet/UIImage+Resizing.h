//
//  UIImage+Resizing.h
//  AirPrint
//
//  Created by Mac on 13/10/31.
//  Copyright (c) 2013年 KKBOX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resizing)

+ (UIImage *)imageFromImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
