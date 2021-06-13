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

// CGDataProviderCreateWithData callback to free the pixel data buffer
void freePixelData(void *info, const void *data, size_t size) {
    free((void *)data);
}

- (UIImage *)getImageFromGrayScaleArray {
    
    int width = 2;
    int height = 2;
    
    // 1 byte for brightness, 1 byte for alpha
    int8_t data[] = {
        255, 122,
        122, 0,
    };
    
    int imageSizeInPixels = width * height;
    int bytesPerPixel = 2; // 1 byte for brightness, 1 byte for alpha
    unsigned char *pixels = (unsigned char *)malloc(imageSizeInPixels * bytesPerPixel);
    memset(pixels, 255, imageSizeInPixels * bytesPerPixel); // setting all alpha values to 255
  
    for (int i = 0; i < imageSizeInPixels; i++) {
         pixels[i * 2] = data[i]; // writing array of bytes as image brightnesses
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithData (NULL,
                                                               &pixels[0],
                                                               // size is width * height * bytesPerPixel
                                                               width * height * [self bytesPerPixel],
                                                               freePixelData);
    
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
