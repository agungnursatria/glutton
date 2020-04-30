# Glutton

Flutter shared preferences customized plugin. Secure, Encrypted, Simplified use, Simple key-value pairs storage.

## Getting Started

In your flutter project add the dependency:

```yml
dependencies:
  ...
  glutton: ^1.0.3
```

## Usage
#### Importing package
```dart
import 'package:glutton/glutton.dart';
```
#### Using Glutton

#### Saving data inside glutton
```dart
bool isSuccess = await Glutton.eat(key, data);
```
#### Retrieve data inside glutton
```dart
dynamic data = await Glutton.vomit(key);
```
#### Check if data is exist inside glutton
```dart
bool isExist = await Glutton.have(key);
```
#### Remove data inside glutton
```dart
bool isSuccess = await Glutton.digest(key);
```
#### Clear all data inside glutton
```dart
await Glutton.flush();
```

## Can we save class object?
The current answer is **no**.

Written in [JSON and Serialization](https://flutter.dev/docs/development/data-and-backend/json), flutter doesn't provide library like GSON or Moshi. Such a library would require using runtime reflection, which is disabled in Flutter. So we can't automatically turn class into json or the opposite, but we need to transform it manual first to edible data type.

## Edible data type 
- List
- Set
- Map (can eat json here)
- DateTime
- String
- bool
- int (can eat enum index here)
- double
- Uri

## Example 
#### [Save & retrieve class](https://github.com/agungnursatria/glutton/blob/master/example/lib/eat_class)

Save:
```dart
/// 1. Create user object
User user = User(
  name: "Gentleton",
  age: 21,
  createdAt: DateTime.now(),
);

/// 2. Transform user object to map
Map<String, dynamic> userMap = user.toJson();

/// 3. Save user map inside glutton
bool isSuccess = await Glutton.eat(<UserKey>, userMap);
```

Retrieve
```dart
/// 1. Retrieve user map inside glutton
Map<String, dynamic> userMap = await Glutton.vomit(<UserKey>);

/// 2. Transform user map to user object
User user = User.fromJson(userMap);
```

#### [Save & retrieve date](https://github.com/agungnursatria/glutton/blob/master/example/lib/eat_date/eat_date_page.dart)

Save:
```dart
/// 1. Set selected date
DateTime date = await showDatePicker(
  context: context,
  initialDate: _selectedDate,
  firstDate: DateTime(1990),
  lastDate: DateTime(2030),
);

/// 2. Save selected date inside glutton
await Glutton.eat(<DateKey>, date);
```

Retrieve
```dart
/// 1. Retrieve user map inside glutton
DateTime date = await Glutton.vomit(<DateKey>);
```

#### [Save & retrieve enum](https://github.com/agungnursatria/glutton/blob/master/example/lib/eat_enum)

Save:
```dart
/// 1. Retrieve index of enum
int index = Season.index;

/// 2. Save index inside glutton
await Glutton.eat(<enumKey>, index);
```

Retrieve
```dart
/// 1. Retrieve index inside glutton
int index = await Glutton.vomit(<enumKey>);

/// 2. Transform index to enum
Season _season = SeasonManager.fromIndex(index); 
```
You can follow [Season enum](https://github.com/agungnursatria/glutton/blob/master/example/lib/eat_enum/enum_season.dart) for step 2 retrieve enum