//
//  ViewController.m
//  VivienWorkTest
//
//  Created by Vivien on 16/11/4.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
{
    NSArray *titleArr;
    
    UITableView *table;
    
    NSMutableArray *demoPages;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"选择列表";
    titleArr = [[NSArray alloc]initWithObjects:@"RunTimeDemo",@"DraggDemo",@"加载网页视频",nil];
    demoPages = [[NSMutableArray alloc]initWithObjects:@"RunTimeDemoVC",@"DragViewController",@"VideoEnterViewController",nil];

    
    
    table = [[UITableView alloc]initWithFrame:self.view.bounds ];
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:table];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    NSString *vcString = demoPages[indexPath.row];
    Class vcClass = NSClassFromString(vcString);
    if (vcClass) {
        UIViewController *mainVC = [[vcClass alloc] init];
       [self.navigationController pushViewController:mainVC animated:YES];
    }
    return;
}


@end
