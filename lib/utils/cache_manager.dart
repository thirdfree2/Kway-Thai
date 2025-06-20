import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager extends CacheManager {
  CustomCacheManager()
      : super(
          Config(
            key,
            maxNrOfCacheObjects: 20,
            stalePeriod: const Duration(days: 7),
          ),
        );
  static const key = "customCache";
}
