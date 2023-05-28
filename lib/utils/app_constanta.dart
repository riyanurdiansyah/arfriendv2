import '../entities/sidebar/sidebar_entity.dart';

const credentialSheet = {
  "type": "service_account",
  "project_id": "arfriend-47efa",
  "private_key_id": "83fcc0294ecf9e1c7da107950fc4dbbb5c5525f8",
  "private_key":
      "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCwoHOGfJ+CTJeu\n1nMV+fOvvgdOr5x6o86Zfzp2HjEAXGmyW4pAlUxFPN2pExJTr+bsijqX0paXe7BA\nbbDBf2gQC6YSDfIfJkIgN6wK6T1cswq2R6Jvml3fPe4A/qLuacRAtViM1wWNL9gW\nORFMEXH9EtQy+kCdooia8wUL4SbtQ1R41xR4kGStOzxRoGYhxh0mj8fl/ftMuuh0\nZJWrnKpnord4GKVIQTojfOWWQFGdGHIPhxn9kfybTY79IZVzLs3n/4JAAQmljOuB\nnB0unkSZZn/9dQLM1EHKbTQg18L7k2AOIaaRyu83olJodBlVu4HQCJyPB0rlGan+\nOdyhMOeVAgMBAAECggEAAt2TijzG3LcP5e0CQHrF5pXDahYkyIOUVD6xbN2oB1y4\ndUWRbGNPsbbfVMEjtLpfmXpToYdv3ITL8vukmLsPreT2fIf/49v7yiiFEMdAcNrR\nw2vNmZhsSfUoAZmf/JS4M6GNjnlllGkQjSm/W1fUHNo7mZkgR75tj2/+ZrcwKby9\nQAUp/e1u6dU6NllytWPCHDyjTtI8LaOfveGN8hRDvTAqJnPjyJDPzy8+0eI+MuZa\nX508WUjL672FY2pBGAvcK6SfAYuOyGSPOjLydz8zMEChVcfEiXolc5hWTCoCRXzM\nUmJpES2UOA4QGq90LW+UcyV2kJunIflkYCxMGJyKWQKBgQDdkJvUlnZ7IGVlghf3\n1HUuzaXngVMUP4rUmCnT4zvJJAGlyV11JCYqi2AoLI4FjNOqktMOKhXHbPtAubtt\nwuChYNe1hs3Wi8pAldrvXQhCAc9p57nsFj1T6AQNiNzwzDiaxA/8GogcYb0Dvw0z\npR0jxU2ZQpkBkBbEQZpw3rbNzQKBgQDME+RUBpiYpak5sF/oO0QrkIg7p8WwPwPN\n6j5KNSgKoMVIq6bYoaUc9TelH8O7r9PKr2tnA2yCGTUznP3mIGU8W6BFEasGVD7g\nbiaBBMUoGo2da3sWadwbog4qQ+B43BdXJxnsiUige2sT2pDDpbjRzGRIzdplHE3A\n0qv/IjX46QKBgAj2X4dS6soCPnfDsmqA+piBExPxREYOZ/Q/j3mVuIZjYXmuUox5\ngN25s5MMclZBIxLES6tIAoeFngg5Ox6ugl2kyDT8lfj2wKCqLyf9kGbzIcu75uZo\n4+Qv/3H4tk87Q5LnGWpuPFFBlt6+7K7JIAuhYIkxi3TnujQIH1IvgB+FAoGAfuIj\nRWbwe4AMbjTN/IrUwK1VNpoCXKlhSSbJ4cOZCLqazqsCyo/+I7oHBeBxBwG0EcHt\nahgD4AOiQ1vptKoRp2xkgm0Qw5efnFSAFhmMJ3oS8HxCBFZ/JqMkYXzgVOSqkmJa\nSOm2QSlbEvYCqdIgzjhhZa6vicwGP8v8al2v5vkCgYA3GnbvGB5gUTrYMYkOQgFd\nxlv3lnfY6u1dgbhuBFqjBq2GT2YfwvFcg6yrYL6nn96w0MgTzRvIRkyzlEn2cpcQ\nOq7fcOeuxT7McqF62Xvo486Ni7kQx8WcFbsHiSS+MHbwaVeGTK7I5ggA/EwqATCE\nr2tPlSiOgao3HZcLe88e9w==\n-----END PRIVATE KEY-----\n",
  "client_email": "arfriend@arfriend-47efa.iam.gserviceaccount.com",
  "client_id": "108096705561315499214",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url":
      "https://www.googleapis.com/robot/v1/metadata/x509/arfriend%40arfriend-47efa.iam.gserviceaccount.com"
};

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
  const SidebarEntity(
    title: "Chat-V2",
    image: "assets/images/test.webp",
    route: "stream",
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
