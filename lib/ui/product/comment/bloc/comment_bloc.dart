import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    on<CommentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
