part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState {}

class CommentSuccess extends CommentState {
  final List<CommentEntity> comments;

  const CommentSuccess({required this.comments});
  @override
  List<Object> get props => [comments];
}

class CommentError extends CommentState {
  final AppException exception;

  const CommentError({required this.exception});

  @override
  List<Object> get props => [exception];
}

class CommentEmpty extends CommentState {}
