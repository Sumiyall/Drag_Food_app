import 'package:flutter/material.dart';
import 'customer.dart';
import 'item.dart';
import 'login.dart';
import 'order.dart';

void main() {
  runApp(
    MaterialApp(
      home: LoginPage(),
    ),
  );
}

const List<Item> _items = [
  // hoolnii itemuudaa listeer zarlaj medeelliig n gargaj baina
  Item(
    name: 'Цуйван',
    totalPriceCents: 699,
    uid: '1',
    imageProvider: NetworkImage(
        'https://hanza38.ru/wp-content/uploads/2020/07/YOoXSqUXx9U.jpg'), //Zurgiin zamiiig n interneteer zaaj ugj import hiij baina
  ),
  Item(
    name: 'Хуушуур',
    totalPriceCents: 799,
    uid: '2',
    imageProvider: NetworkImage(
        'https://margaash.live/wp-content/uploads/2019/07/jijig-huushuur-e1562295778493.jpg'),
  ),
  Item(
    name: 'Бууз',
    totalPriceCents: 699,
    uid: '3',
    imageProvider: NetworkImage(
        'https://news.mn/wp-content/uploads/2019/02/1487825117_shutterstock_47006419-booz-810x450.jpg'),
  ),
  Item(
    name: 'Банштай Шөл',
    totalPriceCents: 649,
    uid: '4',
    imageProvider: NetworkImage(
        'https://www.ugluu.mn/wp-content/uploads/2015/03/2811423625682.jpg'),
  ),
  Item(
    name: 'Борш шөл',
    totalPriceCents: 699,
    uid: '5',
    imageProvider:
        NetworkImage('https://khaanbuuz.mn/img/products/price/BRLP7442_2.jpg'),
  ),
  Item(
    name: 'Хуйцаа',
    totalPriceCents: 799,
    uid: '6',
    imageProvider:
        NetworkImage('https://www.ub.life/uploads/images/ub%20huitsaa%203.jpg'),
  ),
  Item(
    name: 'Боодог',
    totalPriceCents: 1099,
    uid: '7',
    imageProvider:
        NetworkImage('https://pbs.twimg.com/media/D_fk-kxUYAEUHNJ.jpg'),
  ),
];

@immutable
class ExampleDragAndDrop extends StatefulWidget {
  final TextEditingController emailController;

  // Stateful widget ees udamshuulj uusgsen.
  const ExampleDragAndDrop({Key? key, required this.emailController})
      : super(key: key);

  @override
  State<ExampleDragAndDrop> createState() =>
      _ExampleDragAndDropState(); //ExampleDragAndDrop iig uusgeh uyd tuunees udamshij bui classiin objectiig baiguulna
}

class _ExampleDragAndDropState
    extends State<ExampleDragAndDrop> // deerh classaas udamshuulj uusgsen class
    with
        TickerProviderStateMixin {
  late String _emailController = widget.emailController.text;
  late List<Customer> _people;
  @override
  void initState() {
    super.initState();
    _emailController = widget.emailController.text;
    _people = [
      Customer(
        name: _emailController,
        imageProvider: const NetworkImage(
            'https://geo.greenheart.org/UploadedPhotos/163313-Photo-638335736686361692.jpg'),
      ),
    ];
  }

  final GlobalKey _draggableKey = GlobalKey();

  void _itemDroppedOnCustomerCart({
    // drag hiigdsen item CustoCart deer buuh uyd n nemeh function
    required Item item, // drop hiigdej bga item
    required Customer customer, // item drop hiigdej bga Customer
  }) {
    setState(() {
      // tuluviiig n uurchilj baina
      customer.items
          .add(item); // tuhain item-iig hereglegchiin listend nemj baina
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF7F7F7), // background ungiig n tohiruulj ugj baina
      appBar:
          _buildAppBar(), //appbar-iig baiguulj bga functioniig duudaj appbar uusgej baina
      body:
          _buildContent(), // menulist bolon humuusiin jagsaaltiig aguulj bga body hesgiig baiguulj bui functioniig duudaj baina
    );
  }

  PreferredSizeWidget _buildAppBar() {
    // appbar baiguulah function
    return AppBar(
      iconTheme: const IconThemeData(color: Color(0xFFF64209)),
      title: Text(
        'Захиалгын хоол',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 34,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
      ),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            };
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          )),
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
    );
  }

  Widget _buildContent() {
    // undsen body hesgiig haruulah function
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child:
                    _buildMenuList(), // menu-g baiguulj bui function iig duudaj baina
              ),
              _buildPeopleRow(), // door n hargadah Customeriig haruulah hesgiin function
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuList() {
    // Listview ashiglan
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 12,
        );
      },
      itemBuilder: (context, index) {
        final item = _items[index];
        return _buildMenuItem(
          item: item,
        );
      },
    );
  }

  Widget _buildMenuItem({
    required Item item, // haragdah itemuud
  }) {
    return LongPressDraggable<Item>(
      // menuList deer haragdah itemuudiig chirdeg bolgoj baina
      data: item,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: DraggingListItem(
        dragKey: _draggableKey,
        photoProvider: item.imageProvider,
      ),
      child: MenuListItem(
        name: item.name,
        price: item.formattedTotalItemPrice,
        photoProvider: item.imageProvider,
      ),
    );
  }

  Widget _buildPeopleRow() {
    return Container(
      // Customer-uudiig hadgalah Container uusgej baina
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 20,
      ),
      child: Row(
        children: _people
            .map(_buildPersonWithDropZone)
            .toList(), // baganii daguu _buildPerDropZone function ashiglan buulgaj baina
      ),
    );
  }

  Widget _buildPersonWithDropZone(Customer customer) {
    // drop hiij buulgah
    return Expanded(
      // child widget n parent widget dotroo urgutgusun baidlaar ih zaitai garna
      child: Padding(
          padding: const EdgeInsets.symmetric(
            // irmeg burees n padding avj baina
            horizontal: 6,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderPage(
                          customerName: _emailController,
                          selectedFood: customer.items.toList(),
                        )),
              );
            },
            child: DragTarget<Item>(
              builder: (context, candidateItems, rejectedItems) {
                return CustomerCart(
                  hasItems: customer.items.isNotEmpty,
                  highlighted: candidateItems.isNotEmpty,
                  customer: customer,
                );
              },
              onAccept: (item) {
                _itemDroppedOnCustomerCart(
                  item: item,
                  customer: customer,
                );
              },
            ),
          )),
    );
  }
}

class CustomerCart extends StatelessWidget {
  const CustomerCart({
    super.key, // superclass-aas udamshij bui key parameter
    required this.customer,
    this.highlighted = false,
    this.hasItems = false,
  });

  final Customer customer; // customer-iig hadgalah huvisagch
  final bool
      highlighted; // drag ochh uyd sags todorsn esehiig hadgalah boolean huvisasgch. Default utga n false baigaa
  final bool hasItems; // cart-d items bga esehiig hadgalah huvisagch

  @override
  Widget build(BuildContext context) {
    final textColor = highlighted
        ? Colors.white
        : Colors
            .black; // herev highlight bolovol text color n white, ugui bval black bolno

    return Transform.scale(
      scale: highlighted
          ? 1.075
          : 1.0, // hervee drag hiiged highlight bolsn bval scale buyu arai 1.075 dahin tom bolgj haragduulna
      child: Material(
        elevation: highlighted ? 8 : 4, //suuder
        borderRadius:
            BorderRadius.circular(22), //border radiusiig n tohiruulj ugj baina
        color: highlighted
            ? const Color(0xFFF64209)
            : Colors
                .white, // highlight bolvl background ungiig n tohiruulj baina
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal:
                12, // hevtee baidliin 12 bosoo baidlaar 24 pixel column widget-iig wrap hiij baina
            vertical: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                // profile zurag n dugui helbereeer 46x46 gargaj baina
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Image(
                    image: customer
                        .imageProvider, // hereglegchiiin image haragduulj baina
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                  height: 8), // zurag text(name) 2iin hoorond zai avj baina
              Text(
                // name ee tohiruulj baina
                customer.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: textColor,
                      fontWeight:
                          hasItems ? FontWeight.normal : FontWeight.bold,
                    ),
              ),
              Visibility(
                visible: hasItems,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: Column(
                  // item orsn esehiig haruulah
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      customer.formattedTotalItemPrice,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${customer.items.length} item${customer.items.length != 1 ? 's' : ''}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: textColor,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    Key? key,
    this.name = '',
    this.price = '',
    required this.photoProvider,
    this.isDepressed = false,
  }) : super(key: key);

  final String name; // item name
  final String price; // Item Price
  final ImageProvider photoProvider; // ItemPhoto iin hadgalah huvisagch
  final bool isDepressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12, // suuderiig n zaaj ugj baina
      borderRadius:
          BorderRadius.circular(20), // gadnah container-iin border radius
      child: Padding(
        padding: const EdgeInsets.all(12), //padding
        child: Row(
          mainAxisSize: MainAxisSize.max, // murnii huvid bga buh zaig avna
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12), // zuragnii border radius
              child: SizedBox(
                width: 120, //image container-iin undur, urt
                height: 120,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    height: isDepressed ? 115 : 120,
                    width: isDepressed ? 115 : 120,
                    child: Image(
                      image:
                          photoProvider, // photoprovider aar orj irsn zurag haruulna
                      fit: BoxFit
                          .cover, // container ee duurgesen zurag n orj irne
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                // zuragnii hajuud bui item iin ner bolon price-iig bagana helbereer bairluulj baina s
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    price,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.photoProvider,
  });

  final GlobalKey dragKey; // chireh uyd zoriulsan globalKey-g barih huvisagch
  final ImageProvider photoProvider;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          // drag hiigsen uyiin urt, undur
          height: 150,
          width: 150,
          child: Opacity(
            // opacity iig n bagasgaj baina
            opacity: 0.85,
            child: Image(
              image: photoProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
