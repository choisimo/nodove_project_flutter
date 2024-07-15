import 'package:flutter/material.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/view/collected/minimalrow.dart';

class CollectedRow extends StatelessWidget {
  final Feed props;

  const CollectedRow({Key? key, required this.props}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;
  
    return Stack(
      children: [
        SizedBox(
          width : maxwidth,
          height : maxwidth,
          child: Image.network(
            props.imageLinks[0],
            fit : BoxFit.cover,
            errorBuilder :(context, error, stackTrace){
              return Image.asset("assets/images/logo.png",fit : BoxFit.cover);
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          child : MinimalRow(props : props)
        ),
      ],
    );
  }
}