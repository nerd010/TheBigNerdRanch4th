//
//  BNRWebViewController.m
//  Nerdfeed
//
//  Created by Richard Wang on 28/12/2016.
//  Copyright © 2016 Richard Wang. All rights reserved.
//

#import "BNRWebViewController.h"

@implementation BNRWebViewController

- (void)loadView
{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    self.view = webView;
}

- (void)setURL:(NSURL *)URL
{
    _URL = URL;
    if (_URL)
    {
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:_URL];
        [(UIWebView *)self.view loadRequest: req];
    }
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = @"Courses";
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    //移除 navigationItem 的左侧按钮
    if (barButtonItem == self.navigationItem.leftBarButtonItem)
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

@end
