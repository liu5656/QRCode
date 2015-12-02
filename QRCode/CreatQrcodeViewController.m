//
//  CreatQrcodeViewController.m
//  QRCode
//
//  Created by lj on 15/12/2.
//  Copyright © 2015年 lj. All rights reserved.
//

#import "CreatQrcodeViewController.h"
#import "QRCodeGenerator.h"
@interface CreatQrcodeViewController ()

@property (nonatomic, strong) UIImageView *qrImageView;

@end

@implementation CreatQrcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.qrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    self.qrImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.qrImageView];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.qrImageView.image = [QRCodeGenerator qrImageForString:@"二维码存储的字符串信息 asddsdd" imageSize:self.qrImageView.bounds.size.width];
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
