import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_view/photo_view.dart';

class GalleryTiles extends StatefulWidget {
  @override
  State<GalleryTiles> createState() => _GalleryTilesState();
}

const double minScale = .5;
const double defScale = .5;
const double maxScale = .5 * 5;

class _GalleryTilesState extends State<GalleryTiles> {
  late PhotoViewControllerBase controller;
  late PhotoViewScaleStateController scaleStateController;

  int calls = 0;

  @override
  void initState() {
    controller = PhotoViewController(initialScale: defScale)
      ..outputStateStream.listen(onController);

    scaleStateController = PhotoViewScaleStateController()
      ..outputScaleStateStream.listen(onScaleState);
    super.initState();
  }

  void onController(PhotoViewControllerValue value) {
    setState(() {
      calls += 1;
    });
  }

  void onScaleState(PhotoViewScaleState scaleState) {
    print(scaleState);
  }

  @override
  void dispose() {
    controller.dispose();
    scaleStateController.dispose();
    super.dispose();
  }

  //image
  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
    'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
    'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
    'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
  ];
  double _sliderDiscreteValue = 1;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Hi  ${user.email.toString()}'),
          backgroundColor: Color.fromRGBO(70, 207, 136, 50),
        ),
        body: ListView(
          children: [
            Expanded(
              child: Slider(
                activeColor: Colors.grey[700],
                value: _sliderDiscreteValue,
                min: minScale,
                max: maxScale,
                divisions: 5,
                onChanged: (double newScale) {
                  controller.scale = newScale;
                  _sliderDiscreteValue = newScale;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              child: StaggeredGridView.countBuilder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  itemCount: imageList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Container(
                              height: 300,
                              width: 300,
                              child: PhotoView(
                                controller: controller,
                                scaleStateController: scaleStateController,
                                enableRotation: true,
                                initialScale: minScale * 1.1,
                                minScale: minScale,
                                maxScale: maxScale,
                                imageProvider: NetworkImage(imageList[index]),
                              ),
                            ),
                          )

                          //old
                          // child: FadeInImage.memoryNetwork(
                          //   placeholder: kTransparentImage,
                          //   image: imageList[index],
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isEven ? 2 : 1);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
