import 'package:appwrite/appwrite.dart';
import 'package:posay/core/config/appwrite_config.dart';

class AppwriteClient {
  late Client _client;
  AppwriteConfig appwriteConfig;

  AppwriteClient(this.appwriteConfig) {
    _client = Client()
        .setEndpoint(appwriteConfig.apiEndPoint)
        .setProject(appwriteConfig.projectId)
        .setSelfSigned();
  }

  Client setAppWriteConfig() {
    return _client;
  }
}
