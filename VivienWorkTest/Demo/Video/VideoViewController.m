//
//  VideoViewController.m
//  VivienWorkTest
//
//  Created by Vivien on 2017/8/22.
//  Copyright © 2017年 Vivien. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()
{
    UIWebView *webView;
 
}

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    NSString *url = @"https://v.youku.com/v_show/id_XMjk0NTYwODQ4NA==.html?";
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    webView.scrollView.bounces = NO;
    [webView setMediaPlaybackRequiresUserAction:NO];
    
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
