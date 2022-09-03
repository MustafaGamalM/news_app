import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/newtork/cacheHelper.dart';
import 'package:news_app/shared/theme.dart';
import 'package:news_app/cubit/blocObserver.dart';
import 'package:news_app/theme_cubit/states.dart';

import 'cubit/cubit.dart';
import 'layout/news_layout.dart';
import 'newtork/remotly.dart';
import 'theme_cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CasheHelper.inite();
  bool theme = CasheHelper.getBoolData(key: 'isDark');
  BlocOverrides.runZoned(
    () => runApp(MyApp(theme)),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusinessData()
            ..getScienceData()
            ..getSportsData(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeThemeMode(boolTheme: isDark),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter NewsApp',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: NewsLayout(),
            );
          }),
    );
  }
}
