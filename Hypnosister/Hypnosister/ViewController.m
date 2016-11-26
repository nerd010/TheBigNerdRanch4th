//
//  ViewController.m
//  Hypnosister
//
//  Created by Richard Wang on 22/11/2016.
//  Copyright © 2016 Richard Wang. All rights reserved.
//

#import "ViewController.h"
#import "BNRHypnosisView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenRect = CGRectMake(0, 0, WIDTH, HEIGHT);
    CGRect bigRect = screenRect;
    bigRect.size.width *= 2;
//    bigRect.size.height *= 2;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    scrollView.contentSize = bigRect.size;
    scrollView.pagingEnabled = YES;
//    BNRHypnosisView *firstView = [[BNRHypnosisView alloc] initWithFrame:bigRect];
//    [scrollView addSubview:firstView];
    BNRHypnosisView *hypnosisView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:hypnosisView];
    
    screenRect.origin.x += screenRect.size.width;
    BNRHypnosisView *anoterView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:anoterView];
    [self.view addSubview: scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
