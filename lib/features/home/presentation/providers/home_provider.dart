import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/core/network/dio_client.dart';
import 'package:pinterest_clone/features/home/data/datasources/home_remote_datasource.dart';
import 'package:pinterest_clone/features/home/data/repositories/my_repository.dart';
import 'package:pinterest_clone/features/home/domain/repositories/home_repository.dart';
import 'package:pinterest_clone/features/home/presentation/controllers/home_controller.dart';
import 'package:pinterest_clone/features/home/presentation/controllers/home_state.dart';


final dioProvider = Provider((ref) => DioClient());

final homeRemoteDataSourceProvider =
    Provider((ref) => HomeRemoteDataSource(ref.read(dioProvider)));

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => MyRepository(ref.read(homeRemoteDataSourceProvider)),
);

final homeControllerProvider =
    NotifierProvider<HomeController,HomeState>(
    HomeController.new,
);

