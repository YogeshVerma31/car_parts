import 'package:dartz/dartz.dart';

import 'failure.dart';

typedef EitherRequest<T> = Future<Either<Failure, T>>;
typedef EitherRequest2<T> = Either<Failure, T>;
