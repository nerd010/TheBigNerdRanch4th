//
//  main.m
//  Randomitems
//
//  Created by Richard Wang on 21/11/2016.
//  Copyright © 2016 Richard Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"
#import "BNRContainer.h"
                                                                       
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *items = [[NSMutableArray alloc] init];
//        for (NSString *item in items)
//        {
//            NSLog(@"%@", item);
//        }
        
//        BNRItem *item = [[BNRItem alloc] init];
//        [item setItemName:@"Red Sofa"];
//        [item setSerialNumber:@"A1B2C"];
//        [item setValueInDollars:100];
//        item.itemName = @"Red Sofa";
//        item.serialNumber = @"A1B2C";
//        item.valueInDollars = 100;
        
//        NSLog(@"%@ %@ %@ %d", [item itemName], [item dateCreated], [item serialNumber], [item valueInDollars]);
        //程序会先调用相应实参的description方法，
        //然后用返回的字符串替换%@
//        NSLog(@"%@", item);

//        for (int i = 0; i < 10; i++)
//        {
//            BNRItem *item = [BNRItem randomItem];
//            [items addObject:item];
//        }
//        

//        BNRContainer *container = [BNRContainer randomItem];
//        [container.subitems addObject:container];
        BNRItem *backpack = [[BNRItem alloc] initWithItemName:@"Backpack"];
        [items addObject:backpack];
        BNRItem *calculator = [[BNRItem alloc] initWithItemName:@"Calculator"];
        [items addObject:calculator];
        
        backpack.containedItem = calculator;
//        calculator.containedItem = backpack;
        backpack = nil;
        calculator = nil;

        for (int i = 0; i < items.count; i++)
        {
            NSLog(@"item[%d]:%@", i, items[i]);
        }
        
        NSLog(@"Setting items to nil...");
        items = nil;
    }
    return 0;
}
