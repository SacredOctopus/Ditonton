import 'package:core/utils/custom_http.dart';
import 'package:http/http.dart' as http;

class SSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await CustomHttp.createLEClient();
  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();
  static Future<void> init() async {
    _clientInstance = await _instance;
  }
}
