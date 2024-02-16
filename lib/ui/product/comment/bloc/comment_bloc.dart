import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_shop/data/comment.dart';
import 'package:nike_shop/data/repo/comment_repository.dart';
import 'package:nike_shop/utils/exception.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository commentRepository;
  final int productId;

  CommentBloc({required this.commentRepository, required this.productId})
      : super(CommentLoading()) {
    on<CommentEvent>((event, emit) async {
      if (event is CommentStarted) {
        try {
          emit(CommentLoading());
          final comments = await commentRepository.getAll(productId: productId);
          if (comments.isEmpty) {
            emit(CommentEmpty());
          } else {
            emit(CommentSuccess(comments: comments));
          }
        } catch (e) {
          emit(CommentError(exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
