import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../res/image/app_image.dart';
import '../../util/app_color.dart';

class AppImageWidget extends StatelessWidget {
  final String path;
  bool isAsset = true;
  Widget? placeHolder;
  Widget? errorWidget;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Color? color;
  final double? loadingSize;

  AppImageWidget.asset({
    super.key,
    required this.path,
    this.fit,
    this.width,
    this.height,
    this.color,
    this.loadingSize,
    this.isAsset = true,
  });

  AppImageWidget.network({
    super.key,
    required this.path,
    this.fit,
    this.width,
    this.height,
    this.color,
    this.errorWidget,
    this.loadingSize,
    this.placeHolder,
    this.isAsset = false,
  });

  Widget get _placeholder {
    return Center(
        child: SizedBox(
      width: loadingSize ?? 20.0.sp,
      height: loadingSize ?? 20.0.sp,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
        strokeWidth: 2,
      ),
    ));
  }

  Widget get _errorWidget {
    return const Icon(Icons.error);
  }

  Widget _buildLottieImageWidget() {
    if (isAsset) {
      return Lottie.asset(
        path,
        fit: fit,
        width: width,
        height: height,
      );
    }
    return Lottie.network(
      path,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? _errorWidget;
      },
      frameBuilder: (context, child, composition) {
        if (composition != null) {
          return Lottie(composition: composition);
        } else {
          return placeHolder ?? _placeholder;
        }
      },
    );
  }

  Widget _buildSvgImageWidget() {
    if (isAsset) {
      return SvgPicture.asset(
        path,
        fit: fit ?? BoxFit.contain,
        width: width,
        height: height,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      );
    }
    return SvgPicture.network(
      path,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      placeholderBuilder: (context) => placeHolder ?? _placeholder,
    );
  }

  Widget _buildNormalImageWidget() {
    if (isAsset) {
      return Image.asset(
        path,
        fit: fit,
        width: width,
        height: height,
      );
    }
    if (path != "") {
      return CachedNetworkImage(
        imageUrl: path,
        fit: fit,
        width: width,
        height: height,
        placeholder: (context, url) => placeHolder ?? _placeholder,
        errorWidget: (context, url, error) {
          return errorWidget ?? _errorWidget;
        },
        cacheManager: CacheManager(
          Config(
            'ImageCacheKey',
            stalePeriod: const Duration(days: 1),
          ),
        ),
      );
    } else {
      return Container(
        height: width,
        width: height,
        alignment: Alignment.center,
        child: AppImageWidget.asset(
          path: AppImage.imgLogo,
          width: (width ?? 60.sp) - 20.sp,
          height: (height ?? 60.sp) - 20.sp,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (imageType) {
      case ImageType.lottie:
        return _buildLottieImageWidget();
      case ImageType.svg:
        return _buildSvgImageWidget();
      default:
        return _buildNormalImageWidget();
    }
  }

  ImageType get imageType {
    int length = path.length;
    String lastString = path.substring(length - 5).toUpperCase();
    if (lastString.contains('.json'.toUpperCase())) {
      return ImageType.lottie;
    } else if (lastString.contains('.svg'.toUpperCase())) {
      return ImageType.svg;
    } else {
      return ImageType.image;
    }
  }
}

enum ImageType { svg, image, lottie }
