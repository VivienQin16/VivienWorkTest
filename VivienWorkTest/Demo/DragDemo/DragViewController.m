//
//  DragViewController.m
//  VivienWorkTest
//
//  Created by Vivien on 2016/11/9.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "DragViewController.h"
#import "Masonry.h"
@interface DragViewController ()
{
    UIView *dragView;
    CGPoint videoViewPanPoint; //用于视频拖动时，记住初始点;
}
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation DragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    dragView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    dragView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:dragView];
    
    //创建手势
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(objectDidDragged:)];
    //限定操作的触点数
    [panGR setMaximumNumberOfTouches:1];
    [panGR setMinimumNumberOfTouches:1];
    //将手势添加到draggableObj里
    [dragView addGestureRecognizer:panGR];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.highlightedTextColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
    _titleLabel.numberOfLines = 1;
    _titleLabel.text = @"热热闹闹1冷冷清清2开开心心3sad哈哈哈哈哈哈哈哈哈哈";
    [self.view  addSubview:_titleLabel];
    
    [_titleLabel  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(self.view);
    }];
}

- (void)objectDidDragged:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        videoViewPanPoint = [sender locationInView:dragView];
        
        NSLog(@"panPoint:%@",NSStringFromCGPoint(videoViewPanPoint));
    }
    if (sender.state != UIGestureRecognizerStateEnded && sender.state != UIGestureRecognizerStateFailed){
        //通过使用 locationInView 这个方法,来获取到手势的坐标
        CGPoint location = [sender locationInView:sender.view.superview];
        [sender.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(100);
            make.width.mas_equalTo(100);
            make.left.mas_equalTo(location.x-videoViewPanPoint.x);
            make.top.mas_equalTo(location.y-videoViewPanPoint.y);
        }];
        
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
