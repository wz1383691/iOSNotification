//
//  ViewController.m
//  testNotification
//
//  Created by james on 2017/4/26.
//  Copyright © 2017年 weizhong. All rights reserved.
//

#import "ViewController.h"
#import "WZNotificationCenter.h"
#import "WZNotification.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   NSLog(@"viewWillAppear");
}

- (void)viewDidLoad {
    [super viewDidLoad];
   NSLog(@"viewDidLoad");
    [[WZNotificationCenter defaultWZCenter] addObserver:self selector:@selector(add:) name:@"add" object:nil];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

- (IBAction)click:(id)sender {
    
    WZNotification *notification = [WZNotification notificationWithName:@"add" object:nil userInfo:nil];
    
    [[WZNotificationCenter defaultWZCenter]postNotification:notification];
    NSLog(@"点击");
}
-(void)add:(WZNotification*)notification{
   _textLabel.text=@"接收到了";
}

-(void)dealloc{
    [[WZNotificationCenter defaultWZCenter]removeObserver:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
