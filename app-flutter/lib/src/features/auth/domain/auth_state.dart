import '../../../core/models/user_model.dart';

class AuthState {
  bool loading = false;
  String? error;
  UserModel? user;

  void startLoading() {
    loading = true;
    error = null;
  }

  void setUser(UserModel u) {
    user = u;
    loading = false;
    error = null;
  }

  void setError(String message) {
    error = message;
    loading = false;
  }

  void logout() {
    user = null;
  }
}

final authState = AuthState();