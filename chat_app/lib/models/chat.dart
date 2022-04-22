class Chat {
  String image;
  String name;
  String latestMess;
  String time;
  bool isActive;

  Chat(
      {required this.image,
      required this.latestMess,
      required this.name,
      required this.time,
      required this.isActive});
}

List chatsData = [
  Chat(
    name: "Đàm Hồng Đức",
    latestMess: "Messengang chat app",
    image: "assets/images/1.png",
    time: "22:23",
    isActive: false,
  ),
  Chat(
    name: "Sơn Tùng MTP",
    latestMess: "Mốt qua nhà anh nhậu có Kay Trần với Hải Tú nè",
    image: "assets/images/2.png",
    time: "7:50",
    isActive: true,
  ),
  Chat(
    name: "B Ray",
    latestMess: "Tầm 2h chiều rảnh thì ra cafe với anh",
    image: "assets/images/3.png",
    time: "11:05",
    isActive: false,
  ),
  Chat(
    name: "H\$ Robe",
    latestMess: "Tao là tao luôn tự tin ở nơi đông người",
    image: "assets/images/4.png",
    time: "13:01",
    isActive: true,
  ),
  Chat(
    name: "Độ Mixi",
    latestMess: "Chiều ra đá bóng với anh",
    image: "assets/images/5.png",
    time: "16:24",
    isActive: false,
  ),
  Chat(
    name: "Li Wuyn",
    latestMess: "Nothing gonna f*cking stop me! Ya",
    image: "assets/images/6.png",
    time: "17:00",
    isActive: false,
  ),
  Chat(
    name: "JustaTee",
    latestMess: "Nghe bài mới của anh chưa?",
    image: "assets/images/7.png",
    time: "19:50",
    isActive: true,
  ),
  Chat(
    name: "Khói",
    latestMess: "Đến giờ phải buồn rồi em ơi",
    image: "assets/images/8.png",
    time: "00:01",
    isActive: false,
  ),
];

List searchData = [
  Chat(
    name: "B Ray",
    latestMess: "Tầm 2h chiều rảnh thì ra cafe với anh",
    image: "assets/images/3.png",
    time: "11:05",
    isActive: false,
  ),
  Chat(
    name: "H\$ Robe",
    latestMess: "Tao là tao luôn tự tin ở nơi đông người",
    image: "assets/images/4.png",
    time: "13:01",
    isActive: true,
  ),
];
