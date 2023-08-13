abstract class Usecase<O, I> {
  Future<O> call(I param);
}

class NoParams {}
