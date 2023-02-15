import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../api/category_api.dart';
import 'db.dart';

final GetIt di = GetIt.instance;

void setup() {
  di.registerLazySingleton(() => Db());
  // di.registerSingleton(Db());
  // di.registerFactory(() => Db());
  di.registerLazySingleton(() => CategoryAndProductApi(Dio(),),
  );
}
