//
//  UIImage+Resize.h
//  iDote
//
//  Created by Adriano Soares on 27/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)
+ (UIImage *)imageWithImage:(UIImage *)image
               scaledToSize:(CGSize)size;

+ (UIImage *)imageWithImage:(UIImage *)image
               scaledToSize:(CGSize)size
               cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)cropImageWithInfo:(NSDictionary *)info;
@end
