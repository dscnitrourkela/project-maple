import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  late RemoteConfig remoteConfig;
  Future<RemoteConfig> setupRemoteConfig() async {
    try {
      remoteConfig = RemoteConfig.instance;
      remoteConfig.setDefaults(<String, dynamic>{
        'api_url': 'https://aptiche.dscnitrourkela.org/graphql',
        'api_key': 'SriramForTheDiro'
      });
      await remoteConfig.ensureInitialized();
      await remoteConfig.fetchAndActivate();

      return remoteConfig;
    } catch (e) {
      rethrow;
    }
  }

  String get apiUrl => remoteConfig.getString('api_url');

  String get apiKey => remoteConfig.getString('api_key');
}
