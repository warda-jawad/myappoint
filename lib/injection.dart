import 'package:get_it/get_it.dart';

import 'data/dataBase/data_base_handler.dart';

GetIt sl = GetIt.instance;
Future initGetIt() async {
  sl.registerFactory(() => DatabaseHandler());
}
