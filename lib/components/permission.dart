import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';

class Permissions {
  static PermissionHandlerPlatform get _handler => PermissionHandlerPlatform.instance;

  static Future<bool> notificationPermissionsGranted() async {
    PermissionStatus notificationStatus = await _getNotificationPermission();

    if (notificationStatus == PermissionStatus.granted) {
      return true;
    } else {
      _handleInvalidPermissions(notificationStatus);
      return false;
    }
  }

  static Future<PermissionStatus> _getNotificationPermission() async {
    PermissionStatus permission = await _handler.checkPermissionStatus(Permission.notification);
    if (permission != PermissionStatus.granted) {
      Map<Permission, PermissionStatus> permissionStatus = await _handler.requestPermissions([Permission.notification]);
      return permissionStatus[Permission.notification] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
  }

  static void _handleInvalidPermissions(PermissionStatus notificationPermissionStatus) {
    if (notificationPermissionStatus == PermissionStatus.denied) {
      throw new PlatformException(code: "PERMISSION_DENIED", message: "Access to camera and microphone denied", details: null);
    } else if (notificationPermissionStatus == PermissionStatus.denied) {
      throw new PlatformException(code: "PERMISSION_DISABLED", message: "Location data is not available on device", details: null);
    }
  }

  static void notificationPermissions() async {
    PermissionStatus status = await Permission.notification.status;
    if (status.isGranted) {
      await Permission.notification.request();
    }
  }
}
