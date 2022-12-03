import "dart:math";

const List<String> avatarList = [
  "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg",
  "https://images.all-free-download.com/images/graphiclarge/beautiful_natural_scenery_553758.jpg",
  "https://images.unsplash.com/photo-1509043759401-136742328bb3?ixlib=rb-4.0.3&w=1080&fit=max&q=80&fm=jpg&crop=entropy&cs=tinysrgb",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsc__e1wcloHuZ_h8fTwvuTrUvwh2i9vnazOohN27w-AZU-JrNJQRuGC7PJgVPTffUNec&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJGkCP9zBcldlzVK34L6ksKqX2vmjc_qUk7g&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTDJti9KRu3xeL0zvqFS09VdlZxkDF7IkVuKfahLpWMnw6RBN07gq-B8JNNrwW18CjnTs&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0NbPA6jXsDucxbDs7K3u5VXRTzxZDbf1vsA&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAYMlueYcLevB5evP8pO41vWCpO5OLJxrCaQ&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdrSFQxfty93Ofizc1YNkvslNZdLPhieNRiA&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqlgCnRecg8RgPt5sl721a9oIO2pzCEPjKSA&usqp=CAU"
];

String getAvatar(int index) {
  return avatarList[index % avatarList.length];
}

String getRandomAvatar() {
  final random = Random();
  return avatarList[random.nextInt(avatarList.length)];
}
