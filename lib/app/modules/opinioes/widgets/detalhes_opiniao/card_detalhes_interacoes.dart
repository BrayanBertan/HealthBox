import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CardDetalhesInteracoes extends StatelessWidget {
  const CardDetalhesInteracoes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 75,
      child: Align(
        alignment: Alignment.center,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              width: 150,
              height: 65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      LikeButton(
                        circleColor: CircleColor(
                            start: Colors.green.withOpacity(0.5),
                            end: Colors.green.withOpacity(0.3)),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Colors.green.withOpacity(0.7),
                          dotSecondaryColor: Colors.green,
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.thumb_up_outlined,
                            color: isLiked ? Colors.green : Colors.grey,
                          );
                        },
                        likeCount: 50,
                        countBuilder: (int? count, bool isLiked, String text) {
                          var color = isLiked ? Colors.green : Colors.grey;
                          return Text(
                            text,
                            style: TextStyle(color: color),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      LikeButton(
                        circleColor: CircleColor(
                            start: Colors.red.withOpacity(0.5),
                            end: Colors.red.withOpacity(0.3)),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Colors.red.withOpacity(0.7),
                          dotSecondaryColor: Colors.red,
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.thumb_down_alt_outlined,
                            color: isLiked ? Colors.red : Colors.grey,
                          );
                        },
                        likeCount: 50,
                        countBuilder: (int? count, bool isLiked, String text) {
                          var color = isLiked ? Colors.red : Colors.grey;
                          return Text(
                            text,
                            style: TextStyle(color: color),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
