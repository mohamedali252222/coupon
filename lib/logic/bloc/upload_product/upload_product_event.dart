part of 'upload_product_bloc.dart';

abstract class UploadProductEvent extends Equatable {
  const UploadProductEvent();

  @override
  List<Object?> get props => [];
}

class GetSelectProductTypeInfoEvent extends UploadProductEvent {}

class GetEditProductInfoEvent extends UploadProductEvent {
  final String id;

  const GetEditProductInfoEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UploadProductThumbImageEvent extends UploadProductEvent {
  final String thumbImage;

  const UploadProductThumbImageEvent(this.thumbImage);

  @override
  List<Object?> get props => [thumbImage];
}

class UploadProductIconEvent extends UploadProductEvent {
  final String productIcon;

  const UploadProductIconEvent(this.productIcon);

  @override
  List<Object?> get props => [productIcon];
}

class UploadProductFileEvent extends UploadProductEvent {
  final String uploadFile;

  const UploadProductFileEvent(this.uploadFile);

  @override
  List<Object?> get props => [uploadFile];
}

class UploadProductNameEvent extends UploadProductEvent {
  final String name;

  const UploadProductNameEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class UploadProductSlugEvent extends UploadProductEvent {
  final String slug;

  const UploadProductSlugEvent(this.slug);

  @override
  List<Object?> get props => [slug];
}

class UploadProductCategoryEvent extends UploadProductEvent {
  final String category;

  const UploadProductCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class UploadProductPreviewLinkEvent extends UploadProductEvent {
  final String previewLink;

  const UploadProductPreviewLinkEvent(this.previewLink);

  @override
  List<Object?> get props => [previewLink];
}

class UploadProductTypeEvent extends UploadProductEvent {
  final String type;

  const UploadProductTypeEvent(this.type);

  @override
  List<Object?> get props => [type];
}

class UploadProductRegularPriceEvent extends UploadProductEvent {
  final String regularPrice;

  const UploadProductRegularPriceEvent(this.regularPrice);

  @override
  List<Object?> get props => [regularPrice];
}

class UploadProductExtendPriceEvent extends UploadProductEvent {
  final String extendPrice;

  const UploadProductExtendPriceEvent(this.extendPrice);

  @override
  List<Object?> get props => [extendPrice];
}

class UploadProductDescriptionEvent extends UploadProductEvent {
  final String description;

  const UploadProductDescriptionEvent(this.description);

  @override
  List<Object?> get props => [description];
}

class UploadProductTagsEvent extends UploadProductEvent {
  final String tags;

  const UploadProductTagsEvent(this.tags);

  @override
  List<Object?> get props => [tags];
}

class UploadProductSeoTitleEvent extends UploadProductEvent {
  final String seoTitle;

  const UploadProductSeoTitleEvent(this.seoTitle);

  @override
  List<Object?> get props => [seoTitle];
}

class UploadProductSeoDescriptionEvent extends UploadProductEvent {
  final String seoDescription;

  const UploadProductSeoDescriptionEvent(this.seoDescription);

  @override
  List<Object?> get props => [seoDescription];
}

class UploadProductHighResolutionEvent extends UploadProductEvent {
  final String highResolution;

  const UploadProductHighResolutionEvent(this.highResolution);

  @override
  List<Object?> get props => [highResolution];
}

class UploadProductCrossBrowserEvent extends UploadProductEvent {
  final String crossBrowser;

  const UploadProductCrossBrowserEvent(this.crossBrowser);

  @override
  List<Object?> get props => [crossBrowser];
}

class UploadProductDocumentationEvent extends UploadProductEvent {
  final String documentation;

  const UploadProductDocumentationEvent(this.documentation);

  @override
  List<Object?> get props => [documentation];
}

class UploadProductLayoutEvent extends UploadProductEvent {
  final String layout;

  const UploadProductLayoutEvent(this.layout);

  @override
  List<Object?> get props => [layout];
}

class UploadProductSubmitEvent extends UploadProductEvent {
  final String type;

  const UploadProductSubmitEvent(this.type);

  @override
  List<Object?> get props => [type];
}

class UpdateProductSubmitEvent extends UploadProductEvent {
  final String id;
  final String type;

  const UpdateProductSubmitEvent(this.id, this.type);

  @override
  List<Object?> get props => [id, type];
}

class UploadProductClearFormEvent extends UploadProductEvent {
  const UploadProductClearFormEvent();
}

class UploadProductDeleteEvent extends UploadProductEvent {
  final String id;

  const UploadProductDeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}
