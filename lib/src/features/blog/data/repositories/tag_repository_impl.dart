import 'package:dartz/dartz.dart';
import 'package:starter_project/src/core/error/error.dart';
import 'package:starter_project/src/core/network/network.dart';
import 'package:starter_project/src/features/blog/data/models/models.dart';
import 'package:starter_project/src/features/blog/domain/entities/tag_b.dart';

import '../../domain/repositories/tag_repository.dart';
import '../data_sources/tag_remote_data_source.dart';

class TagRepositoryImpl implements TagRepository {
  final TagRemoteDataSource remoteDataSource;
  final Network network;

  TagRepositoryImpl({
    required this.remoteDataSource,
    required this.network,
  });
  @override
  Future<Either<Failure, List<TagModel>>> viewAllTags() async {
    if (await network.isConnected) {
      try {
        final message = await remoteDataSource.viewAllTags();
        return Right(message);
      } on ServerException catch (e) {
        return Left(
            ServerFailure(errorMessage: e.errorMessage ?? "Server Error"));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Tag>> create({required String label, required String description}) async{
      if (await network.isConnected) {
      try {
        final blog = await remoteDataSource.create(
          label: label,
          description: description,
        );
        return Right(blog);
      } on ServerException catch (e) {
        return Left(
            ServerFailure(errorMessage: e.errorMessage ?? "Server Error"));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, String>> delete({required int id})async {
    if (await network.isConnected) {
      try {
        final message = await remoteDataSource.delete(
          id: id,
        );
        return Right(message);
      } on ServerException catch (e) {
        return Left(
            ServerFailure(errorMessage: e.errorMessage ?? "Server Error"));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Tag>> update({required int id, required String? label, required String? description}) async{
     if (await network.isConnected) {
      try {
        final blog = await remoteDataSource.update(
          id: id,
          label: label,
          description: description,
        );
        return Right(blog);
      } on ServerException catch (e) {
        return Left(
            ServerFailure(errorMessage: e.errorMessage ?? "Server Error"));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
