//
//  UIImageColor.m
//  iDote
//
//  Created by Camila Bressan Inácio on 25/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "UIImageTabBarColor.h"

@implementation UIImageTabBarColor


+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
