//
//  ScanningViewController.m
//  funnyplay
//
//  Created by cash on 15-9-22.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "ScanningViewController.h"
#import "Tool.h"

#import <AVFoundation/AVFoundation.h>
#import <MBProgressHUD.h>

@interface ScanningViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, copy) NSString *webURL;

@end

@implementation ScanningViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"扫一扫";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonClicked)];
    
    [self setUpCamera];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setScanRegion];
    [_session startRunning];
}

- (void)cancelButtonClicked
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)setUpCamera
{
    _device  = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error;
    _input   = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    
    if (!_input) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    
    _output  = [AVCaptureMetadataOutput new];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _session = [AVCaptureSession new];
    [_session addInput:_input];
    [_session addOutput:_output];
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    [_preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_preview setFrame:self.view.layer.bounds];
    [self.view.layer addSublayer:_preview];
}

- (void)setScanRegion
{
    UIImageView *overlayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlaygraphic.png"]];
    overlayImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:overlayImageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view        attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual
                                                             toItem:overlayImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view        attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual
                                                             toItem:overlayImageView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth  = [UIScreen mainScreen].bounds.size.width;
    
    _output.rectOfInterest = CGRectMake((screenHeight - 200) / 2 / screenHeight,
                                        (screenWidth  - 260) / 2 / screenWidth,
                                        200 / screenHeight,
                                        260 / screenWidth);
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *message;
    
    if (metadataObjects.count > 0) {
        [_session stopRunning];
        
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
        
        message = metadataObject.stringValue;
        
        if ([message rangeOfString:@"scan_login"].location != NSNotFound) {
//            [self loginInWithURL:message];
        } else if ([message hasPrefix:@"{"]) {
//            [self signInWithJson:message];
        } else if ([Tool isURL:message]) {
//            [Utils analysis:message andNavController:self.navigationController];
        } else {
            MBProgressHUD *HUD = [Tool createHUD:message];
            HUD.mode = MBProgressHUDModeText;
            
            [HUD addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:HUD action:@selector(hide:)]];
            [HUD hide:YES afterDelay:2];
            
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
