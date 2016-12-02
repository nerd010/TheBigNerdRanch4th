//
//  BNRItemStore.h
//  BNRHomepwner
//
//  Created by Richard Wang on 2016/12/1.
//  Copyright © 2016年 Richard Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (BNRItem *)createItem;

@end
