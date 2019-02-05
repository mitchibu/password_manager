import 'package:flutter/services.dart';

class Sample {
  Future<Intent> getIntent() async {
    MethodChannel _methodChannel = MethodChannel('com.example.passwordmanager/sample');
    Map<dynamic, dynamic> result = await _methodChannel.invokeMethod('getIntent');
    print('result: $result');
    return Intent.fromMap(result);
  }
}

class Intent {
  Intent({
    this.action
  });

  factory Intent.fromMap(Map map) => Intent(
    action: map['action']
  );

  final String action;
}
