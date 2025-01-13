import 'package:equatable/equatable.dart';
import 'package:fav_movies/core/common/exceptions/app_exception.dart';

part '../success_result.dart';
part '../fail_result.dart';

abstract class IResponseResult<DataType extends Object> extends Equatable{
  void resolve({
    required void Function(AppException error) onFail,
    required void Function(DataType data) onSuccess,
  }){
    try{
      if(this is Success){
        return onSuccess((this as Success<DataType>).data);
      }

      if(this is Fail){
        return onFail((this as Fail).error);
      }
    }catch(e){
      AppException(id: e, method: resolve, namespace: this);
    }
  }
}