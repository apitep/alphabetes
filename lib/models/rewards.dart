class Rewards {
  List<String> animUrls;
  List<String> soundUrls;

  Rewards({this.animUrls, this.soundUrls});

  Rewards.fromJson(Map<String, dynamic> json) {
    if (json['anim_urls'] != null) {
      animUrls = new List<String>();
      json['anim_urls'].forEach((v) {
        animUrls.add(v);
      });
    }

    if (json['sound_urls'] != null) {
      soundUrls = new List<String>();
      json['sound_urls'].forEach((v) {
        soundUrls.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.animUrls != null) {
      data['anim_urls'] = this.animUrls.map((v) => v).toList();
    }
    if (this.soundUrls != null) {
      data['sound_urls'] = this.soundUrls.map((v) => v).toList();
    }
    return data;
  }
}