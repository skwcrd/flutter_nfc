part of widget;

class GridButtonWidget extends StatelessWidget {
  const GridButtonWidget({
    Key? key,
    this.child,
    this.color,
    this.onTap,
  }) : super(key: key);

  final Widget? child;
  final Color? color;
  final VoidCallback? onTap;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap))
      ..add(ColorProperty('color', color));
  }

  @override
  Widget build(BuildContext context) =>
    GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        clipBehavior: Clip.none,
        color: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4)),
        ),
        child: SizedBox.expand(
          child: child,
        ),
      ),
    );
}