import '../entities/sidebar/sidebar_entity.dart';

const String apiKey = "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";

List<SidebarEntity> listSidebar = [
  const SidebarEntity(
    title: "Home",
    image: "assets/images/test.webp",
    route: "home",
    role: 1,
  ),
  const SidebarEntity(
    title: "Train",
    image: "assets/images/test.webp",
    route: "train",
    role: 1,
  ),
  const SidebarEntity(
    title: "Chat",
    image: "assets/images/test.webp",
    route: "chat",
    role: 1,
  ),
  // const SidebarEntity(
  //   title: "History",
  //   image: "assets/images/test.webp",
  //   route: "history",
  //   role: 1,
  // ),
];

final List<String> items = [
  'Text',
  'File',
  'Sheet',
];

List<String> listRole = [
  "All",
  "CEO",
  "Manager",
  "Staff",
];

List<String> listDivisi = [
  "SOP",
  "Tech",
  "HR",
  "BO",
  "Product",
  "Academic",
];
