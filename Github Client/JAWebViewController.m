//
//  JAWebViewController.m
//  Github Client
//
//  Created by Jeffrey Adler on 3/18/16.
//  Copyright © 2016 Jadler. All rights reserved.
//

#import "JAWebViewController.h"

@interface JAWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation JAWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    }
}

@end
