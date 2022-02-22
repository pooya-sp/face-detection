import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Masks',
              ),
              Tab(
                text: 'Filters',
              ),
              Tab(
                text: 'Effects',
              ),
            ],
          ),
        ),
        body: TabBarView(children: []),
      ),
    );
  }
}
