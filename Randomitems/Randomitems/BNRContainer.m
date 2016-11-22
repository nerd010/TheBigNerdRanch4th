//
//  BNRContainer.m
//  Randomitems
//
//  Created by Richard Wang on 22/11/2016.
//  Copyright © 2016 Richard Wang. All rights reserved.
//

#import "BNRContainer.h"

@implementation BNRContainer

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber
{
//    self = [super init];
    if (self)
    {
        _itemName = name;
        _valueInDollars = value;
        _serialNumber = sNumber;
        _dateCreated = [[NSDate alloc] init];
        _subitems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _subitems = [[NSMutableArray alloc] init];
    }
    return self;
}
- (NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
                                   self.itemName,
                                   self.serialNumber,
                                   self.valueInDollars,
                                   self.dateCreated];
    
    return descriptionString;
}

@end
