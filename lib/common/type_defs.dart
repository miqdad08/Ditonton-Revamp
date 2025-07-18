import 'package:ditonton_revamp/common/failure.dart';
import 'package:fpdart/fpdart.dart';


typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
