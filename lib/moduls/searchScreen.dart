import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';

import '../cubit/states.dart';
import '../shared/component.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(children: [
            Padding(
                padding:const EdgeInsets.all(20),
                child: TextFormField(
                    style: TextStyle(color: Colors.grey),
                    controller: searchController,
                    onChanged: (value) {
                      cubit.getSearchData(value);
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'your search must not be empty ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2)),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'search',
                          style: (searchController.text.isEmpty)
                              ? TextStyle(color: Colors.grey)
                              : TextStyle(color: Colors.orange),
                        )))),
            Expanded(
              child: articleBuilder(cubit.searchList, isearched: true),
            )
          ]),
        );
      },
    );
  }
}
