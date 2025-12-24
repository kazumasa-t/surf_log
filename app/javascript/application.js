// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Auto-dismiss flash messages (Turbo対応)
document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".flash-message").forEach((flash) => {
    setTimeout(() => {
      flash.style.transition = "opacity 0.4s ease";
      flash.style.opacity = "0";
    }, 2500);

    setTimeout(() => {
      flash.remove();
    }, 3000);
  });
});