import 'package:news/src/bloc_helpers/bloc_provider.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

export 'package:news/src/bloc_helpers/bloc_provider.dart';

class StoriesBloc extends BlocBase {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();

  Stream<Map<int, Future<ItemModel>>> items;

  Stream<List<int>> get topIds => _topIds.stream;

  Function(int) get fetchItem => _items.sink.add;

  StoriesBloc() {
    items = _items.stream.transform(_itemsTransformer());
  }

  void fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  ScanStreamTransformer<int, Map<int, Future<ItemModel>>> _itemsTransformer() {
    return ScanStreamTransformer(
      (cache, id, _) {
        cache[id] = _repository.fetchitem(id);
        return cache;
      },
      {},
    );
  }

  @override
  void dispose() {
    _topIds.close();
    _items.close();
  }
}
