// ignore_for_file: always_use_package_imports

import 'localization.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class L10nRu extends L10n {
  L10nRu([String locale = 'ru']) : super(locale);

  @override
  String get signInText => 'Войти через Google';

  @override
  String get continueMailText => 'Продолжить работу с почтой';

  @override
  String get singUpText => 'Зарегистрируйтесь через Google';

  @override
  String get signInhere => 'Войдите здесь';

  @override
  String get signUpHere => 'Зарегистрируйтесь здесь';

  @override
  String get createGroup => 'Создайте новый групповой чат';

  @override
  String get contacts => 'Контакты';

  @override
  String get search => 'Поиск';

  @override
  String get group => 'Группа';

  @override
  String get groupName => 'Название группы';

  @override
  String get enterEmail => 'Введите свой адрес электронной почты';

  @override
  String get enterPassword => 'Введите свой пароль';

  @override
  String get errorImages => 'Ошибка загрузки изображений';

  @override
  String get noImages => 'Изображения не были отправлены';

  @override
  String get or => 'или';

  @override
  String get haveAccount => 'Нет учетной записи?';

  @override
  String get alreadyHave => 'Уже есть учетная запись?';

  @override
  String get talky => 'Talky';

  @override
  String get resetText => 'Введите email, чтобы отправить письмо для сброса пароля';

  @override
  String get likSended => 'Ссылка отправлена';

  @override
  String get send => 'Отправить';

  @override
  String get agreeTerm => 'Я согласен с условиями и положениями';

  @override
  String get back => 'Назад';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get signInMail => 'Войти через';

  @override
  String get signUpMail => 'Зарегистрироваться через';

  @override
  String get signIn => 'Войти';

  @override
  String get signUp => 'Зарегистрироваться';

  @override
  String get enterDigit => 'Введите 4-значный код, который мы отправили вам';

  @override
  String get inCorrect => 'Электронная почта или пароль неверны';

  @override
  String get unableStorage => 'Невозможно получить доступ к внешнему хранилищу';

  @override
  String get permissionNotGranted => 'Разрешение на доступ к хранилищу не предоставлено';

  @override
  String get message => 'Сообщение';

  @override
  String get users => 'Пользователи';

  @override
  String get files => 'Файлы';

  @override
  String get online => 'В сети';

  @override
  String get errorGettingMessage => 'Ошибка при получении сообщения';

  @override
  String get noData => 'Нет данных';

  @override
  String get chat => 'Чат';

  @override
  String get logOut => 'Выйти';
}
