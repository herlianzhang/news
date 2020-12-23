import 'package:news/src/bloc_helpers/bloc_provider.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

export 'package:news/src/bloc_helpers/bloc_provider.dart';

class StoriesBloc extends BlocBase {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  Stream<List<int>> get topIds => _topIds.stream;

  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  Future<void> fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  ScanStreamTransformer<int, Map<int, Future<ItemModel>>> _itemsTransformer() {
    return ScanStreamTransformer(
      (cache, id, index) {
        print(index);
        cache[id] = _repository.fetchitem(id);
        return cache;
      },
      {},
    );
  }

  clearCache() {
    return _repository.clearCache();
  }

  @override
  void dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}
