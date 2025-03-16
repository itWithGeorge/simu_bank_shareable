import 'package:simu_bank_messages/messages.dart' as msg;

abstract class ApiClient {
  Future<msg.LoginResponse> login(msg.LoginRequest requestParams);
  Future<msg.TransactionListResponse>load({required msg.TransactionListRequest requestParams});
}
