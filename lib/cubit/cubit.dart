import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';

import '../moduls/business_screen.dart';
import '../moduls/science_screen.dart';
import '../moduls/sports_screen.dart';
import '../newtork/remotly.dart';

class NewsCubit extends Cubit<NewsAppStates> {
  NewsCubit() : super(NewsIntialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screenItems = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sprots'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];
  void changeBottomIndex(index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> businessList = [];
  List<dynamic> scienceList = [];
  List<dynamic> sportsList = [];
  void getBusinessData() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', quires: {
      "country": "us",
      "category": "business",
      "apiKey": "c4d9193efe1f45719fa9334df79bd702"
    }).then((value) {
      businessList = value.data['articles'];
      emit(NewsBusinessSuccedState());
    }).catchError((e) {
      emit(NewsBusinessFailedState());
    });
  }

  void getSportsData() {
    emit(NewsSportsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', quires: {
      "country": "us",
      "category": "sports",
      "apiKey": "c4d9193efe1f45719fa9334df79bd702"
    }).then((value) {
      sportsList = value.data['articles'];
      emit(NewsSportsSuccedState());
    }).catchError((e) {
      emit(NewsSportsFailedState());
    });
  }

  void getScienceData() {
    emit(NewsScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', quires: {
      "country": "us",
      "category": "science",
      "apiKey": "c4d9193efe1f45719fa9334df79bd702"
    }).then((value) {
      scienceList = value.data['articles'];
      emit(NewsScienceSuccedState());
    }).catchError((e) {
      emit(NewsSienceFailedState());
    });
  }

  List<dynamic> searchList = [];
  void getSearchData(String q) {
    emit(NewsSearchLoadingState());
    DioHelper.getData(
            url: 'v2/everything',
            quires: {"q": "$q", "apiKey": "c4d9193efe1f45719fa9334df79bd702"})
        .then((value) {
      searchList = value.data['articles'];
      emit(NewsSearchSuccedState());
    }).catchError((e) {
      emit(NewsSearchFailedState());
    });
  }
}
