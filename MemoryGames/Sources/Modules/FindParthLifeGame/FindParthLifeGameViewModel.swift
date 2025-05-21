

import Foundation

final class FindParthLifeGameViewModel: ObservableObject, Hashable {
    @Published var id: String
    @Published var cards: [CardViewModel] = []
    @Published var indexOfSelectedCard: Int?
    @Published var isCheckingMatch = false
    @Published var totalPairs: Int
    @Published var level: Int
    @Published var lifes: Int = 0
    @Published var isGameFinished = false

//    let gameStorage: GameDomainModelStorage = .init()
    var flipBackTimer: Timer?

    init(id: String, cards: [CardViewModel], indexOfSelectedCard: Int? = nil, isCheckingMatch: Bool = false, totalPairs: Int, level: Int, lifes: Int = 0) {
        self.id = id
        self.cards = cards
        self.indexOfSelectedCard = indexOfSelectedCard
        self.isCheckingMatch = isCheckingMatch
        self.totalPairs = totalPairs
        self.level = level
        self.lifes = lifes
    }

    func setupGame() {
        let contents = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"].shuffled()
        cards = []
        for i in 0 ..< totalPairs {
            let content = contents[i]
            cards.append(CardViewModel(image: content, isMatched: false, isFaceUp: false))
            cards.append(CardViewModel(image: content, isMatched: false, isFaceUp: false))
        }
        cards.shuffle()
        indexOfSelectedCard = nil
        isCheckingMatch = false
    }

    func showCards() {
        setupGame()
        
        // Показываем карты
        for i in 0 ..< totalPairs * 2 {
            cards[i].isFaceUp = true
        }
        
        // Переворачиваем карты обратно через 3 секунды
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.cards = self.cards.map { card in
                let mutableCard = card
                mutableCard.isFaceUp = false
                mutableCard.isMatched = false
                return mutableCard
            }
        }
    }

    func choose(card: CardViewModel) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isMatched,
           !cards[chosenIndex].isFaceUp,
           !isCheckingMatch {
            
            cards[chosenIndex].isFaceUp = true
            
            if let potentialMatchIndex = indexOfSelectedCard {
                // Уже есть выбранная карточка, проверяем совпадение
                isCheckingMatch = true
                flipBackTimer?.invalidate() // Остановить таймер на переворот первой карточки
                
                if cards[potentialMatchIndex].image == cards[chosenIndex].image {
                    // Карточки совпали
//                    attemptСounter += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.cards[potentialMatchIndex].isMatched = true
                        self.cards[chosenIndex].isMatched = true
                        self.isCheckingMatch = false
                        self.checkIfGameIsFinished()
                    }
                } else {
                    // Карточки не совпали, переворачиваем обратно
                    lifes -= 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.cards[potentialMatchIndex].isFaceUp = false
                        self.cards[chosenIndex].isFaceUp = false
                        self.isCheckingMatch = false
                    }
                }
                indexOfSelectedCard = nil
            } else {
                // Нет второй выбранной карточки, устанавливаем таймер на переворот
                indexOfSelectedCard = chosenIndex
                startFlipBackTimer(for: chosenIndex)
            }
        }
    }
    
    func startFlipBackTimer(for index: Int) {
        flipBackTimer?.invalidate() // Останавливаем предыдущий таймер, если есть
        flipBackTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            if !self.isCheckingMatch, let selectedIndex = self.indexOfSelectedCard {
                self.cards[selectedIndex].isFaceUp = false
                self.indexOfSelectedCard = nil
            }
        }
    }

    func checkIfGameIsFinished() {
        if cards.allSatisfy({ $0.isMatched }) || lifes <= 0 {
            isGameFinished = true
        }
    }
    
//    func levelPassed() {
//        let levels = gameStorage.read()
//        guard let currentIndex = levels.firstIndex(where: { $0.id.uuidString == id }) else {
//            return
//        }
//
//        let nextIndex = levels.index(after: currentIndex)
//        guard nextIndex < levels.count else {
//            return
//        }
//
//        var currentItem = levels[currentIndex]
//        if currentItem.attemptСounter == 0 || currentItem.attemptСounter > attemptСounter {
//            currentItem.attemptСounter = attemptСounter
//        }
//        var nextItem = levels[nextIndex]
//        nextItem.isResolved = true
//
//        gameStorage.store(item: nextItem)
//        gameStorage.store(item: currentItem)
//    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: FindParthLifeGameViewModel, rhs: FindParthLifeGameViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.cards == rhs.cards &&
            lhs.indexOfSelectedCard == rhs.indexOfSelectedCard &&
            lhs.isCheckingMatch == rhs.isCheckingMatch &&
            lhs.totalPairs == rhs.totalPairs &&
            lhs.level == rhs.level
    }
}
