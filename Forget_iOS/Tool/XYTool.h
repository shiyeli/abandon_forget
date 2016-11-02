//
//  XYTool.h
//  Ticket
//
//  Created by weizejian on 16/5/16.
//  Copyright © 2016年 yexianyong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XYTool : NSObject

/**
 *  验证是否是手机号
 *
 *  @param mobileNum 手机号
 *
 *  @return YES:是手机号
 */
+(BOOL)validateMobile:(NSString *)mobileNum;
/**
 *  验证是否是邀请码
 *
 */
+(BOOL)validatePromotionCode:(NSString*)promotion;
/**
 *  验证是否是验证码
 */
+(BOOL)validateVarifyCode:(NSString*)code;
/**
 *  验证身份证
 *
 *  @param idCard <#idCard description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)validateIdCard: (NSString *) idCard;


+(void)showAlertViewMessage:(NSString*)mesg cancel:(NSString*)cancel;
/**
 *  清除缓存
 */
+(void)clearInternalStorage;
/**
 *  16进制颜色转UIColor  字符串@“#ff3344”
 *
 *  @return UIColor
 */
+(UIColor *) stringToColor:(NSString *)str;
/**
 *  color转image
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  本地验证不通过提示
 *
 *  @param mes 提示语
 */
+(void)showPromptView:(NSString*)mes holdView:(UIView*)holdView;



/**
 *  返回浅色 暗色两种字体颜色
 */
+(NSAttributedString*)lightStr:(NSString*)str darkStr:(NSString*)darkStr;

/**
 *  json字符串转字典
 *
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 *  转换时间
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+(NSString*)transferTimeStr:(NSString*)str;



/**
 *  url编码
 *
 *  @param encodeString 中文
 *
 *  @return 编码后的字符串
 */
+ (NSString *)urlencode:(NSString *)encodeString;

+ (NSString*)weekdayStringFromDate:(NSString*)inputDate;
/**
 *  过滤空格与回车
 */
+ (NSString *)removeSpaceAndNewline:(NSString *)str;

/**
 *  绑定百度推送
 */
+(void)bindBpush;

/**
 *  通过颜色获取图片
 *
 *  @param color <#color description#>
 *  @param size  <#size description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)getImageFromColor:(UIColor *)color size:(CGSize)size;


/**
 *  获取时间戳
 *
 */
+(NSString*)getTimeLabelFromDate:(NSDate*)date;

/**
 *  获取随机的32位字符串
 *
 *  @return <#return value description#>
 */
+(NSString*)getRandomString32;

/**
 *  MD5
 *
 */
+(NSString *)md5HexDigest:(NSString *)url;

/**
 *  当前控制器
 *
 *  @return <#return value description#>
 */
+( UIViewController *) currentViewController;



@end
