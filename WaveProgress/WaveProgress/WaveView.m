//
//  WaveView.m
//  WaveProgress
//
//  Created by ZILIANG HA on 2018/12/7.
//  Copyright © 2018 Wang Na. All rights reserved.
//
/**
 正弦曲线公式：y=Asin(ωx+φ)+k
 A:振幅，最高和最低的距离
 ω:角速度，用于控制周期大小，单位x中的起伏个数
 k:偏距，曲线整体上下偏移量
 φ:初相，左右移动的值
 
 这个效果主要的思路是：
 添加两条曲线，一条正弦曲线，一条余弦曲线，然后在曲线下添加深浅不同的背景颜色，从而达到波浪显示的效果。
 通过改变初相，从而可以获取X轴方向不同位置的波浪曲线(然后获取这些波浪曲线上的所有点), 这一个时间内一次显示这些曲线，那么波浪就动起来了
 */
#import "WaveView.h"
@interface WaveView ()
//后面的波浪
@property (nonatomic, strong) CAShapeLayer *backWaveLayer;
//前面的波浪
@property (nonatomic, strong) CAShapeLayer *frontWaveLayer;
//定时刷新器
@property (nonatomic, strong) CADisplayLink *disPlayLink;
/* 曲线的振幅*/
@property (nonatomic, assign) CGFloat waveAmplitude;
/* 曲线的角速度*/
@property (nonatomic, assign) CGFloat wavePalstance;
/* 曲线的初相*/
@property (nonatomic, assign) CGFloat waveX;
/* 曲线的偏距*/
@property (nonatomic, assign) CGFloat waveY;
/* 曲线的移动速度*/
@property (nonatomic, assign) CGFloat waveMoveSpeed;
@end
@implementation WaveView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
        [self configWave];
    }
    return self;
}
-(void)buildUI
{
    //初始化波浪
    //底层
    _backWaveLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_backWaveLayer];
    //上层
    _frontWaveLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_frontWaveLayer];
    //画个圆
    self.layer.cornerRadius = self.bounds.size.width/2.0f;
    self.layer.masksToBounds = true;
}
//初始化数据
-(void)configWave
{
    //振幅
    _waveAmplitude = 10;
    //角速度(可以看出周期T=2W)
    _wavePalstance = M_PI/ self.bounds.size.width;
    //偏距
    _waveY = self.bounds.size.height;
    //初相
    _waveX = 0;
    //x轴的移动速度
    _waveMoveSpeed = _wavePalstance *5;
}
-(void)updateWave:(CADisplayLink *)link
{
    //改变初相
    /** 通过改变初相，从而可以获取X轴方向不同位置的波浪曲线(然后获取这些波浪曲线上的所有点), 这一个时间内一次显示这些曲线，那么波浪就动起来了*/
    _waveX += _waveMoveSpeed;
    //绘画完整的波浪曲线
    [self updateWave1];
    [self updateWave2];
}
-(void)updateWave1
{
    //1、初始化运动路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 2;
    //2、设置初始位置
    //此点是波浪曲线的开始点
    CGPoint beginP = CGPointMake(0, _waveY);
    //设置波浪的起始位置
    [path moveToPoint:beginP];
    //3、添加波浪上的所有点
    //波浪图的宽、高
    CGFloat waterWaveViewWidth = self.bounds.size.width;
    CGFloat waterWaveViewHeight = self.bounds.size.height;
    //确定波浪的偏距
    //确定波浪的偏距(注意这里需要去掉波浪本身的高度)
    _waveY = waterWaveViewHeight - _progress * waterWaveViewHeight + _waveAmplitude;
    //获取波浪上的所有点
    for (float x = 0.0f ; x< waterWaveViewWidth; x++) {
        CGFloat y = _waveAmplitude * cos(_wavePalstance *x + _waveX) + _waveY;
        //把曲线上的所有点添加到path上
        [path addLineToPoint:CGPointMake(x, y)];
    }
    //4、添加填充部分中的点
    [path addLineToPoint:CGPointMake(waterWaveViewWidth, _waveY)];
    [path addLineToPoint:CGPointMake(waterWaveViewWidth, waterWaveViewHeight)];
    [path addLineToPoint:CGPointMake(0, waterWaveViewHeight)];
    [path addLineToPoint:CGPointMake(0, _waveY)];
    //5、把path添加到
    _backWaveLayer.path = path.CGPath;
}
-(void)updateWave2
{
    //1、初始化运动路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 2;
    //2、设置初始位置
    //此点是波浪曲线的开始点
    CGPoint beginP = CGPointMake(0, _waveY);
    //设置波浪的起始位置
    [path moveToPoint:beginP];
    //3、添加波浪上的所有点
    //波浪图的宽、高
    CGFloat waterWaveViewWidth = self.bounds.size.width;
    CGFloat waterWaveViewHeight = self.bounds.size.height;
    //确定波浪的偏距(注意这里需要去掉波浪本身的高度)
    _waveY = waterWaveViewHeight - _progress * waterWaveViewHeight + _waveAmplitude;
    //获取波浪上的所有点
    for (float x = 0.0f ; x< waterWaveViewWidth; x++) {
        CGFloat y = _waveAmplitude * sin(_wavePalstance *x + _waveX) + _waveY;
        //把曲线上的所有点添加到path上
        [path addLineToPoint:CGPointMake(x, y)];
    }
    //4、添加填充部分中的点
    [path addLineToPoint:CGPointMake(waterWaveViewWidth, _waveY)];
    [path addLineToPoint:CGPointMake(waterWaveViewWidth, waterWaveViewHeight)];
    [path addLineToPoint:CGPointMake(0, waterWaveViewHeight)];
    [path addLineToPoint:CGPointMake(0, _waveY)];
    //5、把path添加到
    _frontWaveLayer.path = path.CGPath;
}

#pragma mark - setter
-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
}
-(void)setWaveBackgroundColor:(UIColor *)waveBackgroundColor
{
    self.backgroundColor = waveBackgroundColor;
}
-(void)setBackWaveColor:(UIColor *)backWaveColor
{
    _backWaveLayer.fillColor = backWaveColor.CGColor;
    _backWaveLayer.strokeColor = backWaveColor.CGColor;
}
-(void)setFrontWaveColor:(UIColor *)frontWaveColor
{
    _frontWaveLayer.fillColor = frontWaveColor.CGColor;
    _frontWaveLayer.strokeColor = frontWaveColor.CGColor;
}
#pragma mark -
#pragma mark 功能方法
//开始
- (void)start {
    //以屏幕刷新速度为周期刷新曲线的位置
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
    [_disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
//停止
- (void)stop {
    if (_disPlayLink) {
        [_disPlayLink invalidate];
        _disPlayLink = nil;
    }
}
-(void)dealloc
{
    [self stop];
    if (_backWaveLayer) {
        [_backWaveLayer removeFromSuperlayer];
        _backWaveLayer = nil;
    }
    if (_frontWaveLayer) {
        [_frontWaveLayer removeFromSuperlayer];
        _frontWaveLayer = nil;
    }
    
}

@end
