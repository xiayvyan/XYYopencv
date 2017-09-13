//
//  WatermarkViewController.m
//  XYYopencv
//
//  Created by 摇果 on 2017/9/1.
//  Copyright © 2017年 摇果. All rights reserved.
//

#import "WatermarkViewController.h"
#import <opencv2/imgcodecs/ios.h>

@interface WatermarkViewController ()
{
    IplImage *_img;
    BOOL _isHidden;
}
@property (nonatomic, strong) UIImageView *smallImageView;

@end

@implementation WatermarkViewController
#pragma mark - 导航栏的显隐
- (void)isHidden {
    _isHidden = !_isHidden;
    [self.navigationController setNavigationBarHidden:_isHidden animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenHeight, ScreenWidth)];
    _smallImageView.center = CGPointMake(ScreenWidth/2.0, ScreenHeight/2.0);
    [self.view addSubview:_smallImageView];
    _smallImageView.transform = CGAffineTransformMakeRotation(90 *M_PI / 180.0);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"wizard" ofType:@"jpg"];
    cv::String str = cv::String(path.UTF8String);
    cv::Mat image = cv::imread(str);
    if (!image.data) {
        NSLog(@"你妹，读取wizard错误~！ ");
    }
    NSString *logoPath = [[NSBundle mainBundle] pathForResource:@"water" ofType:@"jpg"];
    cv::String logoStr = cv::String(logoPath.UTF8String);
    cv::Mat logo = cv::imread(logoStr);
    cv::Mat mask = cv::imread(logoStr,0);
    if (!logo.data) {
        NSLog(@"你妹，读取water错误~！ ");
    }
    cv::Mat imageRoi = image(cv::Rect(image.cols-logo.cols,0,logo.cols,logo.rows));
/*
//透明度
    cv::addWeighted(imageRoi, 1.0, logo, 1.0, 0, imageRoi);
 */
    logo.copyTo(imageRoi, mask);
    cvtColor(image,image,CV_BGR2RGB);
    UIImage *img = MatToUIImage(image);
    _smallImageView.image = img;
    
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(30, ScreenHeight - 70, 50, 25)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
    saveButton.layer.cornerRadius = 5;
    saveButton.clipsToBounds = YES;
    [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isHidden)];
    [self.view addGestureRecognizer:tap];
}

- (void)saveImage {
    
     UIImageWriteToSavedPhotosAlbum(_smallImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"---------error :%@-------------", error);
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
