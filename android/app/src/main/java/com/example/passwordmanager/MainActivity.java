package com.example.passwordmanager;

import android.content.Intent;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), "com.example.passwordmanager/sample").setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        switch(methodCall.method) {
        case "getIntent":
          result.success(onGetIntent());
          break;
        }
      }
    });
  }

  private Map<String, Object> onGetIntent() {
    Map<String, Object> map = new HashMap<>();
    Intent intent = getIntent();
    map.put("action", intent.getAction());
    map.put("uri", intent.getDataString());

    Bundle bundle = intent.getExtras();
    Map<String, Object> extras = new HashMap<>();
    Set<String> keys = bundle.keySet();
    for(String key : keys) {
      extras.put(key, bundle.get(key));
    }
    map.put("extras", extras);
    return map;
  }
}
