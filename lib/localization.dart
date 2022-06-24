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

}

Map<Languages, Map<Messages, String>> messages = {
  Languages.ru: {},
  Languages.eo: {},
  Languages.en: {},
};
