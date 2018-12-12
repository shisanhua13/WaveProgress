//
//  WaveView.h
//  WaveProgress
//
//  Created by ZILIANG HA on 2018/12/7.
//  Copyright © 2018 Wang Na. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface WaveView : UIView

/* 前层波浪颜色*/
@property (nonatomic ,strong) UIColor *frontWaveColor;
/* 后层波浪颜色*/
@property (nonatomic ,strong) UIColor *backWaveColor;
/* 波浪背景颜色*/
@property (nonatomic ,strong) UIColor *waveBackgroundColor;
/* 设置进度 0~1*/
@property (nonatomic, assign) CGFloat progress;
/**
 * 开始
 */
-(void)start;
/**
 * 停止
 */
-(void)stop;


@end

