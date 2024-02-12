import 'package:flutter_dotenv/flutter_dotenv.dart';

late BuildVariables _buildVariables;

BuildVariables get buildVariables => _buildVariables;

class BuildVariables {
  final String baseUrl;
  final String encKey;
  final String encVector;

  BuildVariables._init({
    required this.baseUrl,
    required this.encKey,
    required this.encVector,
  });

  static void init() {
    _buildVariables = BuildVariables._init(
      baseUrl: dotenv.env['BASE_URL'] ?? '',
      encKey: dotenv.env['ENC_KEY'] ?? '',
      encVector: dotenv.env['ENC_VECTOR'] ?? '',
    );
  }
}
