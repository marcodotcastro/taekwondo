import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "display" ]

    connect() {
        if (this.element.dataset.timerStatus === 'in_progress') {
            this.startTimer()
        }
    }

    startTimer() {
        this.timerInterval = setInterval(() => {
            const timeDisplay = this.displayTarget.textContent
            const [minutes, seconds] = timeDisplay.split(':').map(Number)