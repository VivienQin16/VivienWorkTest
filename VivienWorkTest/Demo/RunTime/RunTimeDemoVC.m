//
//  RunTimeDemoVC.m
//  VivienWorkTest
//
//  Created by Vivien on 16/11/4.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "RunTimeDemoVC.h"
#import <objc/runtime.h>
#import "VivienConfig.h"
@interface RunTimeDemoVC ()

@end

@implementation RunTimeDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@", NSStringFromClass([self class]));
    NSLog(@"%@", NSStringFromClass([self superclass]));
    
    NSLog(@"%s",class_getName([self class]));
    NSLog(@"%@",NSStringFromClass(class_getSuperclass([self class])));
    
    BOOL boolValue =  class_isMetaClass([NSObject class]);

    NSLog(@"%d",boolValue);
    
    
   size_t instanceSize =  class_getInstanceSize(objc_getClass("RunTimeDemo"));
    
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    BOOL res3 = [(id)[RunTimeDemoVC class] isKindOfClass:[RunTimeDemoVC class]];
    BOOL res4 = [(id)[RunTimeDemoVC class] isMemberOfClass:[RunTimeDemoVC class]];
    
    
     NSLog(@"%d,%d,%d,%d",res1,res2,res3,res4);
    //[self createRunTimeClass];
    
    NSLog(@"kScreenHeight:%f,kScreenWidth:%f",kScreenHeight,kScreenWidth);
    
    double ppi = sqrt(kScreenWidth*kScreenWidth +kScreenHeight*kScreenHeight);
    
    NSLog(@"ppi:%f",ppi/4.7);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 自定义一个方法
void reportFunction (id self, SEL _cmd) {
    NSLog(@"This object is %p", self);
}
/*
- (void)createRunTimeClass
{
    // 1.动态创建对象 创建一个Person 继承自 NSObject类
    Class newClass = objc_allocateClassPair([NSObject class], "Person", 0);
    // 为该类增加名为Report的方法
    class_addMethod(newClass, @selector(report), (IMP)reportFunction, @"v@:");
    // 注册该类
    objc_registerClassPair(newClass);
    // 创建一个 Student 类的实例
   id instantOfNewClass = [[newClass alloc] init];
    // 调用方法
    [instantOfNewClass report];
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
