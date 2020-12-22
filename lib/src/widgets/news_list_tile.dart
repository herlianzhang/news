import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'package:news/src/models/item_model.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StoriesBloc>(context);
    return StreamBuilder<Map<int, Future<ItemModel>>>(
      stream: bloc.items,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Stream still loading');
        }
        return FutureBuilder<ItemModel>(
          future: snapshot.data[itemId],
          builder: (context, itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Future not have any data');
            }
            return Text(itemSnapshot.data.title);
          }
        );
      },
    );
  }
}
