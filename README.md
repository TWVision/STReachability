# STReachability
iOS 设备的实时网络状态，且可以监听网络的变化事件
> 对Reachability的二次封装，接口更简单易用

## 使用步骤：
1. 下载并导入**STReachability**
2. 在项目中添加`SystemConfiguration.framework`库
3. 在要使用的控制器中`#import "STReachabilityManager.h"`即可

## 常用方法示例
### 创建STReachabilityManager
```objc
    // 创建STReachabilityManager
    _reachabilityManager = [STReachabilityManager sharedManager];
    // 启动监听
    [_reachabilityManager startNotifier];
```

### 查看实时网络状态
```objc
    STNetworkStatus networkStatus = [STReachabilityManager sharedManager].networkStatus;
    switch (networkStatus) {
        case STNotReachable://无网络
            
            break;
        case STReachableViaWiFi://WIFI
            
            break;
        case STReachableViaWWAN://网络运营商
            
            break;
        default:
            break;
    }
```
