import 'dart:convert';
import 'package:fav_movies/core/external/api/api_request_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> loadAppEnvironment() async {
  try{
    final credentials = jsonDecode(await rootBundle
      .loadString('.env/api_credentials.json'));
      
    baseUrl = credentials['base_url'];
    accessToken = credentials['access_token'];
    apiKey = credentials['api_key'];
  }catch(e){
    debugPrint(e.toString());
  }
}
