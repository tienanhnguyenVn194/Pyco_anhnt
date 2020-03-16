import 'package:flutter_app/src/data/model/user_info.dart';
import 'package:flutter_app/src/data/model/user_infor_impl.dart';

enum Flavor { MOCK, PROD }

class Injector {
  static final Injector _singleton = Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  UserRepository get userRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return RandomUserRepository();
      default:
        return RandomUserRepository();
    }
  }
}
