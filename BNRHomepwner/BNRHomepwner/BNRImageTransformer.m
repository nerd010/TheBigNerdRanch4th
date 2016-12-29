//
//  BNRImageTransformer.m
//  BNRHomepwner
//
//  Created by Richard Wang on 28/12/2016.
//  Copyright © 2016 Richard Wang. All rights reserved.
//

#import "BNRImageTransformer.h"
#import <UIKit/UIKit.h>

@implementation BNRImageTransformer

+ (Class)transformedValueClass
{
    return [NSData class];
}

- (id)transformedValue:(id)value
{
    if (!value)
    {
        return nil;
    }
    if ([value isKindOfClass:[NSData class]])
    {
        return value;
    }
    return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedaValue:(id)value
{
    return [UIImage imageWithData:value];
}

@end
