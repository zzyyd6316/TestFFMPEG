//
//  ViewController.m
//  TestFFMPEG
//
//  Created by zzy on 2017/8/29.
//  Copyright © 2017年 zzy. All rights reserved.
//

#import "ViewController.h"
#import "KxMovieViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton*btn = [[UIButton alloc]initWithFrame:CGRectMake(138, 200, 100, 50)];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTitle:@"播放" forState:UIControlStateNormal];
    [btn setTitle:@"播放" forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(gotoPlayVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton*btn2 = [[UIButton alloc]initWithFrame:CGRectMake(138, 350, 100, 50)];
    [btn2 setBackgroundColor:[UIColor greenColor]];
    [btn2 setTitle:@"查看" forState:UIControlStateNormal];
    [btn2 setTitle:@"查看" forState:UIControlStateHighlighted];
    [btn2 addTarget:self action:@selector(look) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

-(void)look{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"foreman_p16x16" ofType:@"264"];
    NSData*data = [NSData dataWithContentsOfFile:path];
    NSLog(@"%@",data);
}

-(void)gotoPlayVC{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"x264_Overflow_Sample" ofType:@"mkv"];
//    NSString *path = @"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    // increase buffering for .wmv, it solves problem with delaying audio frames
    if ([path.pathExtension isEqualToString:@"wmv"])
    parameters[KxMovieParameterMinBufferedDuration] = @(5.0);
    // disable deinterlacing for iPhone, because it's complex operation can cause stuttering
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
    
    KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:path
                                                                               parameters:parameters];
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
