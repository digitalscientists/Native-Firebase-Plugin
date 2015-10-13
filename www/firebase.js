/**
 * cordova is available under *either* the terms of the modified BSD license *or* the
 * MIT License (2008). See http://opensource.org/licenses/alphabetical for full text.
 *
 * Copyright (c) LSH 2015
 * Copyright (c) 2015, CKC
 */

var FireBaseLoader = function (require, exports, module) {
var exec = require("cordova/exec");

/**
 * Constructor.
 *
 * @returns {FireBase}
 */

 function FireBase() {
 }

/**
 * Init App name on Firebase.
 *
 * @param {appName} FireBase App Name
 *
 * @param {Function} successCallback
 *
 * @param {Function} errorCallback
 */
FireBase.prototype.init = function (appName, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (successCallback == null) {
        successCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.init failure: failure parameter must be a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.init failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'init', [appName]);
};

//-------------------------------------------------------------------
FireBase.prototype.setPersistenceEnabled = function (persistenceEnabled, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }
    
    if (successCallback == null) {
        successCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.setPersistenceEnabled failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.setPersistenceEnabled failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'setPersistenceEnabled', [persistenceEnabled]);
};

//-------------------------------------------------------------------
FireBase.prototype.readData = function (successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.readData failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.readData failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'readData', []);
};

//-------------------------------------------------------------------
FireBase.prototype.readDataOnceWithURL = function (urlOfReadData, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.readData failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.readData failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'readDataOnceWithURL', [urlOfReadData]);
};

//-------------------------------------------------------------------
FireBase.prototype.removeAllCallbacksWithURL = function (urlOfRemoveCalback, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.removeAllCallbacksWithURL failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.removeAllCallbacksWithURL failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'removeAllCallbacksWithURL', [urlOfRemoveCalback]);
};

//-------------------------------------------------------------------
FireBase.prototype.readValueTypeEventWithURL = function (urlOfReadData, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.readValueTypeEventWithURL failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.readValueTypeEventWithURL failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'readValueTypeEventWithURL', [urlOfReadData]);
};

//-------------------------------------------------------------------
FireBase.prototype.RetrieveChildAddedEventWithURL = function (urlOfAddedChild, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.RetrieveChildAddedEventWithURL failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.RetrieveChildAddedEventWithURL failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'RetrieveChildAddedEventWithURL', [urlOfAddedChild]);
};

//-------------------------------------------------------------------
FireBase.prototype.RetrieveChildChangedEventWithURL = function (urlOfchangedChild, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.RetrieveChildChangedEventWithURL failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.RetrieveChildChangedEventWithURL failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'RetrieveChildChangedEventWithURL', [urlOfchangedChild]);
};

//-------------------------------------------------------------------
FireBase.prototype.RetrieveChildRemovedEventWithURL = function (urlOfRemovedChild, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.RetrieveChildRemovedEventWithURL failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.RetrieveChildRemovedEventWithURL failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'RetrieveChildRemovedEventWithURL', [urlOfRemovedChild]);
};

//-------------------------------------------------------------------
FireBase.prototype.writeData = function (object, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.writeData failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.writeData failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'writeData', [object]);
};

//-------------------------------------------------------------------
FireBase.prototype.writeValueToURL = function (url, object, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.writeValueToURL failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.writeValueToURL failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'writeValueToURL', [url], [object]);
};

//-------------------------------------------------------------------
FireBase.prototype.childSet = function (path, object, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.childSet failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.childSet failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'childSet', [path], [object]);
};

//-------------------------------------------------------------------
FireBase.prototype.authWithCustomToken = function (token, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.authWithCustomToken failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.authWithCustomToken failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'authWithCustomToken', [token]);
};

//-------------------------------------------------------------------
FireBase.prototype.onDisconnectSetValue = function (url, object, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.onDisconnectSetValue failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.onDisconnectSetValue failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'onDisconnectSetValue', [url], [object]);
};

//-------------------------------------------------------------------
FireBase.prototype.onDisconnectSetValueWithCompletionBlock = function (url, object, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.onDisconnectSetValueWithCompletionBlock failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.onDisconnectSetValueWithCompletionBlock failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'onDisconnectSetValueWithCompletionBlock', [url], [object]);
};

//-------------------------------------------------------------------
FireBase.prototype.onDisconnectRemoveValue = function (url, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.onDisconnectRemoveValue failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.onDisconnectRemoveValue failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'onDisconnectRemoveValue', [url]);
};

//-------------------------------------------------------------------
FireBase.prototype.onDisconnectRemoveValueWithCompletionBlock = function (url, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.onDisconnectRemoveValueWithCompletionBlock failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.onDisconnectRemoveValueWithCompletionBlock failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'onDisconnectRemoveValueWithCompletionBlock', [url]);
};

//-------------------------------------------------------------------
FireBase.prototype.onDisconnectUpdateChildValues = function (url, valueDictionary, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.onDisconnectUpdateChildValues failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.onDisconnectUpdateChildValues failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'onDisconnectUpdateChildValues', [url], [valueDictionary]);
};

//-------------------------------------------------------------------
FireBase.prototype.onDisconnectUpdateChildValuesWithCompletionBlock = function (url, valueDictionary, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.onDisconnectUpdateChildValuesWithCompletionBlock failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.onDisconnectUpdateChildValuesWithCompletionBlock failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'onDisconnectUpdateChildValuesWithCompletionBlock', [url], [valueDictionary]);
};

//-------------------------------------------------------------------
FireBase.prototype.cancelDisconnectOperations = function (url, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.cancelDisconnectOperations failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.cancelDisconnectOperations failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'cancelDisconnectOperations', [url]);
};

//-------------------------------------------------------------------
FireBase.prototype.cancelDisconnectOperationsWithCompletionBlock = function (url, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }

    if (typeof errorCallback != "function") {
        console.log("FireBase.cancelDisconnectOperationsWithCompletionBlock failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("FireBase.cancelDisconnectOperationsWithCompletionBlock failure: success callback parameter must be a function");
        return;
    }

    exec(successCallback, errorCallback, 'FireBase', 'cancelDisconnectOperationsWithCompletionBlock', [url]);
};


var fireBase = new FireBase();
module.exports = fireBase;

    }

    FireBaseLoader(require, exports, module);

    cordova.define("cordova/plugin/FireBase", FireBaseLoader);
