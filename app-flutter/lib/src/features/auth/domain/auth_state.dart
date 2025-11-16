class AuthState {
  bool loading;
  bool loggedIn;
  Map<String, dynamic>? user;

  AuthState({
    this.loading = false,
    this.loggedIn = false,
    this.user,
  });

  AuthState copyWith({
    bool? loading,
    bool? loggedIn,
    Map<String, dynamic>? user,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      loggedIn: loggedIn ?? this.loggedIn,
      user: user ?? this.user,
    );
  }
}

final authState = AuthState();
