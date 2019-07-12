abstract class BaseService<T> {
  String collection;

  T insert(T entity);

  T update(T entity);

  void delete(T entity);

  T get(List conditions);

  List<T> getList(List conditions);
}
