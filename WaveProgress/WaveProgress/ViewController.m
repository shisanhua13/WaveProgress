//
//  ViewController.m
//  WaveProgress
//
//  Created by ZILIANG HA on 2018/12/7.
//  Copyright © 2018 Wang Na. All rights reserved.
//

#import "ViewController.h"
#import "WaveProgressView.h"
@interface ViewController ()
@property (nonatomic, strong) WaveProgressView *waveProgress;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _waveProgress = [[WaveProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _waveProgress.backWaveColor = [UIColor redColor];
    [self.view addSubview:_waveProgress];
    _waveProgress.center = self.view.center;
    _waveProgress.progress = 0.0f;
    //波浪背景颜色，深绿色
    _waveProgress.waveBackgroundColor = [UIColor colorWithRed:96/255.0f green:159/255.0f blue:150/255.0f alpha:1];
    //前层波浪颜色
    _waveProgress.backWaveColor = [UIColor colorWithRed:136/255.0f green:199/255.0f blue:190/255.0f alpha:1];
    //后层波浪颜色
    _waveProgress.frontWaveColor = [UIColor colorWithRed:28/255.0 green:203/255.0 blue:174/255.0 alpha:1];
    //字体
    _waveProgress.textFont = [UIFont boldSystemFontOfSize:50];
    //文字颜色
    _waveProgress.textColor = [UIColor whiteColor];
    
    //开始波浪
    [_waveProgress start];
    
    
    
    
    //滑竿
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(_waveProgress.frame)+50, self.view.bounds.size.width - 2*50, 30)];
    [self.view addSubview:slider];
    [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
    [slider setMaximumValue:1];
    [slider setMinimumValue:0];
    [slider setMinimumTrackTintColor:[UIColor colorWithRed:96/255.0f green:159/255.0f blue:150/255.0f alpha:1]];
}
-(void)sliderMethod:(UISlider*)slider
{
     _waveProgress.progress = slider.value;
}

@end
