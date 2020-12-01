
import '../core/responses/response_defult.dart';

abstract class IAuthRepository {
  Future<DefaultResponse> signIn();
  Future<DefaultResponse> signOut();
}