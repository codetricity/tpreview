import '../theta.dart';

/// status of command. Returns "done", "inProgress", or "error"
Future<String> commandStatus({required String id}) async {
  return await ThetaBase.post('commands/status', body: {'id': id});
}
