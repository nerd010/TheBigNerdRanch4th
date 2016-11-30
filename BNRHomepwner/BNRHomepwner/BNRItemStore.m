//
//  BNRItemStore.m
//  BNRHomepwner
//
//  Created by Richard Wang on 2016/12/1.
//  Copyright © 2016年 Richard Wang. All rights reserved.
//

#import "BNRItemStore.h"

@implementation BNRItemStore

+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore)
    {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    return self;
}

@end
