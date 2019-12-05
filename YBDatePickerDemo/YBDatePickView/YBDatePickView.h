//
//  YBDatePickView.h
//  edianzu
//
//  Created by 王迎博 on 2018/4/26.
//  Copyright © 2018年 edianzu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MyBlockType)(NSString *selectDate);
/**不设置为0的原因是，整型默认为0，不设置此值的话也会默认为限制当天了*/
#define YB_DATE_PICKER_STATIC_TODAY_END (-0xffff)


@interface YBDatePickView : UIView

/**
 距离当前显示日期最大年份差，值为整型（>=1小于当前日期，<=-1大于当前日期）。值为YB_DATE_PICKER_STATIC_TODAY_END 时截止日期为今天
 */
@property(assign, nonatomic) NSInteger maxYear; //优先级：*
/**距离当前显示日期的时间差，值为具体时间如：2019-06-18 */
@property (nonatomic, copy) NSString *maxDateString;    //优先级：**
@property (nonatomic, strong) NSDate *maximumDate;  //优先级：***
/** 距离当前日期最小年份差 */
@property(assign, nonatomic) NSInteger minYear; //优先级：*
@property (nonatomic, copy) NSString *minDateString;    //优先级：**
@property (nonatomic, strong) NSDate *minimumDate;  //优先级：***

/**只控制最小时间时分，不控制日期*/
@property (nonatomic, strong) NSDate *minTimeDate;
/**只控制最大时间时分，不控制日期*/
@property (nonatomic, strong) NSDate *maxTimeDate;

/** 最开始停留的位置，默认显示今天日期 */
@property (strong, nonatomic) NSDate *date;
/** 日期回调 */
@property(copy, nonatomic) MyBlockType completeBlock;
/** 设置确认/取消字体颜色(默认为黑色) */
@property (strong, nonatomic) UIColor *fontColor;
/**设置确认/取消字体*/
@property (nonatomic, strong) UIFont *titleFont;
/**整体pickerView高度，默认240.f*/
@property (nonatomic, assign) CGFloat pickerHeight;
/**头部的高度（取消和确定按钮的头部）*/
@property (nonatomic, assign) CGFloat headerBgHeight;
/**头部的背景颜色*/
@property (nonatomic, strong) UIColor *headerBgColor;
/**是否顶头显示*/
@property (nonatomic, assign, getter=isOnTop) BOOL onTop;
/**是否支持触摸消失*/
@property (nonatomic, assign) BOOL touchRemove;


/**
 配置默认为日期选择器
 */
- (void)configuration;

/**
 可设置选择器UIDatePickerMode

 @param pickerMode pickerMode description
 */
- (void)configurationWithPickerMode:(UIDatePickerMode)pickerMode;

@end
