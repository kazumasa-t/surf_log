// app/javascript/application.js

// Turbo
import "@hotwired/turbo-rails"
import "controllers"

// -------------------------------------
// Turbo読み込み完了時の共通処理
// -------------------------------------
document.addEventListener("turbo:load", () => {

  // =====================================
  // フラッシュメッセージ自動消去
  // =====================================
  document.querySelectorAll(".flash-message").forEach((flash) => {
    setTimeout(() => {
      flash.style.transition = "opacity 0.4s ease";
      flash.style.opacity = "0";
    }, 2500);

    setTimeout(() => {
      flash.remove();
    }, 3000);
  });

  // =====================================
  // 共有URLコピー処理（shareアイコン）
  // =====================================
  const shareButton = document.querySelector(".js-copy-share");
  if (!shareButton) return;

  shareButton.addEventListener("click", async () => {
    const url = shareButton.dataset.shareUrl;
    if (!url || url === "#") return;

    try {
      await navigator.clipboard.writeText(url);
      alert("今月のサーフログ共有用URLをコピーしました");
    } catch (error) {
      alert("コピーに失敗しました");
    }
  });

});
