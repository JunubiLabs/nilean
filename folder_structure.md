### **Folder Structure**
```
lib/
├── blocs/
│   ├── auth/
│   │   ├── auth_bloc.dart
│   │   ├── auth_event.dart
│   │   ├── auth_state.dart
│   ├── chat/
│   │   ├── chat_bloc.dart
│   │   ├── chat_event.dart
│   │   ├── chat_state.dart
│   ├── news/
│   │   ├── news_bloc.dart
│   │   ├── news_event.dart
│   │   ├── news_state.dart
│   └── theme/
│       ├── theme_bloc.dart
│       ├── theme_event.dart
│       ├── theme_state.dart
├── models/
│   ├── chat_message.dart
│   ├── news_article.dart
├── repositories/
│   ├── auth_repository.dart
│   ├── chat_repository.dart
│   ├── news_repository.dart
├── ui/
│   ├── pages/
│   │   ├── splash_page.dart
│   │   ├── home_page.dart
│   │   ├── chat_page.dart
│   │   ├── news_page.dart
│   │   ├── settings_page.dart
│   ├── widgets/
│       ├── chat_bubble.dart
│       ├── news_card.dart
│       ├── custom_app_bar.dart
├── utils/
│   ├── constants.dart
│   ├── theme.dart
│   ├── helpers.dart
├── main.dart
└── app.dart
```