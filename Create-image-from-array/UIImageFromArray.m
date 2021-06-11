//
//  UIImageFromArray.m
//  Create-image-from-array
//
//  Created by Ran Helfer on 08/06/2021.
//

#import "UIImageFromArray.h"

@interface UIImageFromArray ()
//@property (nonatomic) CGColorSpaceRef colorSpaceRef;
@end


@implementation UIImageFromArray

- (UIImage *)getImageFromGrayScaleArray {
    
    int width = 2;
    int height = 2;
    
    // 1 byte for brightness, 1 byte for alpha
    int8_t data[] = {
        0, 255,
        0, 255,
        0, 255,
        0, 255,
    };
    
    CGDataProviderRef provider = CGDataProviderCreateWithData (NULL,
                                                               &data[0],
                                                               // size is width * height * bytesPerPixel
                                                               width * height * [self bytesPerPixel],
                                                               NULL);
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    
    CGImageRef imageRef = CGImageCreate (width,
                                         height,
                                         [self bitsPerComponent],
                                         [self bitsPerPixel],
                                         width * [self bytesPerPixel],
                                         colorSpaceRef,
                                         // use this
                                         kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big,
                                         // instead of this
                                         //kCGBitmapByteOrderDefault,
                                         provider,
                                         NULL,
                                         NO,
                                         kCGRenderingIntentDefault);
    
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpaceRef);
    
    return image;
}


- (int)bitsPerPixel {
    return 8 * [self bytesPerPixel];;
}

- (int)bytesPerPixel {
    return [self bytesPerComponent] * [self componentsPerPixel];
}

- (int)componentsPerPixel {
    return 2;  // 1 byte for brightness, 1 byte for alpha
}

- (int)bytesPerComponent {
    return 1;
}

- (int)bitsPerComponent {
    return 8 * [self bytesPerComponent];
}

@end
