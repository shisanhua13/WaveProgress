//
//  WaveProgressView.m
//  WaveProgress
//
//  Created by ZILIANG HA on 2018/12/12.
//  Copyright © 2018 Wang Na. All rights reserved.
//

#import "WaveProgressView.h"
#import "WaveView.h"
@interface WaveProgressView ()
@property (nonatomic, weak) WaveView *wave;
@property (nonatomic, weak) UILabel *textLabel;
@end
@implementation WaveProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildLayout];
    }
    return self;
}
-(void)buildLayout
{
    WaveView *wave = [[WaveView alloc] initWithFrame:self.bounds];
    [self addSubview:wave];
    self.wave = wave;
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    [self addSubview:textLabel];
    self.textLabel = textLabel;
    textLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark -
#pragma mark Setter
-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    _wave.progress = progress;
    _textLabel.text = [NSString stringWithFormat:@"%.0f%%", progress *100];
    
}
-(void)setTextFont:(UIFont *)textFont{
    _textLabel.font = textFont;
}
-(void)setTextColor:(UIColor *)textColor
{
    _textLabel.textColor = textColor;
}
-(void)setWaveBackgroundColor:(UIColor *)waveBackgroundColor
{
    _wave.waveBackgroundColor = waveBackgroundColor;
}
-(void)setBackWaveColor:(UIColor *)backWaveColor
{
    _wave.backWaveColor = backWaveColor;
}
-(void)setFrontWaveColor:(UIColor *)frontWaveColor
{
    _wave.frontWaveColor = frontWaveColor;
}
#pragma mark -
#pragma mark 功能方法
- (void)start {
    [_wave start];
}

- (void)stop {
    [_wave stop];
}

- (void)dealloc {
    [_wave stop];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end
