//! Abstract usecase class
abstract class Usecase<O, I> {
  Future<O> call(I param);
}

//! For when you don't have any parameters
class NoParams {}

//! Params for marking a task as completed
class MarkTaskAsCompletedParams {
  final int id;
  final bool isCompleted;

  const MarkTaskAsCompletedParams(
    this.id,
    this.isCompleted,
  );
}
