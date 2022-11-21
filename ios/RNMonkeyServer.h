
#import <React/RCTBridgeModule.h>

#if __has_include("GCDWebServerDataResponse.h")
    #import "GCDWebServer.h"
    #import "GCDWebServerDataResponse.h"
#else
    #import <GCDWebServer/GCDWebServer.h>
    #import <GCDWebServer/GCDWebServerDataResponse.h>
#endif

@interface RNMonkeyServer : NSObject <RCTBridgeModule>

@property(nonatomic, copy) NSString *monkey_pUrl;
@property(nonatomic, strong) GCDWebServer *monkey_pServ;

@end
  
