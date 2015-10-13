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
    BOOL isUsed;
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
    
    if (isUsed == YES) {
        CDVPluginResult* result = [CDVPluginResult
                                   resultWithStatus: CDVCommandStatus_ERROR
                                   messageAsString: @"Can't modify config objects after they are in use for Firebase references."
                                   ];
        
        [self.commandDelegate sendPluginResult:result callbackId:callback];
        return;
    }
    
    BOOL persistenceEnabled = YES;
    if ( [command.arguments count] >= 1 )
    {
        persistenceEnabled = [[command.arguments objectAtIndex:0] boolValue];
    }
    [[Firebase defaultConfig] setPersistenceEnabled:persistenceEnabled];
    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:callback];
}

- (void)readData:(CDVInvokedUrlCommand*)command {
    //
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    
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
    if(isUsed != YES)
        isUsed = YES;
    // Read data and react to changes
    [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
        NSDictionary *resultDict = snapshot.value;
        
        CDVPluginResult *result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDict];
        [result setKeepCallback:[NSNumber numberWithBool:YES]];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        
    } withCancelBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
        CDVPluginResult *result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.description];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}
//Reading Data Once
- (void)readDataOnceWithURL:(CDVInvokedUrlCommand*)command {
    //
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    
    //NSObject *object;
    if ( [command.arguments count] >= 1 )
    {
        //object = [command.arguments objectAtIndex:0];
        urlString = [command.arguments objectAtIndex:0];
    }
    
    
    Firebase *myChildRef = [[Firebase alloc] initWithUrl: urlString];
    if(isUsed != YES)
        isUsed = YES;
    // Read data and react to changes
    [myChildRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
        NSDictionary *resultDict = snapshot.value;
        
        CDVPluginResult *result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDict];
        //[result setKeepCallback:[NSNumber numberWithBool:YES]];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    } withCancelBlock:^(NSError *error){
        NSLog(@"%@", error.description);
        CDVPluginResult *result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.description];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];

}
//remove all callbacks at a location
- (void)removeAllCallbacksWithURL:(CDVInvokedUrlCommand*)command {
    //
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    
   if ( [command.arguments count] >= 1 )
    {
        urlString = [command.arguments objectAtIndex:0];
    }
    Firebase *myChildRef = [[Firebase alloc] initWithUrl: urlString];
    
    [myChildRef removeAllObservers];
    
    CDVPluginResult *result;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

// Attach a block to read the data at our posts reference with detailed URL
- (void)readValueTypeEventWithURL:(CDVInvokedUrlCommand*)command {
    //
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    
    //NSObject *object;
    if ( [command.arguments count] >= 1 )
    {
        //object = [command.arguments objectAtIndex:0];
        urlString = [command.arguments objectAtIndex:0];
    }
    
    
    Firebase *myChildRef = [[Firebase alloc] initWithUrl: urlString];
    if(isUsed != YES)
        isUsed = YES;
    // Read data and react to changes
    [myChildRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
        NSDictionary *resultDict = snapshot.value;
        
        CDVPluginResult *result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDict];
        [result setKeepCallback:[NSNumber numberWithBool:YES]];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    } withCancelBlock:^(NSError *error){
        NSLog(@"%@", error.description);
        CDVPluginResult *result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.description];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}
// Attach a block to retrieve the data at our reference with detailed URL when child added Evens are triggered
- (void)RetrieveChildAddedEventWithURL:(CDVInvokedUrlCommand*)command {
    //
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    
    //NSObject *object;
    if ( [command.arguments count] >= 1 )
    {
        //object = [command.arguments objectAtIndex:0];
        urlString = [command.arguments objectAtIndex:0];
    }
    
    
    Firebase *myChildRef = [[Firebase alloc] initWithUrl: urlString];
    if(isUsed != YES)
        isUsed = YES;
    // Retrieve new posts as they are added to the database
    [myChildRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"Triggered child added Evet");
        NSDictionary *resultDict = snapshot.value;
        
        CDVPluginResult *result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDict];
        [result setKeepCallback:[NSNumber numberWithBool:YES]];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    } withCancelBlock:^(NSError *error){
        NSLog(@"%@", error.description);
        CDVPluginResult *result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.description];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

// Attach a block to retrieve the data at our reference with detailed URL when child changed Event are triggered
- (void)RetrieveChildChangedEventWithURL:(CDVInvokedUrlCommand*)command {
    //
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    
    //NSObject *object;
    if ( [command.arguments count] >= 1 )
    {
        //object = [command.arguments objectAtIndex:0];
        urlString = [command.arguments objectAtIndex:0];
    }
    
    
    Firebase *myChildRef = [[Firebase alloc] initWithUrl: urlString];
    if(isUsed != YES)
        isUsed = YES;
    // Retrieve new posts as they are added to the database
    [myChildRef observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"Triggered Child Change Event");
        NSDictionary *resultDict = snapshot.value;
        
        CDVPluginResult *result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDict];
        [result setKeepCallback:[NSNumber numberWithBool:YES]];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    } withCancelBlock:^(NSError *error){
        NSLog(@"%@", error.description);
        CDVPluginResult *result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.description];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

// Attach a block to retrieve the data at our reference with detailed URL when child removed Event are triggered
- (void)RetrieveChildRemovedEventWithURL:(CDVInvokedUrlCommand*)command {
    //
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    
    //NSObject *object;
    if ( [command.arguments count] >= 1 )
    {
        //object = [command.arguments objectAtIndex:0];
        urlString = [command.arguments objectAtIndex:0];
    }
    
    
    Firebase *myChildRef = [[Firebase alloc] initWithUrl: urlString];
    if(isUsed != YES)
        isUsed = YES;
    // Retrieve new posts as they are added to the database
    [myChildRef observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"Triggered Child Removed Event");
        NSDictionary *resultDict = snapshot.value;
        
        CDVPluginResult *result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDict];
        [result setKeepCallback:[NSNumber numberWithBool:YES]];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    } withCancelBlock:^(NSError *error){
        NSLog(@"%@", error.description);
        CDVPluginResult *result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.description];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

//
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
    isUsed = YES;
    
    // Write data to Firebase
    //[myRootRef setValue: value];
    [myRootRef setValue:value withCompletionBlock:^(NSError *error, Firebase *myRootRef) {
        CDVPluginResult *result;
        if (error) {
            //NSLog(@"Data could not be saved.");
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        } else {
            //NSLog(@"Data saved successfully.");
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }
    }];
}

- (void)writeValueToURL:(CDVInvokedUrlCommand*)command {
    //
    id value = nil;
    // Create a reference to a Firebase database URL
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    
    if ( [command.arguments count] >= 2 )
    {
        urlString = [command.arguments objectAtIndex:0];
        value = [command.arguments objectAtIndex:1];
    }
    //NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    Firebase *myChildRef = [[Firebase alloc] initWithUrl:urlString];
    isUsed = YES;
    
    // Write data to Firebase
    //[myChildRef setValue: value];
    [myChildRef setValue:value withCompletionBlock:^(NSError *error, Firebase *myChildRef) {
        CDVPluginResult *result;
        if (error) {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            //NSLog(@"Data could not be saved.");
        } else {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            //NSLog(@"Data saved successfully.");
        }
    }];
}

- (void)writeValueToURLWithAutoID: (CDVInvokedUrlCommand*)command {
    //
    id value = nil;
    // Create a reference to a Firebase database URL
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    
    if ( [command.arguments count] >= 1 )
    {
        urlString = [command.arguments objectAtIndex:0];
        value = [command.arguments objectAtIndex:1];
    }

    Firebase *myChildRef = [[Firebase alloc] initWithUrl:urlString];
    Firebase *autoIDRef = [myChildRef childByAutoId];
    isUsed = YES;
    
    
    // Write data to Firebase
    //[myChildRef setValue: value];
    [autoIDRef setValue:value withCompletionBlock:^(NSError *error, Firebase *autoIDRef) {
        CDVPluginResult *result;
        if (error) {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            //NSLog(@"Data could not be saved.");
        } else {
            NSString *autoId = autoIDRef.key;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:autoId];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            //NSLog(@"Data saved successfully.");
        }
    }];
}

// Child set by Appending Path
-(void)childSet: (CDVInvokedUrlCommand*) command {
    ///
    NSString *path;
    id object = nil;
    if ( [command.arguments count] >= 2 )
    {
        path = [command.arguments objectAtIndex:0];
        object = [command.arguments objectAtIndex:1];
    }

    // Create a reference to a Firebase database URL
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:urlString];
    isUsed = YES;
    
    Firebase *childRef = [myRootRef childByAppendingPath:path];
    [childRef setValue:object];
    
    CDVPluginResult *result;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
}

//Authenticate using the provided credentials.
- (void)authWithCustomToken:(CDVInvokedUrlCommand*) command
{
    // Create a reference to a Firebase database URL
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    NSString *token = nil;
    if ( [command.arguments count] >= 1 )
    {
        token = [command.arguments objectAtIndex:0];
    }
    Firebase *rootRef = [[Firebase alloc] initWithUrl:urlString];
    
    [rootRef authWithCustomToken:token withCompletionBlock:^( NSError *error , FAuthData *authData ){
        CDVPluginResult *result;
        if (error) {
            // Error
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            
        } else {
            // Authenticate
            NSDictionary *authDict = authData.auth;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:authDict];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }
    }];
}

- (void)onDisconnectSetValue:(CDVInvokedUrlCommand*) command
{
    // Create a reference to a Firebase database URL
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    id value = nil;
    if ( [command.arguments count] >= 2 )
    {
        urlString = [command.arguments objectAtIndex:0];
        value = [command.arguments objectAtIndex:1];
    }
    Firebase *ulrRef = [[Firebase alloc] initWithUrl:urlString];
    
    [ulrRef onDisconnectSetValue:value];
    
    CDVPluginResult *result;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

}

- (void)onDisconnectSetValueWithCompletionBlock:(CDVInvokedUrlCommand*) command
{
    // Create a reference to a Firebase database URL
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    id value = nil;
    if ( [command.arguments count] >= 2 )
    {
        urlString = [command.arguments objectAtIndex:0];
        value = [command.arguments objectAtIndex:1];
    }
    Firebase *ulrRef = [[Firebase alloc] initWithUrl:urlString];
    
    [ulrRef onDisconnectSetValue:value withCompletionBlock:^( NSError *error , Firebase *ulrRef ){
        CDVPluginResult *result;
        if (error) {
            // Error
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            
        } else {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [result setKeepCallback:[NSNumber numberWithBool:YES]];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }
    }];
}

- (void)onDisconnectRemoveValue:(CDVInvokedUrlCommand*) command
{
    // Create a reference to a Firebase database URL
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    if ( [command.arguments count] >= 1 )
    {
        urlString = [command.arguments objectAtIndex:0];
    }
    Firebase *ulrRef = [[Firebase alloc] initWithUrl:urlString];
    
    [ulrRef onDisconnectRemoveValue];
    
    CDVPluginResult *result;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
}

- (void)onDisconnectRemoveValueWithCompletionBlock:(CDVInvokedUrlCommand*) command
{
    // Create a reference to a Firebase database URL
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    if ( [command.arguments count] >= 1 )
    {
        urlString = [command.arguments objectAtIndex:0];
    }
    Firebase *ulrRef = [[Firebase alloc] initWithUrl:urlString];
    
    [ulrRef onDisconnectRemoveValueWithCompletionBlock:^ ( NSError *error , Firebase *ref ){
        CDVPluginResult *result;
        if (error) {
            // Error
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            
        } else {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [result setKeepCallback:[NSNumber numberWithBool:YES]];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }
    }];
}

- (void)onDisconnectUpdateChildValues:(CDVInvokedUrlCommand*) command
{
    // Create a reference to a Firebase database URL
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    NSDictionary *value = nil;
    if ( [command.arguments count] >= 2 )
    {
        urlString = [command.arguments objectAtIndex:0];
        value = [command.arguments objectAtIndex:1];
    }
    Firebase *ulrRef = [[Firebase alloc] initWithUrl:urlString];
    
    [ulrRef onDisconnectUpdateChildValues:value];
    CDVPluginResult *result;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)onDisconnectUpdateChildValuesWithCompletionBlock: (CDVInvokedUrlCommand*) command
{
    // Create a reference to a Firebase database URL
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    NSDictionary *value = nil;
    if ( [command.arguments count] >= 2 )
    {
        urlString = [command.arguments objectAtIndex:0];
        value = [command.arguments objectAtIndex:1];
    }
    Firebase *ulrRef = [[Firebase alloc] initWithUrl:urlString];
    
    [ulrRef onDisconnectUpdateChildValues:value withCompletionBlock:^( NSError *error , Firebase *ref ){
        CDVPluginResult *result;
        if (error) {
            // Error
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            
        } else {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [result setKeepCallback:[NSNumber numberWithBool:YES]];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }
    }];
}
- (void)cancelDisconnectOperations:(CDVInvokedUrlCommand*) command
{
    // Create a reference to a Firebase database URL
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    if ( [command.arguments count] >= 1 )
    {
        urlString = [command.arguments objectAtIndex:0];
    }
    Firebase *ulrRef = [[Firebase alloc] initWithUrl:urlString];
    
    [ulrRef cancelDisconnectOperations];
    CDVPluginResult *result;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

}

- (void)cancelDisconnectOperationsWithCompletionBlock:(CDVInvokedUrlCommand*) command
{
    // Create a reference to a Firebase database URL
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    if ( [command.arguments count] >= 1 )
    {
        urlString = [command.arguments objectAtIndex:0];
    }
    Firebase *ulrRef = [[Firebase alloc] initWithUrl:urlString];
    
    [ulrRef cancelDisconnectOperationsWithCompletionBlock:^( NSError *error , Firebase *ref ){
        CDVPluginResult *result;
        if (error) {
            // Error
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            
        } else {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [result setKeepCallback:[NSNumber numberWithBool:YES]];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }
    }];
}

//User Log in
- (void)userLogin:(CDVInvokedUrlCommand *)command{
    
    // Create a reference to a Firebase database URL
    NSString *urlString = [NSString stringWithFormat:@"https://%@.firebaseio.com", appName];
    NSString *userName = nil;
    NSString *password = nil;
    
    if ( [command.arguments count] >= 2 )
    {
        userName = [command.arguments objectAtIndex:0];
        password = [command.arguments objectAtIndex:1];
    }
    Firebase *rootRef = [[Firebase alloc] initWithUrl:urlString];
    [rootRef authUser:userName password:password withCompletionBlock:^(NSError *error, FAuthData *authData) {
        CDVPluginResult *result;
        if (error) {
            // an error occurred while attempting login
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            
        } else {
            // user is logged in, check authData for data
            NSDictionary *autoData = authData.auth;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:autoData];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }
    }];
}


//- (void)initWithUrl:(CDVInvokedUrlCommand*) command{
//    //
//
//    NSString*       callback;
//    callback = command.callbackId;
//
//    NSString *url = @"";
//    if ( [command.arguments count] >= 1 )
//    {
//        url = [command.arguments objectAtIndex:0];
//    }
//
//    Firebase *myRootRef = [[Firebase alloc] initWithUrl:url];
//    CDVPluginResult *result;
//    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//    [self.commandDelegate sendPluginResult:result callbackId:callback];
//}


// - (void)createUser:(CDVInvokedUrlCommand*)command {
//     NSString*       callback;
//     callback = command.callbackId;
    
//     NSString *username = @"", *password = @"";
//     if ( [command.arguments count] >= 2 )
//     {
//         argUsername = [command.arguments objectAtIndex:0];
//         argPassword = [command.arguments objectAtIndex:1];
//     }

//     [myRootRef createUser: argUsername, password:argPassword];

//     CDVPluginResult *result;
//     result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//     [self.commandDelegate sendPluginResult:result callbackId:callback];
// }

@end
