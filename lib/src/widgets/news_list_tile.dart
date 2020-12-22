import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StoriesBloc>(context);
    return Container();
  }
}
