import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/core/helpers/db_helper.dart';
import 'package:task_manager/core/models/user_model.dart';

final userProvider =
    StateNotifierProvider<UserState, List<UserModel>>((ref) => UserState());

class UserState extends StateNotifier<List<UserModel>> {
  UserState() : super([]);

  Future<void> refresh() async {
    final data = await DbHelper.getUsers();

    state = data.map((e) => UserModel.fromJson(e)).toList();
  }
}
