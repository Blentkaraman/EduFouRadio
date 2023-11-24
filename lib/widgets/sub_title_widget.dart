import 'package:flutter/widgets.dart';
import 'package:radio_app/common/colors.dart';
import 'package:radio_app/common/sizes.dart';

class SubTittleWidget extends StatelessWidget {
  const SubTittleWidget({super.key, required this.title, required this.size});
  final String title;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: vertical10,
      child: Text(
        title,
        style: TextStyle(color: whiteColor, fontSize: size),
      ),
    );
  }
}
