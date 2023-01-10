abstract class IRepository<TEntity> {
  Future<TEntity> create(TEntity entity);
  Future<TEntity> update(TEntity entity);
  Future<TEntity> delete(TEntity entity);
  Future<List<TEntity>>? getAll();
  Future<TEntity> getById(String id);
  Future<TEntity> findByExpression(bool Function(TEntity entity) expression);
}

abstract class ICommandRepository<TEntity> {
  Future<TEntity> create(TEntity entity);
  Future<TEntity> createRange(List<TEntity> entity);
  Future<TEntity> update(TEntity entity);
}
