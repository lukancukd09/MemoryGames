

import SwiftUI
import Combine

final class RepeatAfterMeGameViewModel: ObservableObject {
    @Published var id: String
    @Published var sequence = [Int]()
    @Published var playerSequence = [Int]()
    @Published var level: Int
    @Published var timeRemaining: TimeInterval = 60
    @Published var isGameOver = false
    @Published var isShowingSequence = true
    @Published var currentStep = 0
    @Published var score: Int = 0
    @Published var lifes: Int = 3
    @Published var images = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @Published var cards: [RepeatCardViewModel] = []
    @Published var gameResult: GameResult = .none
    
    enum GameResult {
        case none
        case win
        case lose
    }

    private var timer: Timer?
    private var sequenceTimer: Timer?
    private var isTimerPaused = false
    
    // Добавляем константы для настройки скорости показа карточек
    private let baseDisplayInterval: TimeInterval = 0.5
    private let levelSpeedFactor: TimeInterval = 0.05
    
    init(id: String, level: Int) {
        self.id = id
        self.level = level
        setupCards()
    }

    func setupCards() {
        cards = []
        for i in 0..<images.count {
            cards.append(RepeatCardViewModel(
                id: UUID(),
                image: images[i],
                isFaceUp: false,
                isVisible: true
            ))
        }
    }

    func startNewGame() {
        if cards.isEmpty { setupCards() }
        resetCardStates()

        sequence = generateSequence()
        playerSequence.removeAll()

        timeRemaining = 60
        isGameOver = false
        gameResult = .none
        isShowingSequence = true
        currentStep = 0
        isTimerPaused = false
        lifes = 3  // Сбрасываем жизни при начале новой игры
        score = 0  // Сбрасываем счет

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showSequenceOfCards()
        }
    }
    
    func goToNextLevel() {
        // Сбрасываем состояние игры
        isGameOver = false
        gameResult = .none
        
        // Запускаем новую игру с текущим уровнем
        startNewGame()
    }

    private func resetCardStates() {
        for i in 0..<cards.count {
            cards[i].isFaceUp = false
            cards[i].isVisible = true
        }
    }

    private func generateSequence() -> [Int] {
        var sequence = [Int]()
        var indices = Array(0..<cards.count)

        for _ in 0..<images.count {
            let rand = Int.random(in: 0..<indices.count)
            sequence.append(indices.remove(at: rand))
        }

        return sequence
    }
    
    // Рассчитываем интервал показа карточек в зависимости от уровня
    private func calculateDisplayInterval() -> TimeInterval {
        // Чем выше уровень, тем меньше интервал (быстрее показ)
        let interval = max(baseDisplayInterval - (levelSpeedFactor * TimeInterval(level - 1)), 0.1)
        return interval
    }

    private func showSequenceOfCards() {
        sequenceTimer?.invalidate()
        let displayInterval = calculateDisplayInterval()
        var current = 0

        // Используем вычисленный интервал для таймера и анимации
        sequenceTimer = Timer.scheduledTimer(withTimeInterval: displayInterval * 2, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            if current < self.sequence.count {
                let index = self.sequence[current]

                withAnimation {
                    self.cards[index].isFaceUp = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + displayInterval) {
                    withAnimation {
                        self.cards[index].isFaceUp = false
                    }
                }

                current += 1
            } else {
                timer.invalidate()
                self.isShowingSequence = false
                self.startGameTimer()
            }
        }
    }

    private func startGameTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if !self.isTimerPaused {
                // self.timeRemaining -= 1
                if self.lifes <= 0 {
                    self.endGame(result: .lose)
                }
            }
        }
    }

    func playerTapped(card: RepeatCardViewModel) {
        if isShowingSequence { return }
        guard let index = cards.firstIndex(where: { $0.id == card.id }) else { return }

        if index == sequence[playerSequence.count] {
            withAnimation {
                cards[index].isFaceUp = true
            }

            playerSequence.append(index)
            score += 1

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    self.cards[index].isVisible = false
                }
            }

            if playerSequence.count == sequence.count {
                isTimerPaused = true
                
                // Успешное прохождение уровня
                endGame(result: .win)
                
                // Повышаем уровень при успешном прохождении
                level += 1
            }
        } else {
            let correctIndex = sequence[playerSequence.count]

            withAnimation {
                cards[index].isFaceUp = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    self.cards[index].isFaceUp = false
                }
            }

            lifes -= 1
            
            // Проверяем, не закончились ли жизни
            if lifes <= 0 {
                endGame(result: .lose)
            }
        }
    }

    func endGame(result: GameResult = .lose) {
        isGameOver = true
        gameResult = result
        timer?.invalidate()
        sequenceTimer?.invalidate()
    }
    
    // Метод для приостановки игры
    func pauseGame() {
        isTimerPaused = true
        sequenceTimer?.invalidate()
    }
    
    // Метод для возобновления игры
    func resumeGame() {
        isTimerPaused = false
        if !isShowingSequence && !isGameOver {
            startGameTimer()
        }
    }
}   
