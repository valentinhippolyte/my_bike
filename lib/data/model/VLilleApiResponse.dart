class VLilleApiResponse {
  int? nhits;

  List<Records>? records;
  List<FacetGroups>? facetGroups;

  VLilleApiResponse(
      {this.nhits, this.records, this.facetGroups});

  VLilleApiResponse.fromJson(Map<String, dynamic> json) {
    nhits = json['nhits'];

    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(Records.fromJson(v));
      });
    }
    if (json['facet_groups'] != null) {
      facetGroups = <FacetGroups>[];
      json['facet_groups'].forEach((v) {
        facetGroups!.add(FacetGroups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nhits'] = nhits;

    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    if (facetGroups != null) {
      data['facet_groups'] = facetGroups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Records {
  Fields? fields;
  String? recordTimestamp;

  Records(
      {
        this.fields,

        this.recordTimestamp});

  Records.fromJson(Map<String, dynamic> json) {
    fields =
    json['fields'] != null ? Fields.fromJson(json['fields']) : null;
    recordTimestamp = json['record_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fields != null) {
      data['fields'] = fields!.toJson();
    }
    data['record_timestamp'] = recordTimestamp;
    return data;
  }
}

class Fields {
  int? nbvelosdispo;
  int? nbplacesdispo;
  int? libelle;
  String? adresse;
  String? nom;
  String? etat;
  String? commune;
  String? etatconnexion;
  String? type;
  List<double>? localisation;

  Fields(
      {this.nbvelosdispo,
        this.nbplacesdispo,
        this.libelle,
        this.adresse,
        this.nom,
        this.etat,
        this.commune,
        this.etatconnexion,
        this.type,
        this.localisation});

  Fields.fromJson(Map<String, dynamic> json) {
    nbvelosdispo = json['nbvelosdispo'];
    nbplacesdispo = json['nbplacesdispo'];
    libelle = json['libelle'];
    adresse = json['adresse'];
    nom = json['nom'];
    etat = json['etat'];
    commune = json['commune'];
    etatconnexion = json['etatconnexion'];
    type = json['type'];
    if(json.containsKey(localisation)){
      localisation = json['localisation'].cast<double>();
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nbvelosdispo'] = nbvelosdispo;
    data['nbplacesdispo'] = nbplacesdispo;
    data['libelle'] = libelle;
    data['adresse'] = adresse;
    data['nom'] = nom;
    data['etat'] = etat;
    data['commune'] = commune;
    data['etatconnexion'] = etatconnexion;
    data['type'] = type;
    data['localisation'] = localisation;
    return data;
  }
}


class FacetGroups {
  String? name;
  List<Facets>? facets;

  FacetGroups({this.name, this.facets});

  FacetGroups.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['facets'] != null) {
      facets = <Facets>[];
      json['facets'].forEach((v) {
        facets!.add(Facets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (facets != null) {
      data['facets'] = facets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Facets {
  String? name;
  int? count;
  String? state;
  String? path;

  Facets({this.name, this.count, this.state, this.path});

  Facets.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
    state = json['state'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['count'] = count;
    data['state'] = state;
    data['path'] = path;
    return data;
  }
}