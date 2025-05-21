
import Foundation

final class FindParthCountGameViewModel: ObservableObject, Hashable {
    @Published var id: String
    @Published var cards: [CardViewModel] = []
    @Published var indexOfSelectedCard: Int?
    @Published var isCheckingMatch = false
    @Published var totalPairs: Int
    @Published var level: Int
    @Published var elapsedTime: Int = 0
    @Published var timerString: String = "00:00"
    @Published var isGameFinished = false
    var flipBackTimer: Timer?
    var gameTimer: Timer?

    init(id: String, cards: [CardViewModel], indexOfSelectedCard: Int? = nil, isCheckingMatch: Bool = false, totalPairs: Int, level: Int) {
        self.id = id
        self.cards = cards
        self.indexOfSelectedCard = indexOfSelectedCard
        self.isCheckingMatch = isCheckingMatch
        self.totalPairs = totalPairs
        self.level = level
    }

    func setupGame() {
        let contents = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"].shuffled().shuffled().shuffled()
        cards = []
        for i in 0 ..< totalPairs {
            let content = contents[i]
            cards.append(CardViewModel(image: content, isMatched: false, isFaceUp: false))
            cards.append(CardViewModel(image: content, isMatched: false, isFaceUp: false))
        }
        cards.shuffle()
        indexOfSelectedCard = nil
        isCheckingMatch = false
        
        resetTimer()
    }
    
    func goToNextLevel() {
        // Увеличиваем номер уровня
        level += 1
        
        // Получаем новые данные для уровня из базы данных
        let gameStorage: GameDomainModelStorage = .init()
        
        // Предполагаем, что это игра "pairs"
        if let levelData = gameStorage.read().first?.findPairsItems.first(where: { $0.level == level }) {
            // Обновляем количество пар для нового уровня
            totalPairs = levelData.pairs
            
            // Сбрасываем состояние игры
            isGameFinished = false
            
            // Перерисовываем игровое поле
            showCards()
        } else {
            // Если уровня с таким номером нет, считаем игру завершенной
            isGameFinished = true
            stopTimer()
        }
    }

    func showCards() {
        setupGame()
        
        for i in 0 ..< totalPairs * 2 {
            cards[i].isFaceUp = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.cards = self.cards.map { card in
                let mutableCard = card
                mutableCard.isFaceUp = false
                mutableCard.isMatched = false
                return mutableCard
            }
            
            self.startTimer()
        }
    }
    
    func startTimer() {
        gameTimer?.invalidate()
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self, !self.isGameFinished else { return }
            
            self.elapsedTime += 1
            self.updateTimerString()
        }
    }
    
    func stopTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
    }
    
    func resetTimer() {
        stopTimer()
        elapsedTime = 0
        updateTimerString()
    }
    
    func updateTimerString() {
        let minutes = elapsedTime / 60
        let seconds = elapsedTime % 60
        timerString = String(format: "%02d:%02d", minutes, seconds)
    }

    func choose(card: CardViewModel) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isMatched,
           !cards[chosenIndex].isFaceUp,
           !isCheckingMatch {
            
            cards[chosenIndex].isFaceUp = true
            
            if let potentialMatchIndex = indexOfSelectedCard {
                isCheckingMatch = true
                flipBackTimer?.invalidate()
                
                if cards[potentialMatchIndex].image == cards[chosenIndex].image {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.cards[potentialMatchIndex].isMatched = true
                        self.cards[chosenIndex].isMatched = true
                        self.isCheckingMatch = false
                        self.checkIfGameIsFinished()
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.cards[potentialMatchIndex].isFaceUp = false
                        self.cards[chosenIndex].isFaceUp = false
                        self.isCheckingMatch = false
                    }
                }
                indexOfSelectedCard = nil
            } else {
                indexOfSelectedCard = chosenIndex
                startFlipBackTimer(for: chosenIndex)
            }
        }
    }
    
    func startFlipBackTimer(for index: Int) {
        flipBackTimer?.invalidate()
        flipBackTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            if !self.isCheckingMatch, let selectedIndex = self.indexOfSelectedCard {
                self.cards[selectedIndex].isFaceUp = false
                self.indexOfSelectedCard = nil
            }
        }
    }

    func checkIfGameIsFinished() {
        if cards.allSatisfy({ $0.isMatched }) {
            isGameFinished = true
            stopTimer()
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: FindParthCountGameViewModel, rhs: FindParthCountGameViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.cards == rhs.cards &&
            lhs.indexOfSelectedCard == rhs.indexOfSelectedCard &&
            lhs.isCheckingMatch == rhs.isCheckingMatch &&
            lhs.totalPairs == rhs.totalPairs &&
            lhs.level == rhs.level
    }
}
