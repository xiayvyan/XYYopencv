//
//  ViewController.m
//  XYYopencv
//
//  Created by 摇果 on 2017/9/1.
//  Copyright © 2017年 摇果. All rights reserved.
//

#import "ViewController.h"
#import "LunkuoViewController.h"
#import "Lunkuo1ViewController.h"
#import "LocalImageViewController.h"
#import "WatermarkViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *types;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Types";
    for (int i = 0; i < self.types.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(100, 100+i*50, 150, 35);
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:self.types[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)btnAction:(UIButton *)btn {
    
    NSInteger tag = [btn tag];
    switch (tag) {
        case 0: {
            LunkuoViewController *vc = [[LunkuoViewController alloc] init];
            vc.title = self.types[tag];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1: {
            Lunkuo1ViewController *vc = [[Lunkuo1ViewController alloc] init];
            vc.title = self.types[tag];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2: {
            LocalImageViewController *vc = [[LocalImageViewController alloc] init];
            vc.title = self.types[tag];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3: {
            WatermarkViewController *vc = [[WatermarkViewController alloc] init];
            vc.title = self.types[tag];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
    
    
}

- (NSMutableArray *)types {
    if (!_types) {
        _types = [NSMutableArray arrayWithObjects:@"轮廓0", @"轮廓1",@"本地图片",@"水印", nil];
    }
    return _types;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
