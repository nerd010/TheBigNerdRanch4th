//
//  BNRItem.h
//  Randomitems
//
//  Created by Richard Wang on 21/11/2016.
//  Copyright © 2016 Richard Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic, assign) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;

@property (nonatomic, copy) NSString *itemKey;

+ (instancetype)randomItem;

// BNRItem 类的指定初始化方法
- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;
- (instancetype)initWithItemName:(NSString *)name
                    serialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name;

//- (void)setContainedItem:(BNRItem *)item;
//- (BNRItem *)containedItem;
//
//- (void)setContainer:(BNRItem *)item;
//- (BNRItem *)container;
//
//- (void)setItemName:(NSString *)str;
//- (NSString *)itemName;
//
//- (void)setSerialNumber:(NSString *)str;
//- (NSString *)serialNumber;
//
//- (void)setValueInDollars:(int)v;
//- (int)valueInDollars;

//- (NSDate *)dateCreated;

@end
