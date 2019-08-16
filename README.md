# YBDatePickerDemo
封装日期选择器

### 使用 ###

	- (void)buttonClick:(UIButton *)sender {
	    YBDatePickView *datePicker = [[YBDatePickView alloc] initWithFrame:self.view.frame];
	    
	    NSDate *currentDate = [NSDate date];//获取当前时间，日期
	    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
	    NSString *dateString = [dateFormatter stringFromDate:currentDate];
	    NSDate *beginDate = [dateFormatter dateFromString:dateString];
	    datePicker.minTimeDate = [beginDate dateByAddingTimeInterval:(8*60*60+30*60)];
	    datePicker.maxTimeDate = [beginDate dateByAddingTimeInterval:20*60*60];
	    
	    datePicker.completeBlock = ^(NSString *selectDate) {
	        NSLog(@"%@",selectDate);
	        [sender setTitle:selectDate forState:UIControlStateNormal];
	    };
	    [datePicker configurationWithPickerMode:UIDatePickerModeDateAndTime];
	    [self.view addSubview:datePicker];
	}