import 'package:flutter_app/src/data/model/Injector.dart';
import 'package:flutter_app/src/data/model/user_info.dart';

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
