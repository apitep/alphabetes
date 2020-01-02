class Quiz {
  Quiz(this.correct, List<String> others, this.imageUrl) {
    others = List.from(others);
    others.remove(correct);
    others = others.sublist(0, 3);
    others.add(correct);
    others.shuffle();
    others.shuffle();
    candidates = others;
  }

  String correct;
  String imageUrl;
  List<String> candidates;
}

class Animal {
  Animal(this.name, this.imageUrl, this.author);

  String name;
  String imageUrl;
  String author;

  Animal.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['image_url'];
    author = json['author'];
  }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    data['author'] = this.author;
    
    return data;
  }
}
