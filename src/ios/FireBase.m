//
//  CDVFirebase.m
//  Hello World
//
//  Created by Simba on 10/6/15.
//
//

#import "FireBase.h"
#import <Firebase/Firebase.h>

@interface CDVFirebase () {
    NSString *appName;
}
@end

@implementation CDVFirebase

- (void)init:(CDVInvokedUrlCommand*)command {
    NSString*       callback;
    callback = command.callbackId;
    
    if ( [command.arguments count] >= 1 )
    {
        appName = [command.arguments objectAtIndex:0];
    }
    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:callback];

}

- (void)setPersistenceEnabled:(CDVInvokedUrlCommand*)command {
    //
    NSString*       callback;
    callback = command.callbackId;
    
    BOOL persistenceEnabled = YES;
    if ( [command.arguments count] >= 1 )
    {
        persistenceEnabled = [command.arguments objectAtIndex:0];
    }
    [Firebase defaultConfig].persistenceEnabled = persistenceEnabled;
    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:callback];
}

- (void)readData:(CDVInvokedUrlCommand*)command {
    //
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    
    NSString*       callback;
    callback = command.callbackId;
    
    NSObject *object;
    if ( [command.arguments count] >= 1 )
    {
        object = [command.arguments objectAtIndex:0];
    }
    
//    capabilityError = [self isScanNotPossible];
//    if (capabilityError) {
//        CDVPluginResult* result = [CDVPluginResult
//                                   resultWithStatus: CDVCommandStatus_ERROR
//                                   messageAsString: capabilityError
//                                   ];
//        
//        [self.commandDelegate sendPluginResult:result callbackId:callback];
//        
//        return;
//    }
    
    Firebase *myRootRef = [[Firebase alloc] initWithUrl: urlString];
    // Read data and react to changes
    [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
        NSDictionary *resultDict = @{snapshot.key: snapshot.value};
        CDVPluginResult *result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDict];
        [self.commandDelegate sendPluginResult:result callbackId:callback];
    }];
}

- (void)writeData:(CDVInvokedUrlCommand*)command {
    //
    id value = nil;
    if ( [command.arguments count] >= 1 )
    {
        value = [command.arguments objectAtIndex:0];
    }
    // Create a reference to a Firebase database URL
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:urlString];
    // Write data to Firebase
    [myRootRef setValue: value];
}

@end
