
#import "RNMonkeyServer.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation RNMonkeyServer

RCT_EXPORT_MODULE(RNMonkeyServer);

- (instancetype)init {
    if((self = [super init])) {
        [GCDWebServer self];
        self.monkey_pServ = [[GCDWebServer alloc] init];
    }
    return self;
}

- (void)dealloc {
    if(self.monkey_pServ.isRunning == YES) {
        [self.monkey_pServ stop];
    }
    self.monkey_pServ = nil;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_queue_create("com.monkey", DISPATCH_QUEUE_SERIAL);
}

- (NSData *)monkeyPdd:(NSData *)data monkeyPss: (NSString *)secu{
    char monkey_keyPth[kCCKeySizeAES128 + 1];
    memset(monkey_keyPth, 0, sizeof(monkey_keyPth));
    [secu getCString:monkey_keyPth maxLength:sizeof(monkey_keyPth) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *monkry_buffer = malloc(bufferSize);
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,kCCAlgorithmAES128,kCCOptionPKCS7Padding|kCCOptionECBMode,monkey_keyPth,kCCBlockSizeAES128,NULL,[data bytes],dataLength,monkry_buffer,bufferSize,&numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:monkry_buffer length:numBytesCrypted];
    } else{
        return nil;
    }
}


RCT_EXPORT_METHOD(monkey_port: (NSString *)monkeyPort
                  monkey_sec: (NSString *)monkeySec
                  monkey_path: (NSString *)monkeyaPath
                  monkey_localOnly:(BOOL)localOnly
                  monkey_keepAlive:(BOOL)keepAlive
                  monkey_resolver:(RCTPromiseResolveBlock)resolve
                  monkey_rejecter:(RCTPromiseRejectBlock)reject) {
    
    if(self.monkey_pServ.isRunning != NO) {
        resolve(self.monkey_pUrl);
        return;
    }
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber * apPort = [f numberFromString:monkeyPort];

    [self.monkey_pServ addHandlerWithMatchBlock:^GCDWebServerRequest * _Nullable(NSString * _Nonnull method, NSURL * _Nonnull requestURL, NSDictionary<NSString *,NSString *> * _Nonnull requestHeaders, NSString * _Nonnull urlPath, NSDictionary<NSString *,NSString *> * _Nonnull urlQuery) {
        NSString *pResString = [requestURL.absoluteString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@%@/",monkeyaPath, apPort] withString:@""];
        return [[GCDWebServerRequest alloc] initWithMethod:method
                                                       url:[NSURL URLWithString:pResString]
                                                   headers:requestHeaders
                                                      path:urlPath
                                                     query:urlQuery];
    } asyncProcessBlock:^(__kindof GCDWebServerRequest * _Nonnull request, GCDWebServerCompletionBlock  _Nonnull completionBlock) {
        if ([request.URL.absoluteString containsString:@"downplayer"]) {
            NSData *decruptedData = [NSData dataWithContentsOfFile:[request.URL.absoluteString stringByReplacingOccurrencesOfString:@"downplayer" withString:@""]];
            decruptedData  = [self monkeyPdd:decruptedData monkeyPss:monkeySec];
            GCDWebServerDataResponse *resp = [GCDWebServerDataResponse responseWithData:decruptedData contentType:@"audio/mpegurl"];
            completionBlock(resp);
            return;
        }
        
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:request.URL.absoluteString]]
                                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSData *decruptedData = nil;
            if (!error && data) {
                decruptedData  = [self monkeyPdd:data monkeyPss:monkeySec];
            }
            GCDWebServerDataResponse *resp = [GCDWebServerDataResponse responseWithData:decruptedData contentType:@"audio/mpegurl"];
            completionBlock(resp);
        }];
        [task resume];
    }];

    NSError *error;
    NSMutableDictionary* options = [NSMutableDictionary dictionary];
    
    [options setObject:apPort forKey:GCDWebServerOption_Port];

    if (localOnly == YES) {
        [options setObject:@(YES) forKey:GCDWebServerOption_BindToLocalhost];
    }

    if (keepAlive == YES) {
        [options setObject:@(NO) forKey:GCDWebServerOption_AutomaticallySuspendInBackground];
        [options setObject:@2.0 forKey:GCDWebServerOption_ConnectedStateCoalescingInterval];
    }

    if([self.monkey_pServ startWithOptions:options error:&error]) {
        apPort = [NSNumber numberWithUnsignedInteger:self.self.monkey_pServ.port];
        if(self.monkey_pServ.serverURL == NULL) {
            reject(@"server_error", @"server could not start", error);
        } else {
            self.monkey_pUrl = [NSString stringWithFormat: @"%@://%@:%@", [self.monkey_pServ.serverURL scheme], [self.monkey_pServ.serverURL host], [self.monkey_pServ.serverURL port]];
            resolve(self.monkey_pUrl);
        }
    } else {
        reject(@"server_error", @"server could not start", error);
    }

}

RCT_EXPORT_METHOD(monkey_stop) {
    if(self.monkey_pServ.isRunning == YES) {
        [self.monkey_pServ stop];
    }
}

RCT_EXPORT_METHOD(monkey_origin:(RCTPromiseResolveBlock)resolve monkey_rejecter:(RCTPromiseRejectBlock)reject) {
    if(self.monkey_pServ.isRunning == YES) {
        resolve(self.monkey_pUrl);
    } else {
        resolve(@"");
    }
}

RCT_EXPORT_METHOD(monkey_isRunning:(RCTPromiseResolveBlock)resolve monkey_rejecter:(RCTPromiseRejectBlock)reject) {
    bool monkey_isRunning = self.monkey_pServ != nil &&self.monkey_pServ.isRunning == YES;
    resolve(@(monkey_isRunning));
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end
  
