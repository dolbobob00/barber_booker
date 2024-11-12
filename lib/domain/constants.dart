String user = 'user';
String admin = 'admin';
String barber = 'barber';

enum UserStatus {
  none,
  user,
  barber,
  admin,
}

const String assetName = 'assets/icons/other/hairstyle.svg';
const List<String> globalServices = [
  'Уход за волосами',
  'Уход за бородой и усами',
  'Уход за кожей лица',
  'Уход за руками',
  'Премиальные и комплексные услуги',
  'Дополнительные услуги для комфорта клиентов'
];
const List<String> globalServicesImagesUrl = [
  'https://avatars.mds.yandex.net/i?id=077e53ff212fa55e4f567fa021d52483_l-11389740-images-thumbs&n=13',
  'https://instagram.ftse3-2.fna.fbcdn.net/v/t51.29350-15/435243865_454500406927634_4054397398939861693_n.jpg?stp=c0.133.1066.1066a_dst-jpg_e35_s640x640_sh0.08&_nc_ht=instagram.ftse3-2.fna.fbcdn.net&_nc_cat=102&_nc_ohc=x5YqpxHf2wMQ7kNvgGRqKe9&_nc_gid=b363e146586d46eeae659025f1db6da3&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AYBS3bpbOlWs0RT2hqX6AjMkuze7W_oneT2dlvR4r2c2aQ&oe=67364CBD&_nc_sid=8b3546',
  'https://instagram.ftse3-2.fna.fbcdn.net/v/t51.29350-15/434051733_1571643777020258_3897006579641867991_n.jpg?stp=c0.882.2268.2268a_dst-jpg_e35_s640x640_sh0.08&_nc_ht=instagram.ftse3-2.fna.fbcdn.net&_nc_cat=102&_nc_ohc=RYArVsgppRIQ7kNvgEVZlcC&_nc_gid=b363e146586d46eeae659025f1db6da3&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AYDDvrUHN8buokp5W9QeV_pPLOTT7ns5YyrApIftHW7zug&oe=6736349C&_nc_sid=8b3546',
  'https://i.pinimg.com/originals/15/65/c3/1565c35ad011a4a639a7a062089b03c3.jpg',
  'https://burobiz-a.akamaihd.net/uploads/images/168533/large_17d7306e264ac2fed78642a2784e73f4.jpg',
  'https://instagram.ftse3-2.fna.fbcdn.net/v/t51.29350-15/433382533_428589383021755_88714534510164698_n.jpg?stp=c0.882.2268.2268a_dst-jpg_e35_s640x640_sh0.08&_nc_ht=instagram.ftse3-2.fna.fbcdn.net&_nc_cat=107&_nc_ohc=KCFSrElTz8UQ7kNvgHDdf4H&_nc_gid=b363e146586d46eeae659025f1db6da3&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AYB_50vwsmaRe_CpuuJW66HC1YDY2IVYtrQzSKaX2-H2wA&oe=673655AF&_nc_sid=8b3546',
];

Map<String, int> dayToNumber = {
  "Пн": 1,
  "Вт": 2,
  "Ср": 3,
  "Чт": 4,
  "Пт": 5,
  "Сб": 6,
  "Вс": 7,
};
  //todo sometime integrate this shit.///....