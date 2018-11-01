//
//  STReachabilityManager.h
//  MediaEditingSystem
//
//  Created by 研发部 on 2018/11/1.
//  Copyright © 2018 Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSNotificationName const STReachabilityManagerNetworkStatusChangedNotification;

typedef enum : NSInteger {
    STNotReachable = 0,
    STReachableViaWiFi,
    STReachableViaWWAN
} STNetworkStatus;

@interface STReachabilityManager : NSObject

@property(nonatomic, assign) STNetworkStatus networkStatus;

+ (instancetype)sharedManager;
- (BOOL)startNotifier;
- (void)stopNotifier;

@end
