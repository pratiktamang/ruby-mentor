import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="profile-dropdown"
export default class extends Controller {
  static targets = ["menu", "avatar", "mobileMenu"];

  connect() {
    document.addEventListener("click", this.outsideClick.bind(this));
    this.menuTarget.setAttribute("data-controller-connected", "true");
  }

  toggleMenu(event) {
    event.preventDefault();
    if (this.menuTarget.classList.contains("hidden")) {
      this.menuTarget.classList.remove("hidden");
    } else {
      this.menuTarget.classList.add("hidden");
    }
  }

  toggleMenuButton(event) {
    if (this.menuTarget.classList.contains("hidden")) {
      this.menuTarget.classList.remove("hidden");
    } else {
      this.menuTarget.classList.add("hidden");
    }
  }

  outsideClick(event) {
    let target = event.target;
    if (target === this.menuTarget || target === this.avatarTarget) {
      return;
    } else {
      this.menuTarget.classList.add("hidden");
    }
  }
}
