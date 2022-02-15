import 'package:flutter/material.dart';
import 'package:flutter_arch_utils/flutter_arch_utils.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key}) : super(key: key);

  double _usableHeight = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double collapsedHeight = 80.vdp();
    double expandedHeight = 200.vdp();
    return Scaffold(
      body: ResponsiveSafeArea(
        builder: (context, size) {
          if (_usableHeight < size.height) {
            _usableHeight = size.height;
          }
          return SizedBox(
            height: _usableHeight,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: expandedHeight,
                  collapsedHeight: collapsedHeight,
                  floating: false,
                  pinned: true,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      int _flexValue = 0;
                      var totalHeight = expandedHeight - collapsedHeight;
                      var height = constraints.biggest.height - collapsedHeight;
                      _flexValue = 100 - ((height / totalHeight) * 100).toInt();

                      return Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.network(
                              "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: _flexValue, child: const SizedBox(height: 0)),
                                    const Text(
                                      "Collapsing Toolbar",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const Expanded(flex: 100, child: SizedBox(height: 0)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ) /*FlexibleSpaceBar(
                    centerTitle: true,
                    title: const Text(
                      "Collapsing Toolbar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    background: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    ),
                  )*/
                  ,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
