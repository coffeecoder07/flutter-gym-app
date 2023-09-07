import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:gymapp/Constants/Constants.dart';
import 'package:http/http.dart' as http;

class NetworkRequest {
  static Future getData({required String url}) async {
    log(url);
    final client = http.Client();
    try {
      final response = await client.get(Uri.parse(url), headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer ${Constants.token}',
      });
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Future.value({'status': true, 'data': data});
      }
      return Future.error({'status': false, 'message': 'Error Message'});
    } on SocketException {
      return Future.error(
          {'status': false, 'message': 'No Internet connection 😑'});
    } on HttpException {
      return Future.error(
          {'status': false, 'message': "Couldn't find the post 😱"});
    } on FormatException {
      return Future.error(
          {'status': false, 'message': "Bad response format 👎"});
    } catch (e) {
      log('${e.toString()} $url');
      return Future.error(
          {'status': false, 'message': 'Something Went Wrong.'});
    } finally {
      client.close();
    }
  }

}
