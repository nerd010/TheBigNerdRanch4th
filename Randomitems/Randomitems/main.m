//
//  main.m
//  Randomitems
//
//  Created by Richard Wang on 21/11/2016.
//  Copyright © 2016 Richard Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        [items addObject:@"One"];
        [items addObject:@"Two"];
        [items addObject:@"Three"];
        [items insertObject:@"Zero" atIndex:0];
        
        for (NSString *item in items)
        {
            NSLog(@"%@", item);
        }
        
        BNRItem *item = [[BNRItem alloc] init];
//        [item setItemName:@"Red Sofa"];
//        [item setSerialNumber:@"A1B2C"];
//        [item setValueInDollars:100];
        item.itemName = @"Red Sofa";
        item.serialNumber = @"A1B2C";
        item.valueInDollars = 100;
        
//        NSLog(@"%@ %@ %@ %d", [item itemName], [item dateCreated], [item serialNumber], [item valueInDollars]);
        //程序会先调用相应实参的description方法，
        //然后用返回的字符串替换%@
        NSLog(@"%@", item);
        
        items = nil;
    }
    return 0;
}
