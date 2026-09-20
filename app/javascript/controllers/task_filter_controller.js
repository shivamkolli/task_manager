import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["status", "priority", "task"]

  filter() {
    const selectedStatus = this.statusTarget.value
    const selectedPriority = this.priorityTarget.value

    this.taskTargets.forEach((task) => {
      const statusMatches =
        selectedStatus === "all" ||
        task.dataset.status === selectedStatus

      const priorityMatches =
        selectedPriority === "all" ||
        task.dataset.priority === selectedPriority

      task.classList.toggle(
        "hidden",
        !(statusMatches && priorityMatches)
      )
    })
  }

  reset() {
    this.statusTarget.value = "all"
    this.priorityTarget.value = "all"

    this.filter()
  }
}