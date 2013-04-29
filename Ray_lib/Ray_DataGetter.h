//
//  Ray_DataGetter.h
//  Ray_lib
//
//  Created by Bird on 13/4/27.
//  Copyright (c) 2013年 Bird. All rights reserved.
//
typedef enum{
    noMessage_type = 0,
    alertView_type,
    hud_type
}messageType;
typedef enum{
    JSON_type = 0,
    XML_type,
    /* plist */
}responsType;
#import <Foundation/Foundation.h>
@interface Ray_DataGetter : NSObject{
    void (^ successedCallbackBlock)(NSString *retString);
    void (^ failedCallbackBlock)(NSString *retString);
}
- (void)logSomeThing:(NSString*)something;
- (void)getStringFromURL:(NSString*)URLString targetRespondType:(responsType)targetType showingText:(NSString*)showingText withStyle:(messageType)messageType timeOut:(NSTimeInterval)timeOut successWithBlock:(void (^)(NSString *))successedCallBack andFailedWithBlock:(void (^)(NSString *))failedCallBack;
@end
