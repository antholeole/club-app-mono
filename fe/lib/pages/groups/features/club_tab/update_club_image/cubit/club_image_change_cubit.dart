import 'package:bloc/bloc.dart';
import 'package:fe/services/clients/image_client.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fe/schema.schema.gql.dart' show GUploadType;

import '../../../../../../service_locator.dart';

import 'club_image_change_state.dart';

class ClubImageChangeCubit extends Cubit<ClubImageChangeState> {
  final _imagePicker = getIt<ImagePicker>();
  final _imageClient = getIt<ImageClient>();
  final _handler = getIt<Handler>();

  final UuidType _clubId;

  ClubImageChangeCubit({required UuidType clubId})
      : _clubId = clubId,
        super(ClubImageChangeState.notChanging());

  Future<void> updateImage() async {
    emit(ClubImageChangeState.changing());
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      emit(ClubImageChangeState.notChanging(state.image));
      return;
    }

    try {
      await _imageClient.sendImage(image, _clubId, GUploadType.GroupAvatar);
      emit(ClubImageChangeState.notChanging(await image.readAsBytes()));
    } on Exception catch (e) {
      emit(ClubImageChangeState.failure(_handler.exceptionToFailure(e)));
    }
  }
}
