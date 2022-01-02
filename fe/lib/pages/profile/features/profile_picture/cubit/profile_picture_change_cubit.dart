import 'package:bloc/bloc.dart';
import 'package:fe/services/clients/image_client.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fe/schema.schema.gql.dart' show GUploadType;

import '../../../../../service_locator.dart';
import 'profile_picture_change_state.dart';

class ProfilePictureChangeCubit extends Cubit<ProfilePictureChangeState> {
  final _imagePicker = getIt<ImagePicker>();
  final _imageClient = getIt<ImageClient>();
  final _handler = getIt<Handler>();

  final UuidType _selfId;

  ProfilePictureChangeCubit({required UuidType selfId})
      : _selfId = selfId,
        super(ProfilePictureChangeState.notChanging());

  Future<void> updateProfilePicture() async {
    emit(ProfilePictureChangeState.changing());
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      emit(ProfilePictureChangeState.notChanging(state.image));
      return;
    }

    try {
      await _imageClient.sendImage(image, _selfId, GUploadType.UserAvatar);
      emit(ProfilePictureChangeState.notChanging(await image.readAsBytes()));
    } on Exception catch (e) {
      emit(ProfilePictureChangeState.failure(_handler.exceptionToFailure(e)));
    }
  }
}
