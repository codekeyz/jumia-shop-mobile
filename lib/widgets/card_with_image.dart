import 'package:flutter/material.dart';

class CardWithImage extends StatelessWidget {
  final double cardWidth;
  final double imageHeight;
  final String title;
  final String description;
  final ImageProvider imageProvider;
  final VoidCallback onTap;

  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final CrossAxisAlignment alignment;

  const CardWithImage({
    Key? key,
    required this.cardWidth,
    required this.imageHeight,
    required this.title,
    required this.imageProvider,
    required this.onTap,
    required this.description,
    this.titleStyle,
    this.subtitleStyle,
    this.alignment = CrossAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        width: cardWidth,
        color: Colors.white,
        child: Material(
          child: InkWell(
            onTap: () => onTap(),
            child: Column(
              crossAxisAlignment: alignment,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: imageHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: alignment,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: titleStyle ??
                            Theme.of(context).textTheme.bodyText2?.copyWith(
                                  letterSpacing: 0.1,
                                ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        description,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: subtitleStyle ??
                            Theme.of(context).textTheme.bodyText2?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
