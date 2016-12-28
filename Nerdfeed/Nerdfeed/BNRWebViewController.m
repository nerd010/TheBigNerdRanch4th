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

@end
