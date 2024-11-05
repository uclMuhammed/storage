import 'package:backend/backend.dart';

abstract class BaseService {
  final HttpManager stockAuthManager = HttpManager(
    baseUrl: stockTrackerAuthUrl,
    headers: stockApiHeader,
  );
  /*final HttpManager stockManager = HttpManager(
    baseUrl: stockTrackerApiUrl,
    headers: headerWithToken(),
  ); */
}
