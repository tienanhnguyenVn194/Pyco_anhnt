import 'package:flutter_app/src/data/model/user_info.dart';
import 'package:flutter_app/src/data/model/user_infor_impl.dart';

abstract class Controls {
  void showPeople(User user);
  void showFavoritePeople();
  void showError(String message);
}

class MediaPresenter {
  Controls _view;
  UserRepository _repository;

  MediaPresenter(this._view) {
    _repository = new Injector().userRepository;
  }

  void nextPeople() {
    assert(_view != null);
    _repository.fetchUser().then((user) {
      _view.showPeople(user);
    }).catchError((onError) {
      _view.showError(onError.toString());
    });
  }

  void addFavorite(User user) {
    print("Add to favorite");
    _repository.createUser(user);
    _repository.fetchUser().then((user) {
      _view.showPeople(user);
    }).catchError((onError) {
      _view.showError(onError.toString());
    });
  }
}

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