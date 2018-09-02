enum Suit {
  Diamonds,
  Hearts,
  Clubs,
  Spades,
}

class Card {
  Suit suit;
  String rank;

  Card(this.suit, this.rank);

  @override
  String toString() {
    return "$rank of ${suit}";
  }
}

class Deck {
  var cards = List<Card>();

  Deck() {
    var ranks = ["Ace", "Two", "Three", "Four", "Five"];

    for (var suit in Suit.values) {
      for (var rank in ranks) {
        var card = Card(suit, rank);
        cards.add(card);
      }
    }
  }

  @override
  String toString() {
    return cards.toString();
    // return "this is a deck";
  }

  void shuffle() {
    cards.shuffle();
  }

  Iterable<Card> cardsWithSuit(Suit suit) {
    return cards.where((card) => card.suit == suit);
  }

  deal(int handSize) {
    var hand = cards.sublist(0, handSize);
    cards = cards.sublist(handSize);
    return hand;
  }

  removeCard(String rank, Suit suit) {
    cards.removeWhere((card) => (card.rank == rank && card.suit == suit));
  }
}

void main() {
  var deck = Deck();

  print(deck.removeCard("Ace", Suit.Diamonds));

  print(deck);
  // deck.shuffle();
}
