part of "./dashboard.dart";

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var controller = Get.put(DashboardController());

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MainScaffold(
        type: "default",
        colorBackground: Utility.baseColor2,
        returnOnWillpop: false,
        backFunction: () {},
        colorSafeArea: Utility.baseColor2,
        content: Column(
          children: [
            SizedBox(
              height: Utility.large,
            ),
            _widgetInformasiUser(),
            SizedBox(
              height: Utility.extraLarge,
            ),
            Flexible(
                child: Padding(
              padding:
                  EdgeInsets.only(left: Utility.medium, right: Utility.medium),
              child: _widgetListBanner(),
            )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ButtonSheetWidget().validasiButtomSheet(
                "Tambah Banner", _widgetAddBanner(), "hidden", () => null);
          },
          backgroundColor: Utility.maincolor1,
          child: Icon(
            Iconsax.add_circle5,
            color: Utility.baseColor1,
          ),
        ),
      ),
    );
  }

  Widget _widgetInformasiUser() {
    return Padding(
      padding: EdgeInsets.only(left: Utility.medium, right: Utility.medium),
      child: ExpandedView2Row(
          flexLeft: 85,
          flexRight: 15,
          widgetLeft: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextLabel(
                text: controller.email.value,
                color: Utility.baseColor1,
              ),
              SizedBox(
                height: Utility.small,
              ),
              TextLabel(
                text: controller.name.value,
                color: Utility.baseColor1,
              ),
            ],
          ),
          widgetRight: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: InkWell(
                  onTap: () => ButtonSheetWidget().validasiButtomSheet(
                      "Logout",
                      const TextLabel(text: "Are you sure Logout Account ?"),
                      "Logout",
                      () => controller.logoutAccount()),
                  child: Icon(
                    Iconsax.logout5,
                    color: Utility.baseColor1,
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _widgetListBanner() {
    return ListView.builder(
        itemCount: controller.listBanner.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          String namaBanner = controller.listBanner[index].bannerName;
          String urlImage = controller.listBanner[index].bannerImage;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Utility.small,
              ),
              Image.network(urlImage),
              SizedBox(
                height: Utility.small,
              ),
              TextLabel(
                text: namaBanner,
                color: Utility.baseColor1,
              ),
              Divider(
                color: Utility.baseColor1,
                thickness: 1.0,
              )
            ],
          );
        });
  }

  Widget _widgetAddBanner() {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextLabel(text: "Nama Banner"),
          SizedBox(
            height: Utility.small,
          ),
          TextFieldMain(
            controller: controller.nameBanner.value,
            validator: (value) {
              return Validator.required(
                  value, "Nama banner tidak boleh kosong");
            },
          ),
          SizedBox(
            height: Utility.medium,
          ),
          const TextLabel(text: "Gambar Banner"),
          SizedBox(
            height: Utility.small,
          ),
          Obx(
            () => InkWell(
              onTap: () {
                if (controller.base64BannerSelected.value.isEmpty) {
                  setState(() {
                    controller.takePicture();
                  });
                }
              },
              child: controller.base64BannerSelected.value.isEmpty
                  ? Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 150,
                        child: Image.asset("assets/no-image.png"),
                      ),
                    )
                  : Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.center,
                          image: MemoryImage(
                            base64Decode(controller.base64BannerSelected.value),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: Utility.large,
          ),
          Button1(
              colorBtn: Utility.maincolor1,
              contentButton: TextLabel(
                text: "Tambah Banner",
                color: Utility.baseColor1,
              ),
              onTap: () {
                if (controller.nameBanner.value.text == "" ||
                    controller.base64BannerSelected.value.isEmpty) {
                  UtilsAlert.showToast("Harap lengkapi form terlebih dahulu");
                } else {
                  controller.addBanner();
                }
              }),
          SizedBox(
            height: Utility.large,
          ),
        ],
      );
    });
  }
}
