import 'package:flutter/material.dart';
import 'dart:math';

// ignore: must_be_immutable
class CardScrollWidget extends StatefulWidget {

  var images;
  var padding;
  var horizontalInsetValue;
  var verticalInset;

  CardScrollWidget({this.images, this.padding, this.horizontalInsetValue, this.verticalInset});

  @override
  _CardScrollWidgetState createState() => _CardScrollWidgetState();
}

class _CardScrollWidgetState extends State<CardScrollWidget> {
  @override
  Widget build(BuildContext context) {
  var currentPage = widget.images.length - 1.0;

  PageController controller = PageController(initialPage: widget.images.length - 1);
  controller.addListener(() {
    setState(() {
      currentPage = controller.page;
    });
  });

    return Stack(
      children: <Widget>[
        CardScrollHorizontalInsetLayout(
          padding: widget.padding,
          horizontalInsetValue: widget.horizontalInsetValue,
          cards: widget.images,
          currentPage: currentPage,
          verticalInset: widget.verticalInset,
        ),
        Positioned.fill(
          child: PageView.builder(
            itemCount: widget.images.length,
            controller: controller,
            reverse: true,
            itemBuilder: (context, index) {
              return Container();
            }
          ),
        )
      ],
    );
  }
}

var cardAspectRatio = 12 / 16;
var widgetAspectRatio = 1.2 * cardAspectRatio;

// initialize variables by final to not use ignore: must_be_immutable
// ignore: must_be_immutable
class CardScrollHorizontalInsetLayout extends StatelessWidget {
  var padding;
  var horizontalInsetValue;
  var cards;
  var currentPage;
  var verticalInset;

  // final padding;
  // final horizontalInsetValue;
  // final cards;

  CardScrollHorizontalInsetLayout({this.padding, this.horizontalInsetValue, this.cards, this.currentPage, this.verticalInset});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.minHeight;

        var safeWidth = width - padding;
        var safeHeight = height - padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / horizontalInsetValue;

        List<Widget> cardList = [];
        // List<Widget> cardList = List();
        for (var i = 0; i < cards.length; i++) {
          var delta = i - currentPage;
          bool inOnRight = delta > 0;

          var start = padding + max(primaryCardLeft - horizontalInset * -delta * (inOnRight ? 15 : 1), 0.0);

          var cardItem = Positioned.directional(
            top: verticalInset + 2 * max(-delta, 0.0),
            bottom: verticalInset + 2 * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[Image.asset(cards[i], fit: BoxFit.cover)]
            ),
          );

          cardList.add(cardItem);
        }
        return Stack(
          children: cardList
        );
      }),
    );
  }
}
