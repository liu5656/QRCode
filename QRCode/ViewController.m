//
//  ViewController.m
//  QRCode
//
//  Created by lj on 15/12/1.
//  Copyright © 2015年 lj. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>//用于处理采集信息的代理
{
    AVCaptureSession * session;//输入输出的中间桥梁
}
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
//    output.rectOfInterest = CGRectMake((size.height - 220) * 0.5, (size.width - 220) * 0.5, 220 / size.height, 220 / size.width);
//    (124)/ScreenHigh,((ScreenWidth-220)/2)/ScreenWidth
    output.rectOfInterest = CGRectMake((124)/size.height,((size.width-220)/2)/size.width, 220 / size.height, 220 / size.width);
//    output.rectOfInterest = CGRectMake(0.5,0,0.5,0.5);
    
//    CGSize size = self.view.bounds.size;
//    CGRect cropRect = CGRectMake(50, 160, 220, 220);
//    CGFloat p1 = size.height/size.width;
//    CGFloat p2 = 640./480; //使用了640p的图像输出
//    if (p1 < p2) {
//        CGFloat fixHeight = self.view.bounds.size.width * 640. / 480.;
//        CGFloat fixPadding = (fixHeight - size.height)/2;
//        output.rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,
//                                            cropRect.origin.x/size.width,
//                                            cropRect.size.height/fixHeight,
//                                            cropRect.size.width/size.width);
//    } else {
//        CGFloat fixWidth = self.view.bounds.size.height * 480. / 640.;
//        CGFloat fixPadding = (fixWidth - size.width)/2;
//        output.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
//                                            (cropRect.origin.x + fixPadding)/fixWidth,
//                                            cropRect.size.height/size.height,
//                                            cropRect.size.width/fixWidth);
//    }
    

    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象.
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [session addInput:input];
    [session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((size.width - 220) * 0.5, 124,220,220)];
    imageview.image = [UIImage imageNamed:@"xxx.png"];
    imageview.layer.borderColor = [UIColor blackColor].CGColor;
    imageview.layer.borderWidth = 2;
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.alpha = 0.5;
    [self.view addSubview:imageview];
    
    //开始捕获
    [session startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        NSLog(@"%@",metadataObject.stringValue);
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
