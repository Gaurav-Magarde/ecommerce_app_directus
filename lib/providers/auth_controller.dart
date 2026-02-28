import 'dart:async';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';

final authControllerProvider = AsyncNotifierProvider<AuthController, User?>(
      () => AuthController(),
);

class AuthController extends AsyncNotifier<User?> {

// Sign up the user
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final api = ref.read(apiServiceProvider);
      await api.signUp(email: email, password: password, name: name);
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        throw Exception(e.response!.data['errors'][0]['message']);
      }
      rethrow;
    }
  }

// Login Existing user
  Future<void> login({required String email, required String password}) async {
    try {
      final api = ref.read(apiServiceProvider);
      return await api.loginWithEmailAndPass(email: email, password: password);
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        throw Exception(e.response!.data['errors'][0]['message']);
      }
      rethrow;
    }
  }

// logging out the user
  Future<void> logOut() async {
    try {
      final api = ref.read(apiServiceProvider);
      await api.logout();
      state = AsyncData(null);
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        throw Exception(e.response!.data['errors'][0]['message']);
      }
      rethrow;
    }
  }

  @override
  Future<User?> build() async {
    try {
      // login the current user if token exists
      final api = ref.read(apiServiceProvider);
      return await api.tokenLogin();
    } catch (e) {
      return null;
    }
  }
}