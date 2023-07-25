import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

enum FormFactorType { monitor, phone, tablet }

class DeviceOS {
  ///Приложение запущено на IOS
  static bool isIOS = UniversalPlatform.isIOS;

  ///Приложение запущено на Android
  static bool isAndroid = UniversalPlatform.isAndroid;

  ///Приложение запущено на MacOS
  static bool isMacOS = UniversalPlatform.isMacOS;

  ///Приложение запущено на Linux
  static bool isLinux = UniversalPlatform.isLinux;

  ///Приложение запущено на Windows
  static bool isWindows = UniversalPlatform.isWindows;

  ///Приложение запущено в браузере
  static bool isWeb = kIsWeb;

  ///Приложение запущено на рабочем столе
  static bool get isDesktop => isWindows || isMacOS || isLinux;

  /// Приложение запущено на мобильном телефоне.
  static bool get isMobile => isAndroid || isIOS;

  /// Приложение запущено на компьютере или веб.
  static bool get isDesktopOrWeb => isDesktop || isWeb;

  /// Приложение запущено на мобильном телефоне или веб.
  static bool get isMobileOrWeb => isMobile || isWeb;
}

class Device {
  // Откуда брал пограничные значения https://docs.microsoft.com/en-us/windows/apps/design/layout/screen-sizes-and-breakpoints-for-responsive-design
  static FormFactorType get(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.width;
    if (shortestSide <= maxPhoneBreakpoint) return FormFactorType.phone;
    if (shortestSide >= minTabletBreakpoint && shortestSide <= maxTabletBreakpoint) return FormFactorType.tablet;
    if (shortestSide >= minMonitorBreakpoint) return FormFactorType.monitor;
    return FormFactorType.monitor;
  }

  static int minPhoneBreakpoint = 0;
  static int maxPhoneBreakpoint = 694;
  static int minTabletBreakpoint = 694;
  static int maxTabletBreakpoint = 1009;
  static int minMonitorBreakpoint = 1009;
  static int maxMonitorBreakpoint = 4009;

  // Shortcuts for various mobile device types

  static bool isPhone(BuildContext context) => get(context) == FormFactorType.phone;

  static bool isTablet(BuildContext context) => get(context) == FormFactorType.tablet;

  static bool isMonitor(BuildContext context) => get(context) == FormFactorType.monitor;
}

class Screen {
  static double get _ppi => (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) ? 150 : 96;

  static bool isLandscape(BuildContext c) => MediaQuery.of(c).orientation == Orientation.landscape;

  //PIXELS
  static Size size(BuildContext c) => MediaQuery.of(c).size;

  static double width(BuildContext c) => size(c).width;

  static double height(BuildContext c) => size(c).height;

  static double diagonal(BuildContext c) {
    final s = size(c);
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  //INCHES
  static Size inches(BuildContext c) {
    final pxSize = size(c);
    return Size(pxSize.width / _ppi, pxSize.height / _ppi);
  }

  static double widthInches(BuildContext c) => inches(c).width;

  static double heightInches(BuildContext c) => inches(c).height;

  static double diagonalInches(BuildContext c) => diagonal(c) / _ppi;
}
