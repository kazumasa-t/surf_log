// app/javascript/application.js

import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {

  // フラッシュメッセージ自動消去
  document.querySelectorAll(".flash-message").forEach((flash) => {
    setTimeout(() => {
      flash.style.transition = "opacity 0.4s ease";
      flash.style.opacity = "0";
    }, 2500);

    setTimeout(() => {
      flash.remove();
    }, 3000);
  });

  // 共有URLコピー（トースト）
  document.querySelectorAll(".js-copy-share").forEach((shareButton) => {
    shareButton.addEventListener("click", async () => {
      const url = shareButton.dataset.shareUrl;
      const label = shareButton.dataset.shareLabel || "この月";

      if (!url || url === "#") return;

      try {
        await navigator.clipboard.writeText(url);

        showToast(
          `<span class="toast-icon">✔︎</span>${label}の共有URLをコピーしました`,
          "green darken-2"
        );

      } catch (error) {
        showToast(
          `<span class="toast-icon">✖</span>コピーに失敗しました`,
          "red darken-2"
        );
      }
    });
  });

});

// Materialize トースト表示
function showToast(message, classes = "") {
  if (window.M && typeof M.toast === "function") {
    M.toast({
      html: message,
      classes: classes,
      displayLength: 2500
    });
  } else {
    alert(message.replace(/<[^>]*>/g, ""));
  }
}
