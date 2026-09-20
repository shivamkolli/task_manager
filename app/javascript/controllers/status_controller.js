import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="status"
export default class extends Controller {
  update() {
    this.element.requestSubmit()
  }
}
