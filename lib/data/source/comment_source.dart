import 'package:dio/dio.dart';
import 'package:nike_shop/data/comment.dart';
import 'package:nike_shop/utils/exception.dart';

abstract class ICommentDataSource {
  Future<List<CommentEntity>> getAll({required int productId});
}

class RemoteCommentDataSource implements ICommentDataSource {
  final Dio httpClient;

  RemoteCommentDataSource({required this.httpClient});

  @override
  Future<List<CommentEntity>> getAll({required int productId}) async {
    final response =
        await httpClient.get('product/$productId/comments/?seo_url=&page=1');
    final List<CommentEntity> comments = [];
    if (response.statusCode == 200) {
      if (response.data['data']['comments'] != null) {
        for (var element in (response.data['data']['comments'] as List)) {
           comments.add(CommentEntity.fromJson(element));
        }
      }
    } else {
      return throw AppException();
    }
    return comments;
  }
}
