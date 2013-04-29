//
//  Ray_DataGetter.m
//  Ray_lib
//
//  Created by Bird on 13/4/27.
//  Copyright (c) 2013年 Bird. All rights reserved.
//

#import "Ray_DataGetter.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
@interface Ray_DataGetter (){
    MBProgressHUD *hud;
    UIAlertView *alertView;
}
@end
@implementation Ray_DataGetter
- (void)logSomeThing:(NSString*)something{
    NSLog(@"%@",something);
}

- (void)getStringFromURL:(NSString*)URLString targetRespondType:(responsType)targetType showingText:(NSString*)showingText withStyle:(messageType)messageType timeOut:(NSTimeInterval)timeOut successWithBlock:(void (^)(NSString *))successedCallBack andFailedWithBlock:(void (^)(NSString *))failedCallBack{
    successedCallbackBlock = successedCallBack;
    failedCallbackBlock = failedCallBack;
    UIView *lastView = [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];
    if (hud) {
        [hud removeFromSuperview];
        hud = nil;
    }
    if (alertView) {
        [alertView dismissWithClickedButtonIndex:-1 animated:YES];
        alertView = nil;
    }
    if (!showingText) {
        showingText = @"";
    }
    //show with alert view or...?
    if (messageType == hud_type) {
     	hud = [[MBProgressHUD alloc] initWithView:lastView];
        [lastView addSubview:hud];
        hud.labelText = showingText;
        [hud show:YES];
    } else if (messageType == alertView_type) {
        alertView = [[UIAlertView alloc] initWithTitle:nil message:showingText delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
        UIActivityIndicatorView *waitView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        waitView.frame = CGRectMake(125, 55, 30, 30);
        [waitView startAnimating];
        [alertView addSubview:waitView];
        [alertView show];
    }
    NSString *urlString = URLString;
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        successedCallbackBlock(JSON);
        [hud removeFromSuperview];
        hud = nil;
        [alertView dismissWithClickedButtonIndex:-1 animated:YES];
        alertView = nil;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        failedCallBack([error localizedDescription]);
        [hud removeFromSuperview];
        hud = nil;
        [alertView dismissWithClickedButtonIndex:-1 animated:YES];
        alertView = nil;
    }];
    [operation start];
}

@end
