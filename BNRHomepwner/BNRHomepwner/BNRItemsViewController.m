//
//  BNRItemsViewController.m
//  BNRHomepwner
//
//  Created by Richard Wang on 2016/11/30.
//  Copyright © 2016年 Richard Wang. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation BNRItemsViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        for (int i = 0; i < 5; i++) {
            [[BNRItemStore sharedStore] createItems];
        }
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    //self = [super initWithStyle:UITableViewStylePlain];
    return [self init];
}

- (UIView *)headerView
{
    if (!_headerView)
    {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return _headerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:_headerView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *items = [BNRItemStore sharedStore].allItems;
    return items.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    //最后一行显示 No more items!
    if (items.count == indexPath.row)
    {
        cell.textLabel.text = @"No more items!";
        return cell;
    }
    BNRItem *item = items[indexPath.row];
    cell.textLabel.text = item.description;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    //UITableView *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if (items.count == indexPath.row)
    {
        return 44;
    }
    return 60;
}

- (IBAction)addNewItem:(id)sender
{

}

- (IBAction)toggleEditingMode:(id)sender
{

}
@end
