//
//  LocalImageViewController.m
//  XYYopencv
//
//  Created by 摇果 on 2017/9/1.
//  Copyright © 2017年 摇果. All rights reserved.
//

#import "LocalImageViewController.h"
#import <opencv2/imgcodecs/ios.h>

@interface LocalImageViewController ()
{
    cv::Mat _logoImage;
    cv::Mat _mask;
}
@property (nonatomic, strong) UIImageView *smallImageView;

@end

@implementation LocalImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
    _smallImageView.center = CGPointMake(ScreenWidth/2.0, ScreenHeight/2.0);
    [self.view addSubview:_smallImageView];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"jpg"];
    cv::String str = cv::String(path.UTF8String);
    _logoImage = cv::imread(str);
    if (!_logoImage.data) {
        NSLog(@"你妹，读取srcImage1错误~！ ");
    }
    cvtColor(_logoImage,_logoImage,CV_BGR2RGB);
    UIImage *image = MatToUIImage(_logoImage);
    _smallImageView.image = image;
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
