import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gymapp/Constants/Constants.dart';
import 'package:gymapp/Models/GymModel.dart';
import 'package:gymapp/Providers/LocationProvider.dart';
import 'package:gymapp/Request/NetworkRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider extends ChangeNotifier {
  late Future<List<GymModel>> gyms;
  List<GymModel>? allGyms;
  final LocationProvider? _locationProvider;
  final int limit = 10;

  DataProvider(this._locationProvider,String? query) {

    if (_locationProvider != null) {
      _locationProvider?.locationDataModel.then((value) {
        final position = value.position;
        if (position != null) {
          // print("${position.longitude}Hello");
          gyms = getData(lat: position.latitude, lng: position.longitude);
          if(query!=null){
            gyms.then((value) => search(query));
          }
        }
      });
    }
    gyms = Future.delayed(const Duration(seconds: 2), () => []);
  }

  Future<List<GymModel>> getData(
      {required double lat, required double lng}) async {
    final url = Constants.getData(page: 1, limit: limit, lat: lat, lng: lng);
    return await NetworkRequest.getData(url: url).then((response) async {
      if (response['status'] == true) {
        final gymsData = response['data']['data'] as List;
        final gyms = gymsData.map((e) => GymModel.fromMap(e)).toList();
        notifyListeners();
        return Future.value(gyms);
      }
      return Future.error("Error Occur");
    }).onError((error, stackTrace) {
      return Future.error('$error');
    });
  }

  Future<bool> loadMoreData(
      {required double lat, required double lng, required int page}) async {
    final url = Constants.getData(page: page, limit: limit, lat: lat, lng: lng);
    return await NetworkRequest.getData(url: url).then((response) async {
      if (response['status'] == true) {
        final status = response['data']['status'];
        if (status) {
          final gymsData = response['data']['data'] as List;
          final list = gymsData.map((e) => GymModel.fromMap(e)).toList();
          await appendElements(gyms, list);
          allGyms?.addAll(list);
          notifyListeners();
          return Future.value(true);
        } else {
          return Future.value(false);
        }
      }
      return Future.error("Error Occur");
    }).onError((error, stackTrace) {
      return Future.error('$error');
    });
  }

  Future<List<GymModel>> appendElements(
      Future<List<GymModel>> listFuture, List<GymModel> elementsToAdd) async {
    final list = await listFuture;
    list.addAll(elementsToAdd);
    return list;
  }


  Future<void> search(String query) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('query', query);
    final initialList = await gyms;
    allGyms ??= List.from(initialList);
    if(query.isEmpty){
      gyms = Future.value(allGyms);
      notifyListeners();
      return ;
    }
    final searchList = allGyms?.where((element) => element.gymName.toString().toLowerCase().startsWith(query) || element.gymName.toString().toLowerCase().contains(query)).toList();
    gyms = Future.value(searchList);
    notifyListeners();
  }
}
