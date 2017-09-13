//
//  LunkuoViewController.m
//  XYYopencv
//
//  Created by 摇果 on 2017/9/1.
//  Copyright © 2017年 摇果. All rights reserved.
//

#import "LunkuoViewController.h"
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/imgcodecs/ios.h>
//#include<opencv2/highgui/highgui.hpp>
//#import <opencv2/core/core_c.h>

@interface LunkuoViewController ()<CvVideoCameraDelegate>
{
    cv::Mat _check;
    cv::Mat canny_output;
    BOOL _isHidden;
}
@property (nonatomic, assign) int space;
@property (nonatomic, assign) int h;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CvVideoCamera *videoCamera;

@end

@implementation LunkuoViewController
#pragma mark - 导航栏的显隐
- (void)isHidden {
    _isHidden = !_isHidden;
    [self.navigationController setNavigationBarHidden:_isHidden animated:YES];
}

- (void)start {
    [self.videoCamera start];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:self.imageView];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset1280x720;
    self.videoCamera.defaultFPS = 30;
    [self.view addSubview:self.imageView];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(135, 510, 50, 50)];
    [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"start" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isHidden)];
    [self.view addGestureRecognizer:tap];
}

- (void)processImage:(cv::Mat &)image {
    
    if (_space < 1280-_h) {
        
        if (_h < 350) {
            _space = _space+10;
            _h = _h+10;
        }else{
            _space = _space+20;
            _h = 350;
        }
    }else{
        _h = 0;
        _space = 0;
    }
    int h = int(image.size().height);
    int w = (_h+_space)>350?350:(_h+_space);
    int x = int(image.size().width-_space-_h);
    int y = int(0);
    _check = image(cv::Rect(x,y,w,h));
    if (w == 0) {
        return;
    }
    //图像处理
    cvtColor(_check,canny_output,CV_BGR2GRAY,3);//将图像转化为灰度图
    //    GaussianBlur(canny_output,canny_output,cv::Size(3,3),0,0); //高斯模糊
    blur(canny_output, canny_output,cv::Size(3,3));
    Canny(canny_output, canny_output, 80, 255);
   
    //轮廓拣选
    _check.setTo(cv::Scalar(0,255,0,0),canny_output);

    cvtColor(image,image,CV_BGR2RGB);//将B,G,R -->  R,G,B
    cv::Mat imageROI = image(cv::Rect(x,y,w,h));
    cv::Mat ROI(w,h,CV_8UC4);
    cvtColor(imageROI, ROI,CV_RGB2BGR);
    ROI.setTo(cv::Scalar(0,255,0,0));
    cv::addWeighted(imageROI, 0.9, ROI, 0.1, 0.0, imageROI);
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
