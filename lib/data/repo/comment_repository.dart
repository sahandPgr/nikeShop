import 'package:nike_shop/data/comment.dart';
import 'package:nike_shop/data/common/http_client.dart';
import 'package:nike_shop/data/source/comment_source.dart';

final commentRepository = CommentRepository(
    dataSource: RemoteCommentDataSource(httpClient: httpClient));

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository({required this.dataSource});
  @override
  Future<List<CommentEntity>> getAll({required int productId}) =>
      dataSource.getAll(productId: productId);
}
