import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "display" ]

    connect() {
        if (this.element.dataset.timerStatus === 'in_progress') {
            this.startTimer()
        }
    }

    disconnect() {
        if (this.timerInterval) {
            clearInterval(this.timerInterval)
        }
    }

    startTimer() {
        // Limpa qualquer intervalo existente
        if (this.timerInterval) {
            clearInterval(this.timerInterval)
        }

        this.timerInterval = setInterval(() => {
            const timeDisplay = this.displayTarget.textContent
            const [minutes, seconds] = timeDisplay.split(':').map(Number)

            let totalSeconds = minutes * 60 + seconds
            if (totalSeconds > 0) {
                totalSeconds -= 1
                const newMinutes = Math.floor(totalSeconds / 60)
                const newSeconds = totalSeconds % 60

                this.displayTarget.textContent =
                    `${String(newMinutes).padStart(2, '0')}:${String(newSeconds).padStart(2, '0')}`

                // Se chegou a zero, finaliza a luta automaticamente
                if (totalSeconds === 0) {
                    this.finishMatch()
                }
            }
        }, 1000)
    }

    finishMatch() {
        clearInterval(this.timerInterval)

        // Pega o ID da luta do dataset
        const matchId = this.element.dataset.timerMatchId

        // Faz a requisição para finalizar a luta
        fetch(`/matches/${matchId}/stop`, {
            method: 'POST',
            headers: {
                'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        }).then(response => {
            if (!response.ok) {
                console.error('Erro ao finalizar a luta')
            }
        })
    }
}