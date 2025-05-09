# fcm

## System Prerequisites
```shell
$ flutter doctor -v
[✓] Flutter (Channel stable, 3.29.3, on macOS 15.4.1 24E263 darwin-arm64, locale zh-Hans-CN) [726ms]
    • Flutter version 3.29.3 on channel stable at /Users/clee/src/flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision ea121f8859 (4 周前), 2025-04-11 19:10:07 +0000
    • Engine revision cf56914b32
    • Dart version 3.7.2
    • DevTools version 2.42.3
    • Pub download mirror https://pub.flutter-io.cn
    • Flutter download mirror https://storage.flutter-io.cn

[✓] Android toolchain - develop for Android devices (Android SDK version 36.0.0) [3.8s]
    • Android SDK at /Users/clee/Library/Android/sdk
    • Platform android-35, build-tools 36.0.0
    • Java binary at: /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home/bin/java
      This JDK is specified in your Flutter configuration.
      To change the current JDK, run: `flutter config --jdk-dir="path/to/jdk"`.
    • Java version OpenJDK Runtime Environment Homebrew (build 17.0.15+0)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 16.3) [2.4s]
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Build 16E140
    • CocoaPods version 1.16.2

[✓] Chrome - develop for the web [19ms]
    • Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

[✓] Android Studio (version 2024.3) [18ms]
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 21.0.6+-13355223-b631.42)

[✓] VS Code (version 1.99.3) [17ms]
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension version 3.60.0

[✓] VS Code (version 1.85.2) [16ms]
    • VS Code at /Applications/Visual Studio Code_副本.app/Contents
    • Flutter extension version 3.60.0

[✓] VS Code (version 1.85.2) [16ms]
    • VS Code at /Users/clee/Downloads/Visual Studio Code.app/Contents
    • Flutter extension version 3.60.0

[✓] Proxy Configuration [55ms]
    • HTTP_PROXY is set
    • NO_PROXY is localhost,127.0.0.1,::1
    • NO_PROXY contains localhost
    • NO_PROXY contains 127.0.0.1
    • NO_PROXY contains ::1

[✓] Connected device (4 available) [13.2s]    
    • sdk gphone64 arm64 (mobile)     • emulator-5554         • android-arm64  • Android 14 (API 34) (emulator)
    • macOS (desktop)                 • macos                 • darwin-arm64   • macOS 15.4.1 24E263 darwin-arm64
    • Mac Designed for iPad (desktop) • mac-designed-for-ipad • darwin         • macOS 15.4.1 24E263 darwin-arm64
    • Chrome (web)                    • chrome                • web-javascript • Google Chrome 136.0.7103.93

[✓] Network resources [1,477ms]
    • All expected network resources are available.

• No issues found!
```

## Getting Started
```shell
$ flutter clean

$ flutter pub get

$ flutter run
```

![image](img/notification.png)

![image](img/fcm_token.png)

![image](img/gms_state.png)