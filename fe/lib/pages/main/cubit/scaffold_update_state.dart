part of 'scaffold_update_cubit.dart';

abstract class ScaffoldUpdateState {
  Widget? endDrawer;
  String? subtitle;

  ScaffoldUpdateState({this.endDrawer, this.subtitle});
}

class ScaffoldUpdateInitial extends ScaffoldUpdateState {
  @override
  String? subtitle = 'ISU lax';
  @override
  Widget? endDrawer = Container(
    color: Color(0xffFFFFFF),
  );
}

class ScaffoldUpdate extends ScaffoldUpdateState {
  ScaffoldUpdate({Widget? endDrawer, String? subtitle})
      : super(endDrawer: endDrawer, subtitle: subtitle);
}
