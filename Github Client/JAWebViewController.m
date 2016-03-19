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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
