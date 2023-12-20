import 'package:rxdart/rxdart.dart';


//store data for all fackRepository in all app
class InMemoryStore<T> {
  InMemoryStore(initial) : _subject = BehaviorSubject<T>.seeded(initial);
  final BehaviorSubject<T> _subject;

  Stream<T> get stream => _subject.stream;

  T get value => _subject.value;

  set value(T value) => _subject.add(value);

  void close() => _subject.close();
}
