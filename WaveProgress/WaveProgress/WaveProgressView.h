//
//  WaveProgressView.h
//  WaveProgress
//
//  Created by ZILIANG HA on 2018/12/12.
//  Copyright © 2018 Wang Na. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface WaveProgressView : UIView
/*
 * 进度 0~1
 */
@property (nonatomic, assign) CGFloat progress;
/*
 * 文字颜色
 */
@property (nonatomic, strong) UIColor *textColor;
/*
 * 文字字体
 */
@property (nonatomic, strong) UIFont *textFont;
/**
 前层波浪颜色
 */
@property (nonatomic ,strong) UIColor *frontWaveColor;
/**
 后层波浪颜色
 */
@property (nonatomic ,strong) UIColor *backWaveColor;
/**
 波浪背景色
 */
@property (nonatomic ,strong) UIColor *waveBackgroundColor;
/**
 开始
 */
- (void)start;
/**
 停止
 */
- (void)stop;


@end


