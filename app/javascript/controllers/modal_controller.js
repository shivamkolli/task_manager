import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    console.log("Modal connected")
  }

  open() {
    console.log("Opening modal")
    this.containerTarget.classList.remove("hidden")
  }

  close() {
    console.log("Closing modal")
    this.containerTarget.classList.add("hidden")
  }

  closeAfterSubmit(event) {
    if (event.detail.success) {
      this.close()
    }
  }
}