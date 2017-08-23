//
//  VideoEnterViewController.m
//  VivienWorkTest
//
//  Created by Vivien on 2017/8/22.
//  Copyright © 2017年 Vivien. All rights reserved.
//

#import "VideoEnterViewController.h"
#import "WKWebViewController.h"
@interface VideoEnterViewController ()
{
     UIButton  *enterBtn;
     UIButton  *wkEnterBtn;
}

@end

@implementation VideoEnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    enterBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 200, 40)];
    [enterBtn setTintColor:[UIColor cyanColor]];
    [enterBtn setTitle:@"进入视频界面" forState:UIControlStateNormal];
    enterBtn.backgroundColor = [UIColor redColor];
    [enterBtn addTarget:self action:@selector(enterVideoController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterBtn];
    
    wkEnterBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 200, 300, 40)];
    [wkEnterBtn setTintColor:[UIColor cyanColor]];
    [wkEnterBtn setTitle:@"进入WKWebView加载视频界面" forState:UIControlStateNormal];
    wkEnterBtn.backgroundColor = [UIColor redColor];
    [wkEnterBtn addTarget:self action:@selector(enterWkWebView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wkEnterBtn];

    
    
}

- (void)enterVideoController
{
    VideoViewController *videoVC = [[VideoViewController alloc]init];
    [self.navigationController pushViewController:videoVC animated:YES];
//    [self presentViewController:videoVC animated:YES completion:nil];
}

- (void)enterWkWebView
{
    WKWebViewController *videoVC = [[WKWebViewController alloc]init];
    [self.navigationController pushViewController:videoVC animated:YES];
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
