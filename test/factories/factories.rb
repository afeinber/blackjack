FactoryGirl.define do
  factory :game do
    balance 1000

    after(:create) do |game|
      create(:deck, game: game) unless game.deck.present?
    end
  end

  factory :round do
    association :game
  end

  factory :hand do
    association :round
  end

  factory :card do
    suit 'S1'
    rank '2'
  end

  factory :deck do
    association :game

    after(:create) do |deck|
      deck.cards << create(:card, cardable: deck) if deck.cards.size == 0
    end
  end
end
