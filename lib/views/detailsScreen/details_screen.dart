import 'package:flutter/material.dart';
import 'package:flutter_arch_utils/flutter_arch_utils.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key, required this.imageName, required this.title}) : super(key: key);
  final String imageName;
  final String title;

  double _usableHeight = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                _getSliverAppBar(),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Stack(
                        children: [
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(0xFF4F9D82),
                            ),
                            child: Text(
                              "Something",
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  SliverAppBar _getSliverAppBar() {
    double collapsedHeight = 80.vdp();
    double expandedHeight = 200.vdp();
    return SliverAppBar(
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      floating: true,
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
                child: Image.asset(
                  imageName,
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
                        Text(
                          title,
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
      ),
    );
  }
}
