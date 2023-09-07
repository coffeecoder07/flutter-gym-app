import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

enum LocationStatus {
  serviceNotAvailable,
  permissionDenied,
  permissionDeniedForever,
  pending,
  active
}

class LocationDataModel {
  final LocationStatus locationStatus;
  final List<Placemark>? placeMark;
  final Position? position;

  LocationDataModel({required this.locationStatus, this.placeMark,this.position});
}

class LocationProvider extends ChangeNotifier {
  late Future<LocationDataModel> locationDataModel;

  LocationProvider() {
    locationDataModel = getPosition();
  }

  Future<LocationDataModel> getPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationDataModel(locationStatus: LocationStatus.serviceNotAvailable);
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationDataModel(locationStatus: LocationStatus.permissionDenied);
      }
    }


    if (permission == LocationPermission.deniedForever) {
      return LocationDataModel(locationStatus: LocationStatus.permissionDeniedForever);
    }
    final position = await Geolocator.getCurrentPosition();
    // position.

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );


    // final WeatherModel? weatherModel = await AdminApis.getWeather(lat: '${position.latitude}', lon: '${position.longitude}');


    return LocationDataModel(locationStatus: LocationStatus.active,placeMark: placemarks,position: position) ;
  }

  void openLocationSettings() => Geolocator.openLocationSettings();

  void openAppSettings() => Geolocator.openAppSettings();
}
