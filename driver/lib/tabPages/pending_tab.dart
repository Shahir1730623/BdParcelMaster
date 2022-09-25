import 'package:driver/widgets/pending_design_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../infoHandler/app_info.dart';
import '../widgets/history_design_ui.dart';


class PendingTabPage extends StatefulWidget {
  const PendingTabPage({Key? key}) : super(key: key);

  @override
  State<PendingTabPage> createState() => _PendingTabPageState();
}

class _PendingTabPageState extends State<PendingTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
            "Pending List"
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: ()
          {
            SystemNavigator.pop();
          },
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, i)=> const Divider(
          color: Colors.white,
          thickness: 2,
          height: 2,
        ),
        itemBuilder: (context, i)
        {
          return Card(
            color: Colors.white,
            child: PendingHistortyDesignUIWidget(
              tripsHistoryModel: Provider.of<AppInfo>(context, listen: false).allPendingHistoryInformationList[i],
            ),
          );
        },
        itemCount: Provider.of<AppInfo>(context, listen: false).allPendingHistoryInformationList.length,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }
}
