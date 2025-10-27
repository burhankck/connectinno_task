import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectinno_task/core/constants/padding_constant.dart';
import 'package:connectinno_task/core/constants/sizedbox_constant.dart';



class <FTName | pascalcase>View extends StatelessWidget {
  const <FTName | pascalcase>View ({Key? key}) : super(key: key);

    @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('')),
        body: Padding(
          padding: PaddingConstant.instance.pagePadding,
          child: Column(children: [
            SizedBoxConstant.instance.sized12h,
            Container(), //Container -> BlocConsumer or BlocBuilder
          ]),
        ),
      );
  }

}
