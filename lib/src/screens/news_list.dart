import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'package:news/src/widgets/news_list_tile.dart';
import 'package:news/src/widgets/refresh.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StoriesBloc>(context);

    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder<List<int>>(
      stream: bloc.topIds,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // print('${snapshot.data}');
        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              bloc.fetchItem(snapshot.data[index]);
              return NewsListTile(
                itemId: snapshot.data[index],
              );
            },
          ),
        );
      },
    );
  }
}
