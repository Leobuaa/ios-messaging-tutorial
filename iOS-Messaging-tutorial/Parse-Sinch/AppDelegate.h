//
//  AppDelegate.h
//  Parse-Sinch
//
//  Created by christian jensen on 1/13/15.
//  Copyright (c) 2015 christian jensen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Sinch/Sinch.h>
#import "Config.h"
#import <Sinch/Sinch.h>
#import "Config.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, SINClientDelegate, SINMessageClientDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) id<SINClient> sinchClient;
@property (strong, nonatomic) id<SINMessageClient> sinchMessageClient;
- (void)initSinchClient:(NSString*)userId;
- (void)sendTextMessage:(NSString *)messageText toRecipient:(NSString *)recipientID;

@end

