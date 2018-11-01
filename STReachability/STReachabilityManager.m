//
//  STReachabilityManager.m
//  MediaEditingSystem
//
//  Created by 研发部 on 2018/11/1.
//  Copyright © 2018 Wong. All rights reserved.
//

#import "STReachabilityManager.h"
#import "Reachability.h"

NSNotificationName const STReachabilityManagerNetworkStatusChangedNotification = @"STReachabilityManagerNetworkStatusChangedNotification";

@interface STReachabilityManager() {
    Reachability *_hostReach;
}


@end

@implementation STReachabilityManager

+ (instancetype)sharedManager {
    static STReachabilityManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[STReachabilityManager alloc] init];
        [_sharedManager manager];
    });
    
    return _sharedManager;
}

- (void)manager {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    _hostReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [_hostReach currentReachabilityStatus];
    switch (networkStatus) {
        case NotReachable://无网络
        {
            self.networkStatus = STNotReachable;
        }
            break;
        case ReachableViaWiFi://当前为wifi网络
        {
            self.networkStatus = STReachableViaWiFi;
        }
            break;
        case ReachableViaWWAN://当前为网络运营商
        {
            self.networkStatus = STReachableViaWWAN;
        }
            break;
        default:
            break;
    }
}

- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}


- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    switch (networkStatus) {
        case NotReachable://无网络
        {
            self.networkStatus = STNotReachable;
        }
            break;
        case ReachableViaWiFi://当前为wifi网络
        {
            self.networkStatus = STReachableViaWiFi;
        }
            break;
        case ReachableViaWWAN://当前为网络运营商
        {
            self.networkStatus = STReachableViaWWAN;
        }
            break;
        default:
            break;
    }
    //延时通知网络状态改变
    [[NSNotificationCenter defaultCenter] postNotificationName:STReachabilityManagerNetworkStatusChangedNotification object:nil];
}

- (BOOL)startNotifier
{
    return [_hostReach startNotifier];
}

- (void)stopNotifier
{
    return [_hostReach stopNotifier];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

@end
