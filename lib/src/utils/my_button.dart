
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pesu_payu/src/utils/color/colors.dart';
import 'package:pesu_payu/src/utils/my_text.dart';
import 'package:pesu_payu/src/utils/styles/my_text_styles.dart';

class MyButton extends StatefulWidget {
  final Widget? name;
  final String? label;
  final Function() onPressed;
  final Color? backgrounColor;
   final double? height;
   final double? width;
   final bool? repeat;
   final TextStyle? labelstyle;
  const MyButton({super.key,  this.name,required this.onPressed, this.backgrounColor, this.height, this.width, this.repeat, this.label, this.labelstyle});

  @override
 State<MyButton> createState() => _AnimatedTapButton1State();
}

class _AnimatedTapButton1State extends State<MyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(
  begin: 1.0,
  end: 1.1,
).animate(
  CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOut,
  ),
);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
      widget.repeat??false? _animationController.stop():_animationController.reverse();
        widget. onPressed();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () {
      
          _animationController.forward();
      HapticFeedback.selectionClick();
          // Here you can add any other actions you want to happen when the button is tapped
        },
        child: Transform.scale(
          scale: _animation.value,
          child: Container(
            height:widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              color:widget.backgrounColor?? MyColors.darkBlue1,
              borderRadius: BorderRadius.circular(1.0),
              boxShadow: const [BoxShadow(color: Colors.white)]
            ),
            padding:const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               widget.name??MyText(widget.label??'Retry', style:widget.labelstyle?? MyTextStyle.text16_700.copyWith(color: Colors.white))
      
                  // ,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
