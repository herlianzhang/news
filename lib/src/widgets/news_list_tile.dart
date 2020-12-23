import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/widgets/loading_container.dart';

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
          return LoadingContainer();
        }
        return FutureBuilder<ItemModel>(
            future: snapshot.data[itemId],
            builder: (context, itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return LoadingContainer();
              }
              return buildTile(itemSnapshot.data);
            });
      },
    );
  }

  Widget buildTile(ItemModel item) {
    return Column(
      children: [
        ListTile(
          title: Text('${item.title}'),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: [
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
        ),
        Divider(height: 8),
      ],
    );
  }
}
