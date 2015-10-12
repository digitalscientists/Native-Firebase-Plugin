//
//  CDVFirebase.h
//  Hello World
//
//  Created by Simba on 10/6/15.
//
//

#import <Cordova/CDVPlugin.h>

@interface CDVFirebase : CDVPlugin

- (void)init:(CDVInvokedUrlCommand*)command;

- (void)setPersistenceEnabled:(CDVInvokedUrlCommand*)command;
    // Attach a block to read the data at our reference with AppName based URL
- (void)readData:(CDVInvokedUrlCommand*)command;
    // Attach a block to read the data at our reference with detailed URL
- (void)readValueTypeEventWithURL:(CDVInvokedUrlCommand*)command;
    // Attach a block to retrieve the data at our reference with detailed URL when child added Evens are triggered
- (void)RetrieveChildAddedEventWithURL:(CDVInvokedUrlCommand*)command;
    // Attach a block to retrieve the data at our reference with detailed URL when child changed Event are triggered
- (void)RetrieveChildChangedEventWithURL:(CDVInvokedUrlCommand*)command;
    // Attach a block to retrieve the data at our reference with detailed URL when child removed Event are triggered
- (void)RetrieveChildRemovedEventWithURL:(CDVInvokedUrlCommand*)command;
    //Reading Data Once
- (void)readDataOnceWithURL:(CDVInvokedUrlCommand*)command;
    //remove all callbacks at a location
- (void)removeAllCallbacksWithURL:(CDVInvokedUrlCommand*)command;

    //
- (void)writeData:(CDVInvokedUrlCommand*)command;
    //
- (void)writeValueToURL:(CDVInvokedUrlCommand*)command;
    //retern AutoID NSString
- (void)writeValueToURLWithAutoID: (CDVInvokedUrlCommand*)command;


    //child set by AppendingPath
- (void)childSet: (CDVInvokedUrlCommand*) command;

    //Initializing a Firebase object
//- (void)initWithUrl:(CDVInvokedUrlCommand*)command;


//User Login
- (void)userLogin: (CDVInvokedUrlCommand*) command;

//- (void)createUser:(CDVInvokedUrlCommand*)command;
@end
