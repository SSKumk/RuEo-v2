import 'dart:core';

enum Languages {
  ru, // Russian
  eo, // Esperanto
  en, // English
}

enum Messages {
  badState, // Internal error: bad state
  typeInvitation, // Invitation to type a word
  noSuggestions, // No suggestions are loaded
  suggestionLoadError, // Error during loading the hints
  strangeStateOfSuggestionLoad, // just what it is
  noArticle, // No article is loaded
  articleLoadError, // Error during loading the article
  strangeStateOfArticleLoad, // just what it is
  mailAboutVocabulary, // A mail to the authors of the vocabulary
  mailAboutApp, // A mail to the authors of the application
  settings, // Settings
  help, // Help
  settingsTitle, // Title of the settings screen
}

Map<Languages, Map<Messages, String>> messages = {
  Languages.ru: {
    Messages.badState: "Неверное состояние",
    Messages.typeInvitation: "Наберите слово",
    Messages.noSuggestions: "Нет подсказок",
    Messages.suggestionLoadError: "Ошибка при загрузке подсказок",
    Messages.strangeStateOfSuggestionLoad:
        "Неверное состояние загрузки подсказок",
    Messages.noArticle: "Статья не загружена",
    Messages.articleLoadError: "Ошибка загрузки статьи",
    Messages.strangeStateOfArticleLoad: "Неверное состояние закрузки статьи",
    Messages.mailAboutVocabulary: "Авторам словаря",
    Messages.mailAboutApp: "Авторам приложения",
    Messages.settings: "Настройки",
    Messages.help: "Помощь",
    Messages.settingsTitle: "Настройки программы",
  },
//
  Languages.eo: {
    Messages.badState: "Malĝusta stato",
    Messages.typeInvitation: "Tajpu vorton",
    Messages.noSuggestions: "Ne estas sugestoj",
    Messages.suggestionLoadError: "Eraro dum alŝutado de sugestoj",
    Messages.strangeStateOfSuggestionLoad:
        "Malĝusta stato dum alŝutado de sugestoj",
    Messages.noArticle: "Ne estas artikolo",
    Messages.articleLoadError: "Eraro dum alŝutado de artikolo",
    Messages.strangeStateOfArticleLoad:
        "Malĝusta stato dum alŝutado de artikolo",
    Messages.mailAboutVocabulary: "Al aŭtoroj de vortaro",
    Messages.mailAboutApp: "Al aŭtoroj de apo",
    Messages.settings: "Agordoj",
    Messages.help: "Helpo",
    Messages.settingsTitle: "Agordoj de apo",
  },
//
  Languages.en: {
    Messages.badState: "Bad state",
    Messages.typeInvitation: "Type a word",
    Messages.noSuggestions: "No suggests",
    Messages.suggestionLoadError: "Error loading suggests",
    Messages.strangeStateOfSuggestionLoad: "Bad state of loading suggests",
    Messages.noArticle: "No article",
    Messages.articleLoadError: "Error loading article",
    Messages.strangeStateOfArticleLoad: "Bad state of loading article",
    Messages.mailAboutVocabulary: "To authors of vocabulary",
    Messages.mailAboutApp: "To authors of program",
    Messages.settings: "Settings",
    Messages.help: "Help",
    Messages.settingsTitle: "Program settings",
  },
};
