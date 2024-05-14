abstract class AuthRemoteDataSource {
  Future<String> registerUser({
    required DateTime createdAt,
    required String name,
    required String emailId,
  });

  Future<String> loginUser({
    required String emailId,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // TODO: Get Firebase Dependency

  @override
  Future<String> loginUser({required String emailId, required String password}) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<String> registerUser({required DateTime createdAt, required String name, required String emailId}) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }
}
