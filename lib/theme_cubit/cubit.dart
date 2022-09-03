import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/newtork/cacheHelper.dart';
import 'package:news_app/theme_cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());
  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark = false;
  void changeThemeMode({bool boolTheme}) {
    if (boolTheme != null) {
      isDark = boolTheme;
      emit(AppChangeThemeState());
    } else {
      isDark = !isDark;
      CasheHelper.setBoolData(key: 'isDark', value: isDark).then((e) {
        emit(AppChangeThemeState());
      });
    }
  }
}
