//
//  AppDelegate.h
//  VivienWorkTest
//
//  Created by Vivien on 16/11/4.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
//已经用Storyboard加载导航了，所以这些代码可以不要了
@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic, retain) UINavigationController *navigationController;

/***  是否允许横屏的标记 */
@property (nonatomic,assign)BOOL allowRotation;  
@end

