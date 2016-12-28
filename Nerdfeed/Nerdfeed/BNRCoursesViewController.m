//
//  BNRCoursesViewController.m
//  Nerdfeed
//
//  Created by Richard Wang on 28/12/2016.
//  Copyright © 2016 Richard Wang. All rights reserved.
//

#import "BNRCoursesViewController.h"
#import "BNRWebViewController.h"

@interface BNRCoursesViewController ()

@property (nonatomic) NSURLSession *session;
@property (nonatomic, strong) NSArray *courses;

@end

@implementation BNRCoursesViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.navigationItem.title = @"BNR Courses";
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
        
        [self fetchFeed];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)fetchFeed
{
    NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req
                                                     completionHandler:
                                      ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                          if (error)
                                          {
                                              NSLog(@"ERROE:%@", error.localizedDescription);
                                              return;
                                          }
                                          
                                          NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          self.courses = jsonObject[@"courses"];
                                          NSLog(@"self.courses:%@", self.courses);
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self.tableView reloadData];
                                          });
                                      }];
    [dataTask resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    NSDictionary *course = self.courses[indexPath.row];
    cell.textLabel.text = course[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *course = self.courses[indexPath.row];
    NSURL *URL = [NSURL URLWithString:course[@"url"]];
    
    self.webViewController.title = course[@"title"];
    self.webViewController.URL = URL;
    [self.navigationController pushViewController:self.webViewController animated:YES];
}

@end
