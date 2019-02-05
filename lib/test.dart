import 'package:flutter/services.dart';

void finish(String text) async {
  MethodChannel _methodChannel = MethodChannel('com.example.passwordmanager/sample');
  await _methodChannel.invokeMethod('finish', text);
}

class Sample {
  Future<Intent> getIntent() async {
    MethodChannel _methodChannel = MethodChannel('com.example.passwordmanager/sample');
    return Intent.fromMap(await _methodChannel.invokeMethod('getIntent'));
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
