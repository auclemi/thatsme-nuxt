(function () {
  console.log("📊 stats.js chargé !");

  // UID unique par visiteur
  let uid = localStorage.getItem("uid");
  if (!uid) {
    uid = crypto.randomUUID();
    localStorage.setItem("uid", uid);
  }

  // Détecter l'URL de l'API (Nuxt runtimeConfig)
  const apiUrl = window.__NUXT__?.config?.public?.apiUrl;
  if (!apiUrl) {
    console.warn("⚠️ apiUrl introuvable dans runtimeConfig");
    return;
  }

  function sendStats() {
    const payload = {
      path: window.location.pathname,
      uid,
      ts: Date.now()
    };

    console.log("📤 Envoi stats :", payload);

    fetch(`${apiUrl}/stats`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload)
    }).catch(err => console.error("❌ Erreur stats :", err));
  }

  // Envoi initial
  sendStats();

  // Envoi sur navigation SPA (Nuxt)
  window.addEventListener("popstate", sendStats);

  // Patch pushState pour détecter les navigations internes
  const pushState = history.pushState;
  history.pushState = function () {
    pushState.apply(history, arguments);
    sendStats();
  };
})();
