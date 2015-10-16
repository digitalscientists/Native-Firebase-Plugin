//
//  Copyright 2015 Firebase Plugin
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//

package com.phonegap.plugins.Firebase;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.apache.cordova.PluginResult.Status;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.firebase.client.DataSnapshot;
import com.firebase.client.Firebase;
import com.firebase.client.FirebaseError;
import com.firebase.client.ValueEventListener;

//import android.app.Activity;
//import android.content.Intent;
//import android.util.Log;



public class CDVFirebase extends CordovaPlugin {
	public static final int REQUEST_CODE = 0x0abbc0de;
	
    public static final String READDATAONCEWITHURL = "readDataOnceWithURL";
    public static final String CANCEL = "cancel";

    
    private CallbackContext mCallbackContext;

    /**
     * Constructor.
     */
    public CDVFirebase() {
    	
    }
    
    @Override
    protected void pluginInitialize() {
    	com.firebase.client.Firebase.setAndroidContext(this.cordova.getActivity().getApplicationContext());
    };
    /**
     * Executes the request.
     *
     * This method is called from the Web. To do a non-trivial amount of work, use:
     *     cordova.getThreadPool().execute(runnable);
     *
     *
     * @param action          The action to execute.
     * @param args            The exec() arguments.
     * @param callbackContext The callback context used when calling back into JavaScript.
     * @return                Whether the action was valid.
     *
     * @sa https://github.com/apache/cordova-android/blob/master/framework/src/org/apache/cordova/CordovaPlugin.java
     */
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) {
        PluginResult result = null;

        if (action.equals(READDATAONCEWITHURL)) {
            mCallbackContext = callbackContext;
            readDataOnceWithURL(args);
            result = new PluginResult(Status.NO_RESULT);
            result.setKeepCallback(true);
            return true;
        } else if (action.equals(CANCEL)) {
            //cancel(args);
            return true;
        } else {
            result = new PluginResult(Status.INVALID_ACTION);
            callbackContext.error("Invalid Action: " + action);
            return false;
        }
    }
    private void readDataOnceWithURL(JSONArray data) {
    	
        String strURL = "https://%@.firebaseio.com"; // = "https://%@.firebaseio.com" + appName;
        
        if ( data.length() >= 1 )
        {
        	try {
				strURL = data.getString(0);
			} catch (JSONException e) {
				mCallbackContext.error("Error");	        	
				e.printStackTrace();
				return;
			} 
        }
        else{
        	mCallbackContext.error("Error");
        	return;
        }
        
        Firebase myRootRef = new Firebase(strURL);
//        if(isUsed != YES)
//            isUsed = YES;
        // Read data and react to changes
        myRootRef.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                System.out.println(snapshot.getValue());
                JSONObject array;
				try {
					array = new JSONObject(snapshot.getValue().toString());
	                mCallbackContext.success(array);
				} catch (JSONException e) {
					mCallbackContext.error("Error");					
					e.printStackTrace();
				}
            }
            
            @Override
            public void onCancelled(FirebaseError firebaseError) {
                System.out.println("The onDataChange failed: " + firebaseError.getMessage());
                mCallbackContext.error("Error");
            }
        });
        
    }

    
//    @Override
//    public void onActivityResult(int requestCode, int resultCode, Intent data) {
//        ScanditSDKResultRelay.setCallback(null);
//        if (resultCode == ScanditSDKActivity.SCAN || resultCode == ScanditSDKActivity.MANUAL) {
//            String barcode = data.getExtras().getString("barcode");
//            String symbology = data.getExtras().getString("symbology");
//            JSONArray args = new JSONArray();
//            args.put(barcode);
//            args.put(symbology);
//            mPendingOperation = false;
//            mHandler.stop();
//            mCallbackContext.success(args);
//            
//        } else if (resultCode == ScanditSDKActivity.CANCEL) {
//            mPendingOperation = false;
//            mHandler.stop();
//            mCallbackContext.error("Canceled");
//        }
//    }
    
//    @Override
//    public void onResultByRelay(Bundle bundle) {
//        String barcode = bundle.getString("barcode");
//        String symbology = bundle.getString("symbology");
//        JSONArray args = new JSONArray();
//        args.put(barcode);
//        args.put(symbology);
//        PluginResult result = new PluginResult(Status.OK, args);
//        if (mContinuousMode) {
//            result.setKeepCallback(true);
//        } else {
//            mPendingOperation = false;
//            mHandler.stop();
//        }
//        mCallbackContext.sendPluginResult(result);
//    }

}