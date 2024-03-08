import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shop/data/comment.dart';
import 'package:nike_shop/data/repo/comment_repository.dart';
import 'package:nike_shop/ui/product/comment/bloc/comment_bloc.dart';
import 'package:nike_shop/ui/widgets/exception_box.dart';

class CommentListView extends StatelessWidget {
  final int productId;
  const CommentListView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final CommentBloc commentBloc = CommentBloc(
            commentRepository: commentRepository, productId: productId);
        commentBloc.add(CommentStarted());
        return commentBloc;
      },
      child: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentSuccess) {
            return SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => CommentItem(
                          data: state.comments[index],
                        ),
                    childCount: state.comments.length));
          } else if (state is CommentLoading) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CommentError) {
            return SliverToBoxAdapter(
              child: ExceptionBox(
                  exception: state.exception,
                  onPressd: () {
                    BlocProvider.of<CommentBloc>(context).add(CommentStarted());
                  }),
            );
          } else if (state is CommentEmpty) {
            return SliverToBoxAdapter(
              child: Center(child: Text('نظری برای این محصول ثبت نشده است.')),
            );
          } else {
            throw Exception('This state is not supported.');
          }
        },
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final CommentEntity data;

  const CommentItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1
          ),
          borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(data.title != '')
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,child: Text(data.title!,)),
                    const SizedBox(height: 4,),
                    Text('توسظ ${data.userName}'),
                  ],
                ),
              ),
              Text(data.date)
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(data.body)
        ],
      ),
    );
  }
}
