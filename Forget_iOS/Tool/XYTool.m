//
//  XYTool.m
//  Ticket
//
//  Created by weizejian on 16/5/16.
//  Copyright © 2016年 yexianyong. All rights reserved.
//

#import "XYTool.h"
//md5
#import<CommonCrypto/CommonDigest.h>
#import <AVFoundation/AVFoundation.h>

@implementation XYTool


+(BOOL)validateVarifyCode:(NSString*)code{
    NSString* CODE = @"^[0-9]{6}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CODE];
    if ([regextestmobile evaluateWithObject:code] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }

}
+(BOOL)validatePromotionCode:(NSString*)promotion{
    NSString* CODE = @"^[a-zA-Z]{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CODE];
    if ([regextestmobile evaluateWithObject:promotion] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(BOOL)validateMobile:(NSString *)mobileNum{
    
    
//    //
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    NSString * MOBILE = @"^1(3[0-9]|4[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189
//     22         */
//    NSString * CT = @"^1((33|53|8[0-9])[0-9]|349)\\d{7}$";
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    
//    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
//        || ([regextestcm evaluateWithObject:mobileNum] == YES)
//        || ([regextestct evaluateWithObject:mobileNum] == YES)
//        || ([regextestcu evaluateWithObject:mobileNum] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
    
    NSString* PHONE_NUM=@"[0-9]{11}";
    NSPredicate* rePhone=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHONE_NUM];
    if ([rePhone evaluateWithObject:mobileNum]==YES) {
        return YES;
    }else{
        return NO;
    }
    
}

+ (BOOL)validateIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

+(void)showAlertViewMessage:(NSString*)mesg cancel:(NSString*)cancel{
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:nil message:mesg delegate:nil cancelButtonTitle:cancel otherButtonTitles: nil];
    [alertView show];
}
//清除缓存
+(void)clearInternalStorage{
    
    //利用GCD
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //找到缓存所存的路径
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES)lastObject];
        //要清除的文
        NSArray * files = [[NSFileManager defaultManager]subpathsAtPath:path];//返回这个路径下的所有文件的数组
        for (NSString * p in files) {
            NSError * error = nil;
            NSString * cachPath = [path stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager]fileExistsAtPath:cachPath]) {
                [[NSFileManager defaultManager]removeItemAtPath:cachPath error:&error];//删除
            }
        }
    });

}

+(UIColor *) stringToColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


+(void)showPromptView:(NSString*)mes holdView:(UIView*)holdView{
    
    CGFloat  tempFont=15;
    
    CGSize size =[mes sizeWithAttributes:@{NSFontAttributeName:SYSTEMFONT(tempFont)}];
    
    UILabel* lab=[[UILabel alloc]init];
    lab.text=mes;
    lab.textAlignment=NSTextAlignmentCenter;
    lab.backgroundColor=[UIColor darkGrayColor];
    lab.textColor=[UIColor whiteColor];
    lab.font=SYSTEMFONT(tempFont);
    lab.layer.cornerRadius=3;
    lab.clipsToBounds=YES;
    
    if (holdView) {
        [holdView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(holdView);
            make.width.equalTo([NSNumber numberWithFloat:size.width+30]);
            make.bottom.equalTo(holdView).with.offset(-50);
            make.height.equalTo(@(tempFont+15));
        }];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo([UIApplication sharedApplication].keyWindow);
            make.width.equalTo([NSNumber numberWithFloat:size.width+30]);
            make.bottom.equalTo([UIApplication sharedApplication].keyWindow).with.offset(-50);
            make.height.equalTo(@(tempFont+15));
        }];
    }
    
    lab.alpha=0;
    [UIView animateWithDuration:0.3 animations:^{
        lab.alpha=1;
    }];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:0.5];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                lab.alpha=0;
            }];
        });
    });
}

+(CGFloat)superView:(UIView*)superview subView:(UILabel*)subLabel lineSpacing:(CGFloat)lineSpacing font:(UIFont*)font fontColor:(UIColor*)color hasDownLine:(BOOL)hasLine contentStr:(NSString*)str {
    
    if (str==nil) {
        return 0;
    }
    
    NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:str];
    
    
    NSMutableParagraphStyle * paraStyle=[[NSMutableParagraphStyle alloc]init];
    paraStyle.lineBreakMode=NSLineBreakByWordWrapping;
    paraStyle.lineSpacing=lineSpacing; //行距
    
    
    [attStr addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attStr.length)];
    
    
    if (hasLine) {
        [attStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, attStr.length)];
    }
    
    
    subLabel.attributedText=attStr;
    
    [superview setNeedsLayout];
    [superview layoutIfNeeded];
    return  [subLabel sizeThatFits:CGSizeMake(subLabel.bounds.size.width, 2000)].height;
    
    
}



//json格式字符串转字典

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate] ;
    return destinationDateNow;
}

+(NSString*)transferTimeStr:(NSString*)str{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = [NSString stringWithFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    NSDate * date = [dateFormatter dateFromString:str];
    
    NSString* dateStr=[NSString stringWithFormat:@"%@",[XYTool getNowDateFromatAnDate:date]];
    
    return [dateStr substringToIndex:19];

}
//获取星期几
+ (NSString*)getWeekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

// urlEncode 编码
+ (NSString *)urlencode:(NSString *)encodeString{
    
    return [encodeString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}


//通过颜色来生成一个纯色图片
+ (UIImage *)getImageFromColor:(UIColor *)color size:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width,size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


/**
 *  获取时间戳
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
+(NSString*)getTimeLabelFromDate:(NSDate*)date{
    
    
    NSTimeInterval a=[date timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    return timeString;
}
-(NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds
{
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000.0;//这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致
    NSLog(@"传入的时间戳=%f",seconds);
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}



+(NSString*)getRandomString32{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}


+(NSString *)md5HexDigest:(NSString *)url
{
    
    const char *cStr = [url UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


+(UIViewController *) findBestViewController:(UIViewController*)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [XYTool findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [XYTool findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [XYTool findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [XYTool findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}
+( UIViewController *) currentViewController {
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [XYTool findBestViewController:viewController];
}

+(void)transitionAnimationWhater{
    //转场动画
    CATransition* anim=[CATransition animation];
    
    anim.type=@"rippleEffect";
    anim.duration=0.3;
    //anim.subtype=kCATransitionFromLeft;
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
}

+(int)compareDate:(BOOL)precisionDay OneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (precisionDay) {
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    }else{
        [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    }
    
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

/**
 *  将阿拉伯数字转换为中文数字
 */
+(NSString *)translationArabicNum:(NSInteger)arabicNum
{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            
            [sums addObject:sum];
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}

//获取星期几
+ (NSString*)weekdayStringFromDate:(NSString*)inputDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = [NSString stringWithFormat:@"yyyy-MM-dd"];
    
    NSDate * date = [dateFormatter dateFromString:inputDate];
    
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+(void)broadcastNotify:(NSString*)content{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:content];
    utterance.rate *= 0.8;
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
    //获取当前系统语音
    NSString *m_strLang=[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    NSString *preferredLang = @"";
    if ([m_strLang  isEqual: @"zh-Hans-CN"])
    {
        preferredLang = @"zh-CN";
    }else{
        preferredLang = @"en-US";
    }
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:[NSString stringWithFormat:@"%@",preferredLang]];
    utterance.voice = voice;
    [synth speakUtterance:utterance];
    
}

+(void)sendLocalNotifycation:(XYNotifyModel*)model success:(void (^) (BOOL success))sendSuccess{
    
 
    //发送本地推送
    UNMutableNotificationContent* content=[[UNMutableNotificationContent alloc]init];
    content.title=@"Imnesia 提醒您:";
    content.body=model.notifyRemark;
    content.sound=[UNNotificationSound defaultSound];
    
    
    

    UNNotificationTrigger* tempTriger=nil;
    if (model.haveSetTime) {//时间提醒
        if (model.haveSetRepeat==NO) {//只提醒一次
            NSTimeInterval interval=[model.notifyTime timeIntervalSinceDate:[NSDate date]];
            tempTriger=[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:interval repeats:NO];
        }else {//要重复
            
            NSCalendarUnit unitFlags;
            if (model.repeatUnit==TimeSetRepeatDay) {
                unitFlags= NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
            }else if(model.repeatUnit==TimeSetRepeatWeek){
                unitFlags= NSCalendarUnitWeekday|NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
            }else {
                unitFlags= NSCalendarUnitDay|NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
            }
            
            NSDateComponents *tempComps = [[NSCalendar currentCalendar] components:unitFlags fromDate:model.notifyTime];
  
            tempTriger=[UNCalendarNotificationTrigger triggerWithDateMatchingComponents:tempComps repeats:YES];
            
            NSLog(@"第一次提醒时间:%@ ",model.notifyTime);
            
        }
    }
    
    if(model.haveSetLocation==YES){//地点提醒
        if (model.isPersonalLocation){//如果是指定地点
            CLLocationCoordinate2D coordinate2D;
            coordinate2D.latitude=model.tip.location.latitude;
            coordinate2D.longitude=model.tip.location.longitude;
            
            CLCircularRegion *regin=[[CLCircularRegion alloc]initWithCenter:coordinate2D radius:200 identifier:model.currentTime];
            regin.notifyOnEntry=model.isArrvialNotify;
            regin.notifyOnExit=!model.isArrvialNotify;
            tempTriger=[UNLocationNotificationTrigger triggerWithRegion:regin repeats:NO];
            
        }else{
            //一类地点???
            sendSuccess(YES);
            return;
        }
    }
    
    UNNotificationRequest * notifyReq=[UNNotificationRequest requestWithIdentifier:model.currentTime content:content trigger:tempTriger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notifyReq withCompletionHandler:^(NSError * _Nullable error) {
        if (error==nil) {
            sendSuccess(YES);
        }else{
            sendSuccess(NO);
        }
        
    }];

}

+(void)sendLocalNotifycationRightNowLocation:(NSString*)location message:(NSString*)message{


    //发送本地推送
    UNMutableNotificationContent* content=[[UNMutableNotificationContent alloc]init];
    content.title=@"Imnesia 提醒您:";
    content.subtitle=[NSString stringWithFormat:@"附近有:%@",location];
    content.body=message;
    content.sound=[UNNotificationSound defaultSound];
    
    
    UNTimeIntervalNotificationTrigger* triger=[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.1 repeats:NO];
    UNNotificationRequest * notifyReq=[UNNotificationRequest requestWithIdentifier:@"rightnow" content:content trigger:triger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notifyReq withCompletionHandler:^(NSError * _Nullable error) {
        if (error==nil) {
            
        }else{
            NSLog(@"right now notify 发送通知成功");
        }
        
    }];




}


@end
