import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:human_resources/features/user_profile/repository/user_repository.dart';
import 'package:human_resources/models/user.dart';
import 'package:human_resources/models/user_auth.dart';
import 'package:human_resources/network/user_api_provider.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthRepository {
  late UserAuth userAuth;
  late User user;
  late Dio client;
  late String devid;
  late String devmodel;

  Future<String> getUserInfo(String email, String password) async {
    await initPlatformState();
    UserApi userApi = UserApi();
    // TODO:error massage
    try {
      Response res =
          await userApi.Authenticate(email, password, devid, devmodel);
      Map<String, dynamic> jsons = json.decode(res.data);
      if (jsons['error'] == "true") {
        // return jsons['result']['error_msg_en'];
        return jsons['error'];
      }
      userAuth = UserAuth.fromJson(jsons['result']);
      print(userAuth.t);
      Response userres = await userApi.fetchUserInfo(userAuth.t, devid);
      Map<String, dynamic> userress = json.decode(userres.data);
      if (userress['status'] == "true") {
        // return jsons['result']['error_msg_en'];
        return userress['status'];
      }
      // print(userress["result"].runtimeType);
      user = User.fromJson(userress["result"]);
      // print(user.email);
      // print(user.name);
      var loginData = await SharedPreferences.getInstance();
      loginData.setString('email', user.email);
      loginData.setString('name', user.name);
      loginData.setString('img', user.img);
      loginData.setString('id', user.id);
      loginData.setString('status', user.status);
      loginData.setInt('token', userAuth.t);
      loginData.setBool('login', false);
      return jsons['error'];
    } on Exception catch (e) {
      return 'connection error';
    }
    return 'error';
  }

  Future<bool> getUserPassword(String email) async {
    await initPlatformState();
    UserApi userApi = UserApi();
    // TODO:fix function inputs
    Response response = await userApi.forgetPasswordEmail(email, devid);
    String resBody = response.data;
    Map<String, dynamic> jsonFormat = json.decode(resBody);
    bool changed = true;
    if (jsonFormat['login'] == false) {
      changed = false;
    } else if (jsonFormat['status'] == false) {
      changed = false;
    }
    return changed;
  }

  Future<Map<String, dynamic>> initPlatformState() async {
    var deviceData = <String, dynamic>{};
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        devmodel = deviceData['model'];
        devid = deviceData['androidId'];
        print(devmodel);
        print(devid);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        devmodel = deviceData['model'];
        devid = deviceData['identifierForVendor'];
        print(devmodel);
        print(devid);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    return deviceData;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
