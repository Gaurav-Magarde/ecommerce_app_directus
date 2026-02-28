import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/services/secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user.dart';

final apiServiceProvider = Provider<_ApiService>((ref){
  return _ApiService(ref);
});
class _ApiService {
  //base user for the local
  static final String _baseUrl = 'http://127.0.0.1:8055';
  // Dio for Api calls
  late final Dio _dio;
  final Ref ref;
  _ApiService(this.ref): _dio = Dio(BaseOptions(baseUrl: _baseUrl, headers: {'Content-Type': 'application/json'},));


  //Login with Email and pass first time / token Expired
  Future<void> loginWithEmailAndPass({required String email,required String password})async {
    try{
      // login
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password
      });

      // Authorized token
      final token = response.data['data']['access_token'];
      final refreshToken = response.data['data']['refresh_token'];


      await ref.read(secureStorageProvider).setAccessToken(token);
      await ref.read(secureStorageProvider).setRefreshToken(refreshToken);

      //Updates the last first and login time
      await _updateDates(token: token);

    }catch(e){
      rethrow ;
    }
  }
  Future<User?> tokenLogin()async {
    try{

      final token = await ref.read(secureStorageProvider).getAccessToken();

      if(token==null) return null;

      //verify token login
     final response = await _dio.get('/users/me',options: Options(headers: {'Authorization' : 'Bearer $token'}));
      final userMap = Map<String,dynamic>.from(response.data['data']);

      //Updates the last first and login time
      await _updateDates(token: token);

      return User.fromMap(userMap);
    }catch(e){
      rethrow ;
    }
  }

  Future<void> signUp({required String email,required String password,required String name})async {
    try{

      //SignUp user for first time
      await _dio.post('/users', data: { 'email': email,
        'password': password,
        'first_name': name});

      //First login
      await loginWithEmailAndPass(email: email, password: password);
    }catch(e){
      rethrow;
    }
  }

  Future<void> _updateDates({required String token}) async{
    try{
      //current
      final String now = DateTime.now().toIso8601String();
      final response = await _dio.get('/users/me',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      final userData = response.data['data'];
      Map<String,dynamic> updatedData = {
        'last_login_at' : now
      };
      if(userData['first_login_at']==null){
        updatedData['first_login_at'] = now;
      }

      //update the login dates
      await _dio.patch('/users/me',data:updatedData,options: Options(headers: {'Authorization' : 'Bearer $token'}));

    }catch(e){
      rethrow;
    }
  }

  Future<List<Map>> getProducts({required Map<String,dynamic> filter}) async {
    try{


      Map<String, dynamic> queryParams = {
        'fields': '*,categories.name'
      };
      if (filter.isNotEmpty) {
        queryParams['filter'] = jsonEncode(filter);
      }
      final response = await _dio.get('/items/products',options: Options(),queryParameters: queryParams);
      final list  =  response.data['data'];

      List<Map> productMap =  List<Map<String, dynamic>>.from(list);
      return productMap.map((map){
        map['image_url'] = '$_baseUrl/assets/${map['image']}';
        return map;
      }).toList();
    }catch(e){
      rethrow;
    }
  }
  Future<List<CategoryModel>> getCategories() async {
    try{
      final response = await _dio.get('/items/categories',options: Options());
      final rawData = List.from(response.data['data']);
      return rawData.map((category)=>CategoryModel.fromMap(category)).toList();
    }catch(e){
      rethrow;
    }
  }

  Future<void> logout() async {
    try{
      final token = await ref.read(secureStorageProvider).getRefreshToken();
      if(token==null) return;
      await _dio.post('/auth/logout', options: Options(headers: {'Authorization' : 'Bearer $token'}));
      await ref.read(secureStorageProvider).clearAccessToken();
    }catch(e){
      rethrow;
    }
  }


}