//
//  YBDatePickView.m
//  edianzu
//
//  Created by 王迎博 on 2018/4/26.
//  Copyright © 2018年 edianzu. All rights reserved.
//

#import "YBDatePickView.h"

@interface YBDatePickView()

/**配置UIDatePickerMode*/
//@property (nonatomic) UIDatePickerMode pickerMode;
/***/
@property(strong, nonatomic) UIDatePicker *datePicker;
/***/
@property (nonatomic, copy) NSString *dateStr;

@end

@implementation YBDatePickView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.227 alpha:0.5];
    }
    return self;
}

#pragma mark -- 选择器
- (void)configuration {
    [self configurationWithPickerMode:UIDatePickerModeDate];
}

- (void)configurationWithPickerMode:(UIDatePickerMode)pickerMode {
    //pickerView默认高度
    CGFloat kDatePickHeight = 240;
    
    if (self.frame.size.height>0 && self.frame.size.height<kDatePickHeight) {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        kDatePickHeight = self.frame.size.height;
    }
    
    //时间选择器
    UIView *dateBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, [UIScreen mainScreen].bounds.size.width, self.pickerHeight>0?self.pickerHeight:kDatePickHeight)];
    dateBgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:dateBgView];
    
    UIView *headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(dateBgView.frame), self.headerBgHeight>0?self.headerBgHeight:40)];
    headerBgView.backgroundColor = self.headerBgColor?self.headerBgColor:[UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1];
    [dateBgView addSubview:headerBgView];
    
    //确定按钮
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(headerBgView.bounds.size.width - 60, 0, 50, CGRectGetHeight(headerBgView.frame));
    commitBtn.tag = 1;
    commitBtn.titleLabel.font = self.titleFont?self.titleFont:[UIFont systemFontOfSize:17];
    [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor colorWithRed:(0/255.0) green:(116/255.0) blue:(243/255.0) alpha:1] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(pressentPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [headerBgView addSubview:commitBtn];
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10, 0, 50, CGRectGetHeight(headerBgView.frame));
    cancelBtn.tag = 0;
    cancelBtn.titleLabel.font = self.titleFont?self.titleFont:[UIFont systemFontOfSize:17];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithRed:(0/255.0) green:(116/255.0) blue:(243/255.0) alpha:1] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(pressentPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [headerBgView addSubview:cancelBtn];
    
    //设置datePicker属性
    UIDatePicker *datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerBgView.frame), [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(dateBgView.frame) - CGRectGetHeight(headerBgView.frame))];
    //datePickerMode
    datePicker.datePickerMode = pickerMode;
    NSDate *currentDate = [NSDate date];
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    
    if (self.fontColor) {
        [commitBtn setTitleColor:self.fontColor forState:UIControlStateNormal];
        [cancelBtn setTitleColor:self.fontColor forState:UIControlStateNormal];
    }
    
    //设置默认日期
    if (!self.date) { self.date = currentDate; }
    datePicker.date = self.date;
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    _dateStr = [formater stringFromDate:self.date];
    
    NSString *tempStr = [formater stringFromDate:self.date];
    NSArray *dateArray = [tempStr componentsSeparatedByString:@"-"];
    
    //设置日期选择器最大可选日期
    if (self.maxYear) {
        if (self.maxYear == YB_DATE_PICKER_STATIC_TODAY_END) {
            datePicker.maximumDate = [NSDate date];
        }else {
            NSInteger maxYear = [dateArray[0] integerValue] - self.maxYear;
            NSString *maxStr = [NSString stringWithFormat:@"%ld-%@-%@",maxYear,dateArray[1],dateArray[2]];
            NSDate *maxDate = [formater dateFromString:maxStr];
            datePicker.maximumDate = maxDate;
        }
    }
    
    if (self.maxDateString) {
        NSArray *timeArr = [self.maxDateString componentsSeparatedByString:@":"];
        if (timeArr) {
            if (timeArr.count == 3) {
                [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            }else if (timeArr.count == 2) {
                [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
            }
        }
        NSDate *maxDate = [formater dateFromString:self.maxDateString];
        datePicker.maximumDate = maxDate;
    }
    
    if (self.maximumDate) {
        datePicker.maximumDate = self.maximumDate;
    }
    
    //设置日期选择器最小可选日期
    if (self.minYear) {
        if (self.minYear == YB_DATE_PICKER_STATIC_TODAY_END) {
            datePicker.minimumDate = [NSDate date];
        }else {
            NSInteger minYear = [dateArray[0] integerValue] - self.minYear;
            NSString *minStr = [NSString stringWithFormat:@"%ld-%@-%@",minYear,dateArray[1],dateArray[2]];
            NSDate* minDate = [formater dateFromString:minStr];
            datePicker.minimumDate = minDate;
        }
    }
    
    if (self.minDateString) {
        NSArray *timeArr = [self.minDateString componentsSeparatedByString:@":"];
        if (timeArr) {
            if (timeArr.count == 3) {
                [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            }else if (timeArr.count == 2) {
                [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
            }
        }
        NSDate* minDate = [formater dateFromString:self.minDateString];
        datePicker.minimumDate = minDate;
    }
    
    if (self.minimumDate) {
        datePicker.minimumDate = self.minimumDate;
    }
    
    [datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    [dateBgView addSubview: datePicker];
    self.datePicker = datePicker;
    
    if (self.isOnTop) {
        dateBgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (self.pickerHeight>0?self.pickerHeight:kDatePickHeight));
    }else {
        [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionLayoutSubviews animations:^{
            dateBgView.frame = CGRectMake(0, self.frame.size.height - (self.pickerHeight>0?self.pickerHeight:kDatePickHeight), [UIScreen mainScreen].bounds.size.width, (self.pickerHeight>0?self.pickerHeight:kDatePickHeight));
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.touchRemove) {
        [self removeFromSuperview];
    }
}

/**时间选择器确定/取消*/
- (void)pressentPickerView:(UIButton *)button {
    //确定
    if (button.tag == 1) {//确定
        if (self.completeBlock) {
            [self selectDate:nil];
            self.completeBlock(_dateStr);
        }
    }
    [self removeFromSuperview];
}

/**时间选择器日期改变*/
-(void)selectDate:(id)sender {
    UIDatePickerMode currentModel = self.datePicker.datePickerMode;
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    if (currentModel == UIDatePickerModeDate) {
        [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    }else if (currentModel == UIDatePickerModeDateAndTime) {
        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else if (currentModel == UIDatePickerModeTime) {
        [outputFormatter setDateFormat:@"HH:mm"];
    }else if (currentModel == UIDatePickerModeCountDownTimer) {
        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    _dateStr =[outputFormatter stringFromDate:self.datePicker.date];
}

/**
 datePicker每次改变时
 */
- (void)datePickerChanged:(UIDatePicker *)datePicker {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:datePicker.date];
    
    if (self.minTimeDate) {
        NSDateComponents *minComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:self.minTimeDate];
        NSInteger hour = [minComponents hour];
        NSInteger minute = [minComponents minute];
        if([components hour] <= hour) {
            [components setHour:hour];
            if ([components minute] < minute) {
                [components setMinute:minute];//0
            }
            [datePicker setDate:[[NSCalendar currentCalendar] dateFromComponents:components]];
        }
    }
    
    if (self.maxTimeDate) {
        NSDateComponents *maxComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:self.maxTimeDate];
        NSInteger hour = [maxComponents hour];
        NSInteger minute = [maxComponents minute];
        if([components hour] >= hour) {
            [components setHour:hour];
            if ([components minute] > minute) {
                [components setMinute:minute];//59
            }
            [datePicker setDate:[[NSCalendar currentCalendar] dateFromComponents:components]];
        }
    }
}

@end
