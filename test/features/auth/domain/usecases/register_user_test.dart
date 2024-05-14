import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uptodo/features/auth/domain/repository/auth_repo.dart';
import 'package:uptodo/features/auth/domain/usecases/register_user.dart';

// What does this class depend on => AuthRepository
// How can we create a fake version of that dependency => Mocktail
// How do we control what our fake dependencies do => Mocktail's APIs

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late RegisterUser usecase;
  late AuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    usecase = RegisterUser(repository);
  });

  final params = RegisterUserParams.empty();

  test(
    "should call the [AuthRepository.registerUser]",
    () async {
      // Arrange
      when(
        () => repository.registerUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          emailId: any(named: 'emailId'),
        ),
      ).thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase.call(params);

      // Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => repository.registerUser(
          createdAt: params.createdAt,
          name: params.name,
          emailId: params.emailId,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
