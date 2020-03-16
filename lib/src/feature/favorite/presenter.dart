import 'package:flutter_app/src/data/model/Injector.dart';
import 'package:flutter_app/src/data/model/user_info.dart';

abstract class DataContract {
  void unFavorite(User user);
  void showFavorires(List<User> users);
  void showError(String message);
}

class FavoritePagePresenter {
  DataContract _view;
  UserRepository _repository;

  FavoritePagePresenter(this._view) {
    _repository = new Injector().userRepository;
  }

  void loadFavoritePeople() {
    assert(_view != null);
    _repository.getAllUser().then((users) {
      _view.showFavorires(users);
    }).catchError((onError) {
      _view.showError(onError.toString());
    });
  }
}
