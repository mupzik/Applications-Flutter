# mobile_dev

Данный проект предназначен для обучения разработке приолжениий для мобильных устройств.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Лабораторные работы:
 1. 
    - Описать в README проект.

    - Описать в README инструкцию по установке Flutter и созданию проекта.

2. 
    - Добавить в приложение AppBar с указанием своего ФИО.

    - Выполнить задание в соответствии своему варианту.

3.
    - 


### О проекте

Разработчик: Волосикова М.А., ВМК-22

Версия: 2.0.1

Статус: в разработке.

## Лабораторная работа №1.

### Инструкция по установке Flutter в VS Code

1. Открыть меню расширений с помощью сочетания клавиш Ctrl+Shift+X 
или через Настройки -> Extensions, или нажав на иконку расширений в меню слева.  

2. В меню поиска ввести Flutter, найти расширение Flutter от издателя Dart Code,
установить расширение, нажав на кнопку Install.
Браво, вы умничка!

### Создание проекта  

1. В палитре команд (Command Pallete в верхнем меню VS Code или открыть сочетанием клавиш Ctrl+shift+P) 
ввести команду >Flutter: New Project.

2. Выбрать папку, в которой будет храниться проект. 
Только папку, название для проекта надо ввести позже!!!

3. Дать название проекту (для этого появится окно в VS Code).

4. В меню внизу выбрать окно Terminal, ввести команду flutter create my_app.  
Браво, вы умничка!

### Запуск проекта

1.1 Через Terminal в VS Code или Poweshell, открытую из папки проекта, ввести команду flutter run.

1.2 В файловом менеджере VS Code найти файл main.dart, запустить отладку кнопкой 
в правом верхнем углу экрана или клавишей F5.

2. Следуя инструкциям из консоли (п.1.1) или среды разработки (п.1.2), 
выбрать, для какого устройства запустить отладку.

3. Подождать запуска.

4. Проверить, что все работает.  
Браво, вы умничка!


## Лабораторная работа №2.

1. Создан базовый проект.

2. В приложение добавлен AppBar с указанием ФИО и номером лабораторной работы.

3. Выполнено задание в соответствии варианту (4):  
- Добавить в тело экрана виджет Stack. В виджет Stack добавить контейнеры разного размера и задать им цвета в соответствии с цветами радуги. Виджет Stack и контейнеры отцентрировать.


## Лабораторная работа №3.

1. Создан базовый проект.

2. Выполнено задание в соответствии варианту (4):  
- Реализовать калькулятор кинетической энергии. На первом экране должны располагаться 2 числовых поля ввода (масса тела и скорость), а также чек-бокс на согласие обработки данных. Реализовать валидацию полей и чек-бокса. Передать данные с первого экрана на второй экран произвести расчеты и отобразить. 


## Лабораторная работа №4.

1. Создан базовый проект.

2. Выполнено задание:
- Реализовать кубит и состояние кубита. 
- Вынести все расчеты в кубит. 
- Вместо переключения экранов приложения реализовать смену состояний.


## Лабораторная работа №5.

1. На основе проекта из лаб. №4 реализовать сохранение всех вводимых данных и результатов расчетов на основе SharedPreferences. 
3. Реализовать в кубите метод записи. 
4. Добавить новый экран, где будут выводится списком вводимые ранее данные и результаты расчетов. 
5. Для нового экрана реализовать кубит обеспечивающий загрузку данных. 
6. На первом экране в leading AppBar добавить IconButton, и при нажатии на нее используя класс Navigator открыть новый экран с результатами. 
