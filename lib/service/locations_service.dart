import 'dart:async';

import 'package:geolocator/geolocator.dart';

typedef PositionCallback = void Function(Position position);
class LocationsService {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
late StreamSubscription<Position>  _positionStream;
  bool isAccessGranted(LocationPermission permission)  {
    return permission==LocationPermission.whileInUse || permission==LocationPermission.always;
  }

  Future<bool> requestPermission() async {
    LocationPermission permission = await _geolocatorPlatform.checkPermission();
    if(isAccessGranted(permission)) {
      return true;
    }
    permission = await _geolocatorPlatform.requestPermission();
    return isAccessGranted(permission);
  }

 Future<void> startPositionStream(Function(Position position) callBack) async {
    bool permissionGranted = await requestPermission();
    if(!permissionGranted) {
     throw Exception('Permission not granted');
    }

 _positionStream= _geolocatorPlatform.getPositionStream(
     locationSettings: const LocationSettings(
       accuracy: LocationAccuracy.bestForNavigation
     )
   ).listen((callBack));
  }
  Future<void> stopPositionStream() async {
    await _positionStream.cancel();
  }


}